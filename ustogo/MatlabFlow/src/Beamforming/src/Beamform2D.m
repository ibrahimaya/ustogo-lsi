%%  Copyright (C) 2014-2018  EPFL
%   ustogo: ultrasound processing Matlab pipeline
%  
%   Permission is hereby granted, free of charge, to any person
%   obtaining a copy of this software and associated documentation
%   files (the "Software"), to deal in the Software without
%   restriction, including without limitation the rights to use,
%   copy, modify, merge, publish, distribute, sublicense, and/or sell
%   copies of the Software, and to permit persons to whom the
%   Software is furnished to do so, subject to the following
%   conditions:
%  
%   The above copyright notice and this permission notice shall be
%   included in all copies or substantial portions of the Software.
%  
%   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
%   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
%   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
%   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
%   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
%   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
%   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
%   OTHER DEALINGS IN THE SOFTWARE.
%
%% B-mode 2D ultrasound image beamforming based on RF data matrix.
%
% Inputs: probe - Description of the probe
%         target_phantom - Phantom name
%         apod_full - the apodization-law matrix ("full" as we don't
%                     exploit symmetry to shrink it, yet)
%         el_max - the outermost element that must be included in
%                  beamforming calculations (depends on time and element
%                  directivity)
%         rx_delay - The RX delay-law matrix
%         downsampling_factor - If downsampling is used, what the
%                               downsampling factor is (1 = no downsampling)
%         zone_count - If zone imaging is requested (zone_count > 1), how many zones the
%                      image should contain
%         compounding_count - If compound imaging is requested (compounding_count > 1), how
%                             many insonifications to compound
%         with_brightness_compensation - Whether to apply a brightness compensation
%         brightness_comp - Brightness compensation map due to non-even field
%                           focusing
%         image - A structure with fields describing the desired output
%                 resolution
%         with_exact_delays - 1: use precise calculation of delays (with a
%                             square root), 0: use an approximation (delay steering)
%         dump_fpga_verification_outputs - 1: modify the code to skip a few
%                                          steps that are not performed in
%                                          FPGA and dump extra outputs for
%                                          RTL generation/verification,
%                                          0: normal behaviour
%
% Outputs: bf_im - Base frequency image after beamforming and low-pass filtering
%          offset_min, offset_max - For every radial line of the output
%                                   image, the min and max sample delays
%                                   that were used to pick in the RF set
%                                   (info only valid if
%                                   dump_fpga_verification_outputs == 1)

function [bf_im, offset_min, offset_max] = Beamform2D(probe, target_phantom, apod_full, el_max, rx_delay, downsampling_factor, zone_count, compounding_count, with_brightness_compensation, brightness_comp, image, with_exact_delays, dump_fpga_verification_outputs)

    cd(fileparts(mfilename('fullpath')));
    
    if (~exist('brightness_comp', 'var') && with_brightness_compensation == 1)
        error('Need a brightness compensation map.')
    end
        
    simulate_fixed_point_representation = 0;
    % Defines a signed 13.4 representation
    integer_fixed_point_representation = 13;
    fractional_fixed_point_representation = 4;
    fp_representation = fixdt(1, 1 + integer_fixed_point_representation + fractional_fixed_point_representation, fractional_fixed_point_representation);
    
    c = probe.c;                         % Speed of sound [m/s]
    f_us = probe.f0;                     % Center RF frequency [Hz]
    fs = floor(probe.fs / downsampling_factor); % RX sampling frequency [Hz]
    ts = 1 / probe.fs;                   % RX sampling interval [s]
    n_el = probe.N_elements;             % Number of transducer elements
    % Whether to use phase correction in case downsampling is used
    use_phase_correction = 0;
    
    n_col = probe.N_elements;
    n_row = 1;
    % These variables are extracted to speed up the parallel computation below
    xoff = probe.width / 2 - probe.transducer_width / 2;
    xpitch = probe.pitch;
    width = probe.width;
    
    % Filter parameters
    hp_fc = min(fs / 2, f_us / 2);       % High-pass imaging filter cutoff frequency
    
    [~, ~, image_upper_limit_N, image_lower_limit_N, xz_sector, ~] = GetPhantomCoordinates(probe, image);
    if (probe.linear == 1)
        % By default, one image line per element. Can be changed up or down.
        % However, if a different number of lines is chosen in the
        % "with_exact_delays == 0" mode, the InitializeBeamforming step
        % should be adjusted so that the resolution of the precalculated
        % RX delay table is an integer multiple of the chosen number of lines.
        azimuth_lines = n_el;
        azimuth_line_pitch = probe.transducer_width / azimuth_lines;
    else
        if (image.azimuth_lines == -1)
            azimuth_lines = round(xz_sector * 180 / pi); % By default, one image line per degree
        else
            azimuth_lines = image.azimuth_lines;
        end
    end
    radial_lines = image.radial_lines;
    
    % max_radius will be used not to get out-of-bounds errors in calculation
    [max_radius, rows, columns, ~, max_values] = LoadRFDataMatrixMetadataFromDisk(target_phantom);
    currently_loaded_insonification_index = 0;

    if (dump_fpga_verification_outputs == 1)
        % For this dump, just look at insonification 1, if there's more.
        zone = 1;
        % Precision of the system ADCs, in bits
        % Use consistently with GeneratePlatformHDL.m, DebugRTL.m
        adc_precision = 16;
        % Normalize the RF values so that the maximum-amplitude echoes
        % almost saturate the ADCs
        maxrange = 2 ^ (adc_precision - 1);
        amplif_factor = maxrange / max_values(zone);
        rf = LoadRFDataMatrixFromDisk(target_phantom, zone, max_radius, rows, columns);
        rf = rf * amplif_factor;
        % For debugging the content of the BRAMs on the FPGA
        shrunk_rf = zeros(columns, 1024);
        shrunk_rf(:, 1 : min(max_radius, 1024)) = rf(1, :, 1 : min(max_radius, 1024));
        save('../data/rf_data.mat', 'shrunk_rf');
        clear rf shrunk_rf;
    end
    
    %% Time-Gain Compensation (TGC) vector: compensate RX amplitudes for propagation attenuation
    atten_dB_cm = 1;                       % Attenuation coefficient [dB/cm]
    tgc = 10.^(atten_dB_cm / 20 * c * (1 : max_radius) * ts * 1e2);
    % With expanding apertures, the energy loss at shallow depths must be
    % compensated with a gain of sqrt(1/N) where N is the count of used elements
    % Further normalized by sqrt(n_el) so that if the aperture is always
    % full, this compensation is equal to 1 everywhere
    apodization_compensation_factor = sqrt(n_el) .* sqrt((1 ./ (2 * el_max + 2))');
    % This can happen if the phantom is deeper than the imaging region
    if (size(tgc, 2) > size(apodization_compensation_factor, 2))
        apodization_compensation_factor = [apodization_compensation_factor ones(1, size(tgc, 2) - size(apodization_compensation_factor, 2))];
    end
    % The "/ 2" is just to have an extra bit of dynamic range on FPGA
    % so that we don't risk oversaturating some echoes (e.g. when they
    % already approach the ADC's saturation limit and the TGC amplifies
    % them). It does not affect the outcomes of the Matlab simulation.
    tgc = tgc .* apodization_compensation_factor(1 : size(tgc, 2)) / 2;
    % Now reshape the matrix
    tgc_elements = ones(n_el, 1) * tgc;
    tgc_elements_matrix = reshape(tgc_elements, n_row, n_col, max_radius);
    % TGC will be applied once the data matrix "rf" is loaded, below.
    clear tgc_elements;
    
    %% Apply downsampling to the input data
    % The max downsampling should preserve 2 * f_max of the original
    % signal; since it is centered at f_us, assuming a bandwidth of
    % f_us too, that is 2 * (f_us * 1.5)
    % TODO this will not work now. Adjust to support the RF-data-loading-
    % from-disk mechanism
    if (downsampling_factor > 1)
        max_ds_factor = fs * downsampling_factor / (3 * f_us);
        if (downsampling_factor > max_ds_factor)
            error('Attempted to apply a downsampling %d greater then the maximum allowed one (%d)', downsampling_factor, max_ds_factor);
        end
        % Adjust image boundaries and drop data samples. Do nothing if downsampling_factor == 1.
        downsampled_depth = floor(size(rf, 2) / downsampling_factor) + 1;
        r1 = zeros(size(rf, 1), downsampled_depth, size(rf, 3));
        for count = 1 : downsampled_depth
            original_depth = ((count - 1) * downsampling_factor) + 1;
            r1(:, count, :) = rf(:, original_depth, :);
        end
        rf = r1;
        clear r1;
        image_upper_limit_N = ceil(image_upper_limit_N / downsampling_factor);
        image_lower_limit_N = floor(image_lower_limit_N / downsampling_factor);
    end
    
    %% High-pass filter the RF data to remove amplifier saturation artifacts
    filterOrder_hp = 4;
    wn_hp = 2 / fs * hp_fc;
    [b_hp, a_hp] = butter(filterOrder_hp, wn_hp, 'high'); % define the high pass filter
    % The filter itself will be applied once the data matrix "rf" is loaded, below.
    
    %% Further preparation before phased-array beamforming
    focal_points_per_depth = (image_lower_limit_N - image_upper_limit_N) / radial_lines;
    
    % Shrink the size of matrices used in the following, in order to save memory.
    el_max_shrunk = zeros(1, radial_lines);
    apod_full_shrunk = zeros(size(apod_full, 1), radial_lines);
    rx_delay_shrunk = zeros(size(rx_delay, 1), radial_lines);
    for radius_index = 1 : radial_lines
        radius_index_scaled = (round(radius_index * focal_points_per_depth) + image_upper_limit_N - 1);
        el_max_shrunk(radius_index) = el_max(radius_index_scaled);
        apod_full_shrunk(:, radius_index) = apod_full(:, radius_index_scaled);
        if (simulate_fixed_point_representation == 1)
            rx_delay_shrunk(:, radius_index) = num2fixpt(rx_delay(:, radius_index_scaled), fp_representation, 0, 'Nearest');
        else
            rx_delay_shrunk(:, radius_index) = rx_delay(:, radius_index_scaled);
        end
    end
    clear apod_full el_max rx_delay;
    sampling_indices = (round((1 : radial_lines) * focal_points_per_depth) + image_upper_limit_N - 1);
    tx_delay_shrunk = zeros(azimuth_lines, radial_lines);
    % Compound imaging: the full TX delay table will be loaded from disk
    % per-insonification.
    % Else, zone imaging (edge case single-zone imaging): the full TX delay
    % table can be constructed by stitching parts of the TX delay table,
    % loaded from disk, of each zone.
    if (compounding_count == 1)
        for zone_index = 1 : zone_count
            tx_delay_shrunk_zone = LoadShrunkTXDelayFromDisk(target_phantom, zone_index, sampling_indices);
            if (simulate_fixed_point_representation == 1)
                tx_delay_shrunk_zone = num2fixpt(tx_delay_shrunk_zone, fp_representation, 0, 'Nearest');
            end
            azimuth_line_bottom = floor(azimuth_lines / zone_count * (zone_index - 1)) + 1;
            azimuth_line_top = floor(azimuth_lines / zone_count * zone_index);
            tx_delay_shrunk(azimuth_line_bottom : azimuth_line_top, :) = tx_delay_shrunk_zone(azimuth_line_bottom : azimuth_line_top, :);
            clear tx_delay_shrunk_zone;
        end
    end
    
    %% MAIN LOOP: Beamforming via delay & sum
    % 2D if zone imaging; 3D if compounding, but will be shrunk back to normal if compounding_count == 1
    bf_im = squeeze(zeros(radial_lines, azimuth_lines, compounding_count));
    min_offset = zeros(1, radial_lines) + 1e10;
    max_offset = zeros(1, radial_lines);
    
    d_theta = xz_sector / azimuth_lines;
    theta_start = - xz_sector / 2 + d_theta / 2;
    % Initialize the beamformed (but still RF) image to zero.
    % Note that the image excludes any deep cropping area, but still
    % includes the shallow cropping areas (if any). This is just for
    % readability and convenience. The shallow cropping areas will not
    % be beamformed anyway (for performance) and will be cropped below.
    % Extra dimension if compounding, but will be shrunk back to normal if compounding_count == 1
    rf_im = zeros(radial_lines, azimuth_lines, compounding_count);
    
    % TODO this should be a parfor like in 3D, but error on the use of
    % rx_delay_steered.
    % Main loop on azimuth lines
    for compounding_index = 1 : compounding_count
        if (compounding_count > 1)
            tx_delay_shrunk = LoadShrunkTXDelayFromDisk(target_phantom, compounding_index, sampling_indices);
            if (simulate_fixed_point_representation == 1)
                tx_delay_shrunk = num2fixpt(tx_delay_shrunk, fp_representation, 0, 'Nearest');
            end
            disp(['Beamforming compound frame ', num2str(compounding_index), ' of ', num2str(compounding_count)]);
        end
        
        for azimuth_index = 1 : azimuth_lines
            theta = theta_start + (azimuth_index - 1) * d_theta;
            disp(['Beamforming azimuth line ', num2str(azimuth_index), ' of ', num2str(azimuth_lines)]);
            
            zone_index = floor((azimuth_index - 1) / (azimuth_lines / zone_count)) + 1;
            if (zone_count > 1)
                % disp(['Zone ', num2str(zone_index), ' of ', num2str(zone_count)]);
            end
            insonification_index = (compounding_index - 1) * zone_count + zone_index;
            
            if (insonification_index ~= currently_loaded_insonification_index)
                % Loads on-demand new RF data, to keep memory use in check.
                % rf - Radio-frequency matrix containing the raw data of the
                % backscattered echoes (M*N*O, where M*N is the number of probe elements,
                % and O is the number of time samples)
                rf = LoadRFDataMatrixFromDisk(target_phantom, insonification_index, max_radius, rows, columns);
                currently_loaded_insonification_index = insonification_index;
                % Apply TGC
                rf = tgc_elements_matrix .* rf;
                % Apply highpass filtering
                if (dump_fpga_verification_outputs == 1)
                else
                    for col = 1 : n_col
                        rf(1, col, :) = filtfilt(b_hp, a_hp, rf(1, col, :));
                    end
                end
            end
            
            if (probe.linear == 0 && with_exact_delays == 0)
                % Update the precomputed delay table by adding a "steering"
                % delay value, depending on the angle of the current line of sight,
                % that models the return time delta with respect to the base table
                rx_delay_steered = rx_delay_shrunk;
                for loopc = 1 : n_col
                    if (simulate_fixed_point_representation == 1)
                        added_delay_azimuth_n = num2fixpt(((loopc - 1) * xpitch + xoff) * sin(theta) * (fs * downsampling_factor) / c, fp_representation, 0, 'Nearest');
                        rx_delay_steered(loopc, :) = num2fixpt(rx_delay_steered(loopc, :) - added_delay_azimuth_n, fp_representation, 0, 'Nearest');
                    else
                        added_delay_azimuth_n = ((loopc - 1) * xpitch + xoff) * sin(theta) * (fs * downsampling_factor) / c;
                        rx_delay_steered(loopc, :) = rx_delay_steered(loopc, :) - added_delay_azimuth_n;
                    end
                end
                
                %% Debug features
                % Collects data used by the plotting code at the end of the function
                if (0)
                    % Store the steered delay table at the mid-radius depth
                    total_delay_n(azimuth_index, :) = rx_delay_steered(:, round(size(rx_delay_steered, 2) / 2));
                end
            end
            
            % Apply Selfridge and Kino directivity model to elements. Since
            % steered lines of sight are attenuated due to element directivity,
            % we should compensate for that here.
            x = f_us / c * width * sin(theta);
            directivity_factor = 1 / (sinc(x) * cos(theta));
            if (dump_fpga_verification_outputs == 1)
                apod_with_directivity = apod_full_shrunk;
            else
                apod_with_directivity = apod_full_shrunk * directivity_factor;
            end
            
            % Inner loop along depth
            rf_line = zeros(radial_lines, 1);
            for radius_index = 1 : radial_lines
                if (probe.linear == 0)
                    % Figure out the outermost elements that are relevant to
                    % reconstruct this point, depending on time and directivity
                    % (as encoded in el_max)
%                    radius_index_scaled = (round(radius_index * focal_points_per_depth) + image_upper_limit_N - 1);
%                    r = radius_index_scaled / 2 * c * ts;
%                    xS = r * sin(theta);
%                    element_facing = round((xS + probe.transducer_width / 2 - probe.width / 2) / probe.pitch);
%                    apodization_radius_index = round(radius_index * cos(theta));
%                    center_apodization_line = size(apod_with_directivity, 1) / 2 + 0.5;
%                    el_inf_columns = max(1, element_facing - el_max_shrunk(apodization_radius_index));
%                    el_sup_columns = min(n_el, element_facing + el_max_shrunk(apodization_radius_index) + 1);
                    el_inf_columns = n_col / 2 - el_max_shrunk(radius_index);
                    el_sup_columns = n_col / 2 + el_max_shrunk(radius_index) + 1;
                    d_Tx = tx_delay_shrunk(azimuth_index, radius_index);
                    drx = zeros(n_col, 1);
                    if (with_exact_delays == 1)
                        radius_index_scaled = (round(radius_index * focal_points_per_depth) + image_upper_limit_N - 1);
                        r = radius_index_scaled / 2 * c * ts;
                        xS = r * sin(theta);
                        zS = r * cos(theta);
                    
                        % Innermost loops on aperture
                        for el_column = el_inf_columns : el_sup_columns
                            xD = (el_column - 1) * xpitch + xoff;
                            % Sum to the point of the RF image "el_column", delayed and apodized
                            d_Rx = sqrt((xS - xD) ^ 2 + zS ^ 2) * fs / c;
                            delay = round(d_Tx + d_Rx);
                            if (dump_fpga_verification_outputs == 1)
                                min_offset(radius_index) = min(delay, min_offset(radius_index));
                                max_offset(radius_index) = max(delay, max_offset(radius_index));
                            end

                            if (delay <= max_radius && delay > 0)
                                % rf_line(radius_index) = rf_line(radius_index) + apod_with_directivity(center_apodization_line + el_column - element_facing, apodization_radius_index) * rf(1, el_column, delay);
                                rf_line(radius_index) = rf_line(radius_index) + apod_with_directivity(el_column, radius_index) * rf(1, el_column, delay);
                                drx(el_column) = d_Rx;
                            end
                        end
                        
                        %% Debug features
                        % Collects data used by the plotting code at the end of the function
                        if (0)
                            if (radius_index == round(radial_lines / 2))
                                % Store the exact delay table at the mid-radius depth
                                total_delay_n(azimuth_index, :) = drx';
                            end
                        end
                    elseif (with_exact_delays == 0)
%                        apodization_radius_index = round(radius_index * cos(theta));
%                        center_apodization_line = size(apod_with_directivity, 1) / 2 + 0.5;
                        % Innermost loops on aperture
                        for el_column = el_inf_columns : el_sup_columns
                            d_Rx = rx_delay_steered(el_column, radius_index);
                            if (simulate_fixed_point_representation == 1)
                                delay = round(num2fixpt(d_Tx + d_Rx, fp_representation, 0, 'Nearest'));
                            else
                                delay = round(d_Tx + d_Rx);
                            end
                            if (dump_fpga_verification_outputs == 1)
                                min_offset(radius_index) = min(delay, min_offset(radius_index));
                                max_offset(radius_index) = max(delay, max_offset(radius_index));
                            end
                            if (delay <= max_radius && delay > 0)
                                if (downsampling_factor > 1 && use_phase_correction == 1)
                                    % In this code branch, matrix "rf" is complex-valued and must be multiplied by
                                    % a complex exponent to be able to correct the phase offsets.
                                    delta_ts = (round(d_Tx + d_Rx) - (d_Tx + d_Rx)) * ts;
                                    correction_factor = exp(-1j * 2 * pi * f_us * delta_ts);
                                else
                                    correction_factor = 1;
                                end
                                % rf_line(radius_index) = rf_line(radius_index) + apod_with_directivity(center_apodization_line + el_column - element_facing, apodization_radius_index) * rf(1, el_column, delay) * correction_factor;
                                rf_line(radius_index) = rf_line(radius_index) + apod_with_directivity(el_column, radius_index) * rf(1, el_column, delay) * correction_factor;
                           end
                        end
                    end
                elseif (probe.linear == 1 && with_exact_delays == 1)
                    d_Tx = tx_delay_shrunk(azimuth_index, radius_index);
                    drx = zeros(1, n_el);
                    radius_index_scaled = (round(radius_index * focal_points_per_depth) + image_upper_limit_N - 1);
                    r = radius_index_scaled / 2 * c * ts;
                    xS = - probe.transducer_width / 2 + (azimuth_index - 0.5) * azimuth_line_pitch;
                    zS = r;
                    
                    % Figure out the outermost elements that are relevant to
                    % reconstruct this point, depending on time and directivity
                    % (as encoded in el_max)
                    element_facing = round((xS + probe.transducer_width / 2 - probe.width / 2) / probe.pitch);
                    el_inf_columns = max(1, element_facing - el_max_shrunk(radius_index));
                    el_sup_columns = min(n_el, element_facing + el_max_shrunk(radius_index) + 1);
                    % Innermost loops on aperture
                    for el_column = el_inf_columns : el_sup_columns
                        xD = (el_column - 1) * xpitch + xoff;
                        % Sum to the point of the RF image "el_column", delayed and apodized
                        d_Rx = sqrt((xS - xD) ^ 2 + zS ^ 2) * fs / c;
                        delay = round(d_Tx + d_Rx);
                        if (delay <= max_radius && delay > 0)
                            rf_line(radius_index) = rf_line(radius_index) + apod_with_directivity(min(2 * n_el - 1, max(1, el_column + n_el - element_facing)), radius_index) * rf(1, el_column, delay);
                            drx(el_column) = d_Rx;
                        end
                    end
                    
                    %% Debug features
                    % Collects data used by the plotting code at the end of the function
                    if (0)
                        if (radius_index == round(radial_lines / 2))
                            % Store the exact delay table at the mid-radius depth
                            total_delay_n(azimuth_index, :) = drx;
                        end
                    end
                elseif (probe.linear == 1 && with_exact_delays == 0)
                    d_Tx = tx_delay_shrunk(azimuth_index, radius_index);
                    xS = - probe.transducer_width / 2 + (azimuth_index - 0.5) * azimuth_line_pitch;
                    
                    % Figure out the outermost elements that are relevant to
                    % reconstruct this point, depending on time and directivity
                    % (as encoded in el_max)
                    element_facing = round((xS + probe.transducer_width / 2 - probe.width / 2) / probe.pitch);
                    el_inf_columns = max(1, element_facing - el_max_shrunk(radius_index));
                    el_sup_columns = min(n_el, element_facing + el_max_shrunk(radius_index) + 1);
                    % Innermost loops on aperture
                    for el_column = el_inf_columns : el_sup_columns
                        % Sum to the point of the RF image "el_column", delayed and apodized
                        % TODO this line of code assumes azimuth_lines == n_el
                        d_Rx = rx_delay_shrunk(abs(el_column - azimuth_index) + 1, radius_index);
                        delay = round(d_Tx + d_Rx);
                        if (delay <= max_radius && delay > 0)
                            if (downsampling_factor > 1 && use_phase_correction == 1)
                                % In this code branch, matrix "rf" is complex-valued and must be multiplied by
                                % a complex exponent to be able to correct the phase offsets.
                                delta_ts = (round(d_Tx + d_Rx) - (d_Tx + d_Rx)) * ts;
                                correction_factor = exp(-1j * 2 * pi * f_us * delta_ts);
                            else
                                correction_factor = 1;
                            end
                            rf_line(radius_index) = rf_line(radius_index) + apod_with_directivity(min(2 * n_el - 1, max(1, el_column + n_el - element_facing)), radius_index) * rf(1, el_column, delay) * correction_factor;
                        end
                    end
                end
            end
            rf_im(:, azimuth_index, compounding_index) = rf_line;
        end
    end
    
    bf_im = rf_im;
    offset_min = min_offset';
    offset_max = max_offset';
    
    %% Brightness Compensation
    if (probe.linear == 0 && with_brightness_compensation == 1)
        % The brightness compensation map has dimensions [depth, theta, zone]
        for zone = 1 : zone_count
            theta_start = 1 + floor((zone - 1) * azimuth_lines / zone_count);
            theta_end = min(floor(zone * azimuth_lines / zone_count), theta_start + size(brightness_comp, 2) - 1);
            % 1 value per mm, from image_upper_limit_N to image_lower_limit_N
            compensation = brightness_comp(:, 1 : (theta_end - theta_start + 1), zone);
            depth_samples = size(compensation, 1);
            % radial_lines values, from image_upper_limit_N to image_lower_limit_N
            compensation_scaled = ones(radial_lines, theta_end - theta_start + 1);
            for radius_index = 1 : radial_lines
                compensation_scaled(radius_index, :) = compensation(max(1, round(radius_index * depth_samples / radial_lines)), :);
            end
            bf_im(:, theta_start : theta_end) = bf_im(:, theta_start : theta_end) .* compensation_scaled;
        end
    end
    
    %% Demodulate and low-pass filter
    for compounding_index = 1 : compounding_count
        % Reusing the same data structure bf_im saves memory.
        if (dump_fpga_verification_outputs)
            % Demodulation method 7 -> abs + FIR lowpass
            bf_im(:, :, compounding_index) = DemodulateRFImage(probe, bf_im(:, :, compounding_index), focal_points_per_depth, use_phase_correction, 7);
        else
            % Demodulation method 0 -> IQ + Butterworth lowpass
            bf_im(:, :, compounding_index) = DemodulateRFImage(probe, bf_im(:, :, compounding_index), focal_points_per_depth, use_phase_correction, 2);
        end
        % This behaves numerically like:
        % for azimuth_index = 1 : azimuth_lines
        %    bf_im(:, azimuth_index, compounding_index) = DemodulateRFImage(probe, bf_im(:, azimuth_index, compounding_index), ...);
        % end
    end
    
    %% Debug features
    % Requires enabling the data collection inside the loop, too
    if (0)
        if (probe.linear == 0)
            figure, imagesc(total_delay_n);
        end
    end
    
    cd(fileparts(mfilename('fullpath')));
    if (probe.linear == 1)
        save('../data/bf_im_linear.mat', 'bf_im');
    else
        save('../data/bf_im_phased.mat', 'bf_im');
    end
end
