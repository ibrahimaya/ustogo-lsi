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
%% B-mode 3D ultrasound image beamforming based on RF data matrix.
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
%                      image should contain (zone_count * zone_count)
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

function [bf_im, offset_min, offset_max] = Beamform3D(probe, target_phantom, apod_full, el_max, rx_delay, downsampling_factor, zone_count, compounding_count, with_brightness_compensation, brightness_comp, image, with_exact_delays, dump_fpga_verification_outputs)

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
    n_el = probe.N_elements_x * probe.N_elements_y;             % Number of transducer elements
    
    n_col = probe.N_elements_x;
    n_row = probe.N_elements_y;
    % These variables are extracted to speed up the parallel computation below
    xoff = probe.width / 2 - probe.transducer_width / 2;
    yoff = probe.height / 2 - probe.transducer_height / 2;
    xpitch = probe.pitch_x;
    ypitch = probe.pitch_y;
    width = probe.width;
    height = probe.height;
    
    % Filter parameters
    hp_fc = min(fs / 2, f_us / 2);       % High-pass imaging filter cutoff frequency
    
    [~, ~, image_upper_limit_N, image_lower_limit_N, xz_sector, yz_sector] = GetPhantomCoordinates(probe, image);
    
    if (image.azimuth_lines == -1)
        azimuth_lines = round(xz_sector * 180 / pi); % By default, one image line per degree
    else
        azimuth_lines = image.azimuth_lines;
    end
    if (image.elevation_lines == -1)
        elevation_lines = round(yz_sector * 180 / pi); % By default, one image line per degree
    else
        elevation_lines = image.elevation_lines;
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
        shrunk_rf = zeros(rows, columns, 1024);
        shrunk_rf(:, :, 1 : min(max_radius, 1024)) = rf(:, :, 1 : min(max_radius, 1024));
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
    apodization_compensation_factor = sqrt(n_el) .* sqrt(1 ./ ((2 * el_max + 2) .* (2 * el_max + 2))');
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
    
    %% High-pass filter the RF data to remove amplifier saturation artifacts
    filterOrder_hp = 4;
    wn_hp = 2 / fs * hp_fc;
    [b_hp, a_hp] = butter(filterOrder_hp, wn_hp, 'high'); % define the high pass filter
    % The filter itself will be applied once the data matrix "rf" is loaded, below.
    
    %% Further preparation before phased-array beamforming
    focal_points_per_depth = (image_lower_limit_N - image_upper_limit_N) / radial_lines;
    
    % Shrink the size of matrices used in the following, in order to save memory.
    el_max_shrunk = zeros(1, radial_lines);
    apod_full_shrunk = zeros(size(apod_full, 1), size(apod_full, 2), radial_lines);
    rx_delay_shrunk = zeros(size(rx_delay, 1), size(rx_delay, 2), radial_lines);
    for radius_index = 1 : radial_lines
        radius_index_scaled = (round(radius_index * focal_points_per_depth) + image_upper_limit_N - 1) * downsampling_factor;
        el_max_shrunk(radius_index) = el_max(radius_index_scaled);
        apod_full_shrunk(:, :, radius_index) = apod_full(:, :, radius_index_scaled);
        if (simulate_fixed_point_representation == 1)
            rx_delay_shrunk(:, :, radius_index) = num2fixpt(rx_delay(:, :, radius_index_scaled), fp_representation, 0, 'Nearest');
        else
            rx_delay_shrunk(:, :, radius_index) = rx_delay(:, :, radius_index_scaled);
        end
    end
    clear apod_full el_max rx_delay;
    sampling_indices = (round((1 : radial_lines) * focal_points_per_depth) + image_upper_limit_N - 1) * downsampling_factor;
    tx_delay_shrunk = zeros(elevation_lines, azimuth_lines, radial_lines);
    % Compound imaging: the full TX delay table will be loaded from disk
    % per-insonification.
    % Else, zone imaging (edge case single-zone imaging): the full TX delay
    % table can be constructed by stitching parts of the TX delay table,
    % loaded from disk, of each zone.
    if (compounding_count == 1)
        for zone_index = 1 : zone_count * zone_count
            tx_delay_shrunk_zone = LoadShrunkTXDelayFromDisk(target_phantom, zone_index, sampling_indices);
            if (simulate_fixed_point_representation == 1)
                tx_delay_shrunk_zone = num2fixpt(tx_delay_shrunk_zone, fp_representation, 0, 'Nearest');
            end
            zone_index_azimuth = mod(zone_index - 1, zone_count) + 1;
            zone_index_elevation = floor((zone_index - 1) / zone_count) + 1;
            azimuth_line_bottom = floor(azimuth_lines / zone_count * (zone_index_azimuth - 1)) + 1;
            azimuth_line_top = floor(azimuth_lines / zone_count * zone_index_azimuth);
            elevation_line_bottom = floor(elevation_lines / zone_count * (zone_index_elevation - 1)) + 1;
            elevation_line_top = floor(elevation_lines / zone_count * zone_index_elevation);
            tx_delay_shrunk(elevation_line_bottom : elevation_line_top, azimuth_line_bottom : azimuth_line_top, :) = tx_delay_shrunk_zone(elevation_line_bottom : elevation_line_top, azimuth_line_bottom : azimuth_line_top, :);
            clear tx_delay_shrunk_zone;
        end
    end
    
    %% MAIN LOOP: Beamforming via delay & sum
    % Main loop on different elevation angles
    % 3D if zone imaging; 4D if compounding, but will be shrunk back to normal if compounding_count == 1
    bf_im = squeeze(zeros(radial_lines, azimuth_lines, elevation_lines, compounding_count));
    d_phi = yz_sector / elevation_lines;
    phi_start = - yz_sector / 2 + d_phi / 2;

    for compounding_index = 1 : compounding_count
        tic;
        
        if (compounding_count > 1)
            tx_delay_shrunk = LoadShrunkTXDelayFromDisk(target_phantom, compounding_index, sampling_indices);
            if (simulate_fixed_point_representation == 1)
                tx_delay_shrunk = num2fixpt(tx_delay_shrunk, fp_representation, 0, 'Nearest');
            end
            disp(['Beamforming compound volume ', num2str(compounding_index), ' of ', num2str(compounding_count)]);
        end

        % Try to parallelize the iterations of the outer loop.
        % This code requires the Parallel Computing package. If it isn't
        % available, just edit the "parfor" below to be a plain "for".
        for elevation_index = 1 : elevation_lines
            phi = phi_start + (elevation_index - 1) * d_phi;
            disp(['Beamforming elevation slice ', num2str(elevation_index), ' of ', num2str(elevation_lines)]);
        
            min_offset = zeros(1, radial_lines) + 1e10;
            max_offset = zeros(1, radial_lines);
        
            d_theta = xz_sector / azimuth_lines;
            theta_start = - xz_sector / 2 + d_theta / 2;
            % Initialize the beamformed (but still RF) image to zero.
            % Note that the image excludes any deep cropping area, but still
            % includes the shallow cropping areas (if any). This is just for
            % readability and convenience. The shallow cropping areas will not
            % be beamformed anyway (for performance) and will be cropped below.
            rf_im = zeros(radial_lines, azimuth_lines);
            
            if (compounding_count == 1)
                insonification_index_low = zone_count * floor((elevation_index - 1) / (elevation_lines / zone_count)) + 1;
                insonification_index_high = zone_count * floor((elevation_index - 1) / (elevation_lines / zone_count)) + zone_count;
            else
                insonification_index_low = compounding_index;
                insonification_index_high = compounding_index;
            end
            if (isempty(find(currently_loaded_insonification_index == insonification_index_low)))
                % Loads on-demand new RF data, to keep memory use in check.
                % Strategy: if compounding, load the RF data for that compounding when necessary.
                % If zone imaging, load a set of zones (all the zones along the azimuth direction)
                % simultaneously when required by the progress of the elevation loop. This balances
                % the memory use with the speed of execution - don't want to load from disk too often.
                % rf - Radio-frequency matrix containing the raw data of the
                % backscattered echoes (M*N*O, where M*N is the number of probe elements,
                % and O is the number of time samples)
                rf = LoadRFDataMatrixFromDisk(target_phantom, insonification_index_low : insonification_index_high, max_radius, rows, columns);
                currently_loaded_insonification_index = insonification_index_low : insonification_index_high;
                % Apply TGC
                rf = tgc_elements_matrix .* rf;
                % Apply highpass filtering
                if (dump_fpga_verification_outputs == 1)
                else
                    for col = 1 : n_col
                        for row = 1 : n_row
                            rf(row, col, :) = filtfilt(b_hp, a_hp, rf(row, col, :));
                        end
                    end
                end
            end
            
            % Intermediate loop on azimuth lines
            for azimuth_index = 1 : azimuth_lines
                theta = theta_start + (azimuth_index - 1) * d_theta;
                % disp(['Beamforming azimuth line ', num2str(azimuth_index), ' of ', num2str(azimuth_lines)]);
                
                zone_index = zone_count * floor((elevation_index - 1) / (elevation_lines / zone_count)) + floor((azimuth_index - 1) / (azimuth_lines / zone_count)) + 1;
                if (zone_count > 1)
                    % disp(['Zone ', num2str(zone_index), ' of ', num2str(zone_count * zone_count)]);
                end
                
                if (with_exact_delays == 0)
                    % Update the precomputed delay table by adding a "steering"
                    % delay value, depending on the angle of the current line of sight,
                    % and an "elevation delay value", depending on the angle
                    % of the current elevation slice, that models the return time 
                    % delta with respect to the base table
                    rx_delay_steered = rx_delay_shrunk;
                    for loopr = 1 : n_row
                        if (simulate_fixed_point_representation == 1)
                            added_delay_elev_n = num2fixpt(((loopr - 1) * ypitch + yoff) * sin(phi) * cos(theta) * fs / c, fp_representation, 0, 'Nearest');
                            rx_delay_steered(loopr, :, :) = num2fixpt(rx_delay_steered(loopr, :, :) - added_delay_elev_n, fp_representation, 0, 'Nearest');
                        else
                            added_delay_elev_n = ((loopr - 1) * ypitch + yoff) * sin(phi) * cos(theta) * fs / c;
                            rx_delay_steered(loopr, :, :) = rx_delay_steered(loopr, :, :) - added_delay_elev_n;
                        end
                    end
                    for loopc = 1 : n_col
                        if (simulate_fixed_point_representation == 1)
                            added_delay_azimuth_n = num2fixpt(((loopc - 1) * xpitch + xoff) * sin(theta) * fs / c, fp_representation, 0, 'Nearest');
                            rx_delay_steered(:, loopc, :) = num2fixpt(rx_delay_steered(:, loopc, :) - added_delay_azimuth_n, fp_representation, 0, 'Nearest');
                        else
                            added_delay_azimuth_n = ((loopc - 1) * xpitch + xoff) * sin(theta) * fs / c;
                            rx_delay_steered(:, loopc, :) = rx_delay_steered(:, loopc, :) - added_delay_azimuth_n;
                        end
                    end
                    
                    %% Debug features
                    % Collects data used by the plotting code at the end of the function
                    if (0)
                        if (azimuth_index == round(azimuth_lines / 2))
                            % Store the steered delay table for this elevation and
                            % (mid-)azimuth, at the mid-radius depth
                            total_delay_n(elevation_index, :, :) = rx_delay_steered(:, :, round(size(rx_delay_steered, 3) / 2));
                        end
                    end
                end
                
                % Apply Selfridge and Kino directivity model to elements. Since
                % steered lines of sight are attenuated due to element directivity,
                % we should compensate for that here.
                x = f_us / c * width * sin(theta);
                y = f_us / c * height * sin(phi);
                directivity_factor = 1 / (sinc(x) * cos(theta) * sinc(y) * cos(phi));
                if (dump_fpga_verification_outputs == 1)
                    apod_with_directivity = apod_full_shrunk;
                else
                    apod_with_directivity = apod_full_shrunk * directivity_factor;
                end
            
                % Inner loop along depth
                rf_line = zeros(radial_lines, 1);
                for radius_index = 1 : radial_lines
                    % Figure out the outermost elements that are relevant to
                    % reconstruct this point, depending on time and directivity
                    % (as encoded in el_max)
                    % Horizontal elements:
                    el_inf_columns = n_col / 2 - el_max_shrunk(radius_index);
                    el_sup_columns = n_col / 2 + el_max_shrunk(radius_index) + 1;
                    % Vertical elements:
                    el_inf_rows = n_row / 2 - el_max_shrunk(radius_index);
                    el_sup_rows = n_row / 2 + el_max_shrunk(radius_index) + 1;
                    d_Tx = tx_delay_shrunk(elevation_index, azimuth_index, radius_index);
                    drx = zeros(n_col, n_row);
                    if (with_exact_delays == 1)
                        radius_index_scaled = (round(radius_index * focal_points_per_depth) + image_upper_limit_N - 1) * downsampling_factor;
                        r = radius_index_scaled / 2 * c * ts;
                        xS = r * sin(theta);
                        yS = r * sin(phi) * cos(theta);
                        zS = r * cos(phi) * cos(theta);
                        
                        % Innermost loops on aperture
                        for el_row = el_inf_rows : el_sup_rows
                            yD = (el_row - 1) * ypitch + yoff;
                            for el_column = el_inf_columns : el_sup_columns
                                xD = (el_column - 1) * xpitch + xoff;
                                % Sum to the point of the RF image "el_row" and "el_column", delayed and apodized
                                d_Rx = sqrt((xS - xD) ^ 2 + (yS - yD) ^ 2 + zS ^ 2) * fs / c;
                                delay = round(d_Tx + d_Rx);
                                if (dump_fpga_verification_outputs == 1)
                                    min_offset(radius_index) = min(delay, min_offset(radius_index));
                                    max_offset(radius_index) = max(delay, max_offset(radius_index));
                                end
                                if (delay <= max_radius && delay > 0)
                                    if (zone_count == 1 || compounding_count > 1) % Speeds up execution tremendously for some reason
                                        rf_line(radius_index) = rf_line(radius_index) + apod_with_directivity(el_row, el_column, radius_index) * rf(el_row, el_column, delay);
                                    else % zone_count > 1
                                        rf_line(radius_index) = rf_line(radius_index) + apod_with_directivity(el_row, el_column, radius_index) * rf(el_row, el_column, delay, mod(zone_index - 1, zone_count) + 1);
                                    end
                                    drx(el_row, el_column) = d_Rx;
                                end
                            end
                        end
                        
                        %% Debug features
                        % Collects data used by the plotting code at the end of the function
                        if (0)
                            if (azimuth_index == round(azimuth_lines / 2) && radius_index == round(radial_lines / 2))
                                % Store the exact delay table for this elevation and
                                % (mid-)azimuth, at the mid-radius depth
                                total_delay_n(elevation_index, :, :) = drx;
                            end
                        end

                    else % with_exact_delays == 0
                        % Innermost loops on aperture
                        for el_row = el_inf_rows : el_sup_rows
                            for el_column = el_inf_columns : el_sup_columns
                                % Sum to the point of the RF image "el_row" and "el_column", delayed and apodized
                                d_Rx = rx_delay_steered(el_row, el_column, radius_index);
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
                                    if (zone_count == 1 || compounding_count > 1) % Speeds up execution tremendously for some reason
                                        rf_line(radius_index) = rf_line(radius_index) + apod_with_directivity(el_row, el_column, radius_index) * rf(el_row, el_column, delay);
                                    else % zone_count > 1
                                        rf_line(radius_index) = rf_line(radius_index) + apod_with_directivity(el_row, el_column, radius_index) * rf(el_row, el_column, delay, mod(zone_index - 1, zone_count) + 1);
                                    end
                                end
                            end
                        end
                    end
                end
                rf_im(:, azimuth_index) = rf_line;
            end
            
            bf_im(:, :, elevation_index, compounding_index) = rf_im;
        end
        
        toc
    end
    
    offset_min = min_offset';
    offset_max = max_offset';
    
    %% Brightness Compensation
    if (with_brightness_compensation == 1)
        for elevation_index = 1 : elevation_lines
            % The brightness compensation map has dimensions [depth, theta, phi, zone]
            for zone = 1 : zone_count % TODOZONE
                theta_start = 1 + floor((zone - 1) * azimuth_lines / zone_count);
                theta_end = min(floor(zone * azimuth_lines / zone_count), theta_start + size(brightness_comp, 2) - 1);
                % 1 value per mm, from image_upper_limit_N to image_lower_limit_N
                compensation = brightness_comp(:, 1 : (theta_end - theta_start + 1), ceil(elevation_index / zone_count), zone);
                depth_samples = size(compensation, 1);
                % radial_lines values, from image_upper_limit_N to image_lower_limit_N
                compensation_scaled = ones(radial_lines, theta_end - theta_start + 1);
                for radius_index = 1 : radial_lines
                    compensation_scaled(radius_index, :) = compensation(max(1, round(radius_index * depth_samples / radial_lines)), :);
                end
                bf_im(:, theta_start : theta_end, elevation_index) = bf_im(:, theta_start : theta_end, elevation_index) .* compensation_scaled;
            end
        end
    end
    
    cd(fileparts(mfilename('fullpath')));
    save('../data/bf_im_hf_phased.mat', 'bf_im');
    
    %% Demodulate and low-pass filter
    for elevation_index = 1 : elevation_lines
        for compounding_index = 1 : compounding_count
            % Reusing the same data structure bf_im saves memory.
            if (dump_fpga_verification_outputs)
                % Demodulation method 7 -> abs + FIR lowpass
                bf_im(:, :, elevation_index, compounding_index) = DemodulateRFImage(probe, bf_im(:, :, elevation_index, compounding_index), focal_points_per_depth, 0, 7);
            else
                % Demodulation method 2 -> IQ + Butterworth lowpass
                bf_im(:, :, elevation_index, compounding_index) = DemodulateRFImage(probe, bf_im(:, :, elevation_index, compounding_index), focal_points_per_depth, 0, 2);
            end
        end
        % This behaves numerically like:
        % for azimuth_index = 1 : azimuth_lines
        %    bf_im(:, azimuth_index, elevation_index, compounding_index) = DemodulateRFImage(probe, bf_im(:, azimuth_index, elevation_index, compounding_index), ...);
        % end
    end
    
    %% Debug features
    % Requires enabling the data collection inside the loop, too
    if (0)
        if (probe.linear == 0)
            matrix_elev_n = squeeze(total_delay_n(1, :, :));
            figure
            surf(matrix_elev_n), hold on,
            matrix_elev_n = squeeze(total_delay_n(elevation_lines, :, :));
            surf(matrix_elev_n), hold on
            matrix_elev_n = squeeze(total_delay_n(round(elevation_lines / 2), :, :));
            surf(matrix_elev_n)
        end
    end
    
    cd(fileparts(mfilename('fullpath')));
    save('../data/bf_im_phased.mat', 'bf_im');
    
end
