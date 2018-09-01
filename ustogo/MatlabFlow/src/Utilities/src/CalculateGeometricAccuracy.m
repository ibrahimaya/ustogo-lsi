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
%% Computes the geometric accuracy of approximating round-trip ultrasound propagation
%% distances with the "delay steering" method rather than with the full square root
%% calculation. The outputs are reported in 2-way-time-of-flight differences.
%
% Inputs: probe - description of the probe
%         rx_delay - the TX delay-law matrix
%         el_max - the outermost element that must be included in
%                  beamforming calculations (depends on time and element
%                  directivity)
%         el_max_width, el_max_height, x_c, y_c - width and height of the
%                                                 apodization window, and
%                                                 its center (trimmed
%                                                 apodization). Dummy
%                                                 values can be passed if
%                                                 with_expanding_aperture
%                                                 == 1.
%         considering_directivity - whether the element directivity should
%                                   be accounted for, pruning the volume in
%                                   which to assess the accuracy
%         with_expanding_aperture - (if considering_directivity == 1):
%                                   if 1, use a plain expanding aperture
%                                   (el_max)
%                                   if 0, use a trimmed aperture
%                                   (el_max_width, el_max_height, x_c, y_c)
%         use_discarding - whether elements triggering a geometric
%                          inaccuracy above a certain threshold should be
%                          summed in (0) or discarded (1)
%         phi_steps, theta_steps, r_steps - the focal point density in each
%                                           axis. High values will incur
%                                           very high runtimes!
%         image - A structure with fields describing the desired output
%                 output resolution
%
% Outputs: delay_error_map - a 3D table representing the absolute 2-way
%                            time of flight difference between the exact
%                            calculation and the geometric approximation
%          discarded_elements_map - a 3D table representing the number of
%                            elements that must be discarded in the
%                            calculation of this point because they have
%                            more than "threshold" error
%          discarded_elements_percentage_map - same as above, measured as a
%                            percentage of the number of elements allowed
%                            by apodization
%          discard_table - an array of 11 elements stating how many focal
%                          points underwent discarding 0%, <10%, <20%, ...,
%                          <100% element echoes
%          max_delay_delta - maximum (absolute) 2-way delay difference
%          avg_delay_delta - average (absolute) 2-way delay difference
%          mean_delay_delta - mean 2-way delay difference (negative and
%                             positive differences cancel out)
%          variance_delay_delta - variance in 2-way delay difference
%          delays - number of points for which the 2-way delay difference
%                   has been calculated
%          taylor_inaccuracy_distr - an array representing the amount of focal
%                                    points featuring a certain inaccuracy
%          taylor_inaccuracy - an array representing the Taylor inaccuracy
%                              bins

function [delay_error_map, discarded_elements_map, discarded_elements_percentage_map, ...
          discard_table, max_delay_delta, avg_delay_delta, mean_delay_delta, variance_delay_delta, delays, ...
          taylor_inaccuracy_distr, taylor_inaccuracy] = ...
          CalculateGeometricAccuracy(probe, rx_delay, ...
          el_max, el_max_width, el_max_height, x_c, y_c, ...
          considering_directivity, with_expanding_aperture, use_discarding, ...
          phi_steps, theta_steps, r_steps, image)
    
    % If elements have a sampling error above this threshold,
    % "discard" them (this means that a focal point will be computed from
    % fewer element echoes)
    if (use_discarding)
        % The number of samples in a quarter-period of the transducer's
        % carrier (90' phase shift)
        discard_threshold = round(probe.fs / (4 * probe.f0));
        message = ['Discarding elements with inaccuracy of more than ', num2str(discard_threshold), ' samples'];
        disp(message);
    else
        discard_threshold = 1e10;
    end

    [~, ~, r_min_N, r_max_N, xz_sector, yz_sector] = GetPhantomCoordinates(probe, image);

    phi_step = yz_sector / phi_steps;
    phi_start = - yz_sector / 2 + phi_step / 2;

    theta_step = xz_sector / theta_steps;
    theta_start = - xz_sector / 2 + theta_step / 2;

    r_step = (r_max_N - r_min_N) / r_steps;
    
    first_depth = round(r_min_N / r_step) + 1;
    last_depth = round((r_max_N - r_min_N) / r_step);
    items = last_depth - first_depth + 1;
    el_max_shrunk = zeros(1, items);
    el_max_width_shrunk = zeros(items, size(el_max_width, 2), size(el_max_width, 3));
    el_max_height_shrunk = zeros(items, size(el_max_height, 2), size(el_max_height, 3));
    x_c_shrunk = zeros(items, size(x_c, 2));
    y_c_shrunk = zeros(items, size(y_c, 2));
    rx_delay_shrunk = zeros(size(rx_delay, 1), size(rx_delay, 2), items);
    for r_count = first_depth : last_depth
        r_count_scaled = (round(r_count * r_step) + r_min_N - 1);
        el_max_shrunk(r_count) = el_max(r_count_scaled);
        el_max_width_shrunk(r_count, :, :) = el_max_width(r_count_scaled, :, :);
        el_max_height_shrunk(r_count, :, :) = el_max_height(r_count_scaled, :, :);
        x_c_shrunk(r_count, :) = x_c(r_count_scaled, :);
        y_c_shrunk(r_count, :) = y_c(r_count_scaled, :);
        rx_delay_shrunk(:, :, r_count) = rx_delay(:, :, r_count_scaled);
    end
    
    % These variables are extracted to speed up the parallel computation below
    c = probe.c;
    fs = probe.fs;
    Nx = probe.N_elements_x;
    Ny = probe.N_elements_y;
    xoff = probe.width / 2 - probe.transducer_width / 2;
    yoff = probe.height / 2 - probe.transducer_height / 2;
    xpitch = probe.pitch_x;
    ypitch = probe.pitch_y;
    
    delay_error_map = zeros(phi_steps, theta_steps, r_steps);
    discarded_elements_map = zeros(phi_steps, theta_steps, r_steps);
    discarded_elements_percentage_map = zeros(phi_steps, theta_steps, r_steps);

    % When computing inaccuracy distributions, do so in terms of this
    % fraction of delay samples. For example 10 -> compute the
    % distribution with a grain of 0.1 delay samples. The number must be
    % integer. If it is changed to X, change correspondingly also the
    % "center" parameter below as the maximum inaccuracy will now change
    % by X-fold.
    inaccuracy_grain_multiple = 10;
    % Array to hold the "off samples" bins. Centered at "center" (center = 0
    % samples off; center - 1 = -1 sample off; center + 1 = +1 sample off).
    % Adjust the size of this parameter depending on unexpected
    % inaccuracy; set as low as possible to save memory
    center = 2200;
    count_off_samples = zeros(1, 2 * center);

    tic;

    delay_delta_acc = 0;
    delays = 0;
    sum_dev_acc = 0;
    mean_acc = 0;
    discarded_elements_percentage_acc = 0;
    discarded_elements_percentage_counter = 0;
    apodized_elements_counter = 0;
    nonapodized_inaccurate_elements_counter = 0;
    nonapodized_accurate_elements_counter = 0;
    % Try to parallelize the iterations of the outer loop.
    % This code requires the Parallel Computing package. If it isn't
    % available, just edit the "parfor" below to be a plain "for".
    parfor phi_count = 1 : phi_steps
        phi = phi_start + (phi_count - 1) * phi_step;
        % phi_count_scaled = round(rad2deg(phi - yz_sector * (1 / round(yz_sector * 180 / pi) - 1) / 2)) + 1;
        message = ['Analyzing phi = ', num2str(rad2deg(phi)), '? (', num2str(phi_count), ' of ', num2str(phi_steps), ')'];
        disp(message);
        
        delay_error_map_slice = zeros(theta_steps, r_steps);
        discarded_elements_map_slice = zeros(theta_steps, r_steps);
        discarded_elements_percentage_map_slice = zeros(theta_steps, r_steps);
        count_off_samples_slice = zeros(1, 2 * center);
        sphi = sin(phi);
        cphi = cos(phi);
        for theta_count = 1 : theta_steps
            theta = theta_start + (theta_count - 1) * theta_step;
            % theta_count_scaled = round(rad2deg(theta - xz_sector * (1 / round(xz_sector * 180 / pi) - 1) / 2)) + 1;
            message = ['Analyzing theta = ', num2str(rad2deg(theta)), '? (', num2str(theta_count), ' of ', num2str(theta_steps), ')'];
            disp(message);
            sthe = sin(theta);
            cthe = cos(theta);
%            tic;
            
            first_depth = round(r_min_N / r_step) + 1;
            last_depth = round((r_max_N - r_min_N) / r_step);
            for r_count = first_depth : last_depth
%                message = ['Analyzing r = ', num2str(r), 'm (', num2str(r_count), ' of ', num2str(r_steps), ')'];
%                disp(message);
                r = (round(r_count * r_step) + r_min_N - 1) / 2 * c / fs;
                xS = r * sthe;
                yS = r * sphi * cthe;
                zS = r * cphi * cthe;
                zSD2 = zS ^ 2;
                if (considering_directivity == 1)
                    % Figure out the outermost elements that are relevant to
                    % reconstruct this point, depending on time and directivity
                    % (as encoded in el_max)
                    if (with_expanding_aperture == 1)
                        % Horizontal elements:
                        el_inf_columns = Nx / 2 - el_max_shrunk(r_count);
                        el_sup_columns = Nx / 2 + el_max_shrunk(r_count) + 1;
                        % Vertical elements:
                        el_inf_rows = Ny / 2 - el_max_shrunk(r_count);
                        el_sup_rows = Ny / 2 + el_max_shrunk(r_count) + 1;
                    else
                        % TODO this will fail to pick the right 2nd/3rd
                        % index into these matrices (theta_count /
                        % phi_count) unless the script is invoked with the
                        % full resolution on those two axes
                        el_inf_columns = max(x_c_shrunk(r_count, theta_count) - floor(el_max_width_shrunk(r_count, phi_count, theta_count) / 2), 1);   
                        el_sup_columns = min(x_c_shrunk(r_count, theta_count) + floor(el_max_width_shrunk(r_count, phi_count, theta_count) / 2), Nx);          
                        el_inf_rows = max(y_c_shrunk(r_count, phi_count) - floor(el_max_height_shrunk(r_count, phi_count, theta_count) / 2), 1); 
                        el_sup_rows = min(y_c_shrunk(r_count, phi_count) + floor(el_max_height_shrunk(r_count, phi_count, theta_count) / 2), Ny);
                    end
                else
                    el_inf_columns = 1;
                    el_sup_columns = Nx;
                    el_inf_rows = 1;
                    el_sup_rows = Ny;
                end
                % tx_delay = LoadTXDelayFromDisk(...);
                % d_Tx = tx_delay(phi_count_scaled, theta_count_scaled, r_count_scaled, 1) / fs;
                
                max_error_SD = 0;
                used_probe_elements = 0;
                
                % Innermost loops on aperture
                apodized_elements = (Nx * Ny) - (el_sup_rows - el_inf_rows + 1) * (el_sup_columns - el_inf_columns + 1);
                apodized_elements_counter = apodized_elements_counter + apodized_elements;
                for el_row = el_inf_rows : el_sup_rows
                    yD = (el_row - 1) * ypitch + yoff;
                    correction2 = yD * cthe * sphi / c;
                    ySD2 = (yS - yD) ^ 2;
                    for el_column = el_inf_columns : el_sup_columns
                        used_probe_elements = used_probe_elements + 1;
                        xD = (el_column - 1) * xpitch + xoff;
                        correction1 = xD * sthe / c;
                        xSD2 = (xS - xD) ^ 2;
                        d_Rx = sqrt(xSD2 + ySD2 + zSD2) / c;
                        % Both the below should include "+ d_Tx", but
                        % since we only care about their difference, we
                        % can ignore that
                        delay_exact = d_Rx; % + d_Tx
                        delay_approx = rx_delay_shrunk(el_row, el_column, r_count) / fs - correction1 - correction2; % + d_Tx
                        delay_delta = abs(delay_exact - delay_approx);
                        delay_delta_samples = delay_delta * fs;
                        
                        if (delay_delta_samples > discard_threshold)
                            discarded_elements_map_slice(theta_count, r_count) = discarded_elements_map_slice(theta_count, r_count) + 1;
                            nonapodized_inaccurate_elements_counter = nonapodized_inaccurate_elements_counter + 1;
                        else
                            max_error_SD = max(max_error_SD, delay_delta);
                            delays = delays + 1;
                            delay_delta_acc = delay_delta_acc + delay_delta;
                            sum_dev_acc = sum_dev_acc + delay_delta^2;
                            mean_acc = mean_acc + (delay_exact - delay_approx);
                            
                            delay_delta_signed = delay_exact - delay_approx;
                            % The delay delta is computed at the grain of
                            % 1/(inaccuracy_grain_multiple)-th of a delay sample.
                            delay_delta_signed_rounded = round(delay_delta_signed * fs * inaccuracy_grain_multiple);
                            count_off_samples_slice(center + delay_delta_signed_rounded) = count_off_samples_slice(center + delay_delta_signed_rounded) + 1;
                            nonapodized_accurate_elements_counter = nonapodized_accurate_elements_counter + 1;
                        end
                    end
                end
                
                delay_error_map_slice(theta_count, r_count) = max_error_SD;
                discarded_elements_percentage = discarded_elements_map_slice(theta_count, r_count) / used_probe_elements;
                discarded_elements_percentage_map_slice(theta_count, r_count) = discarded_elements_percentage;
                discarded_elements_percentage_acc = discarded_elements_percentage_acc + discarded_elements_percentage;
                discarded_elements_percentage_counter = discarded_elements_percentage_counter + 1;
            end
%            toc
        end
        delay_error_map(phi_count, :, :) = delay_error_map_slice;
        discarded_elements_map(phi_count, :, :) = discarded_elements_map_slice;
        discarded_elements_percentage_map(phi_count, :, :) = discarded_elements_percentage_map_slice;
        count_off_samples = count_off_samples + count_off_samples_slice;
    end
    
    max_delay_delta = max(max(max(delay_error_map)));
    
    toc
    
    message = ['Max abs delay: ', num2str(max_delay_delta), ' s (', num2str(max_delay_delta * fs), ' samples) avg abs delay: ', num2str(delay_delta_acc / delays), ' s (', num2str(delay_delta_acc * probe.fs / delays), ' samples) mean: ', num2str(mean_acc / delays), ' s (', num2str(mean_acc * probe.fs / delays), ' samples) variance: ', num2str(sum_dev_acc / delays), ' s (', num2str(sum_dev_acc * probe.fs / delays), ' samples) over ', num2str(delays), ' delays'];
    disp(message);

    message = ['Max discarded elements: ', num2str(max(max(max(discarded_elements_percentage_map))) * 100), '%, average: ', num2str(discarded_elements_percentage_acc / discarded_elements_percentage_counter * 100), '%'];
    disp(message);
    
    [r_worst, theta_worst, phi_worst] = MapWorstPointsByCount(discarded_elements_map, 1);
    message = ['Worst location(s): r=', num2str(r_worst(1)), ', theta=', num2str(theta_worst(1)), ', phi=', num2str(phi_worst(1))];
    disp(message);
    
    total_elements = nonapodized_accurate_elements_counter + apodized_elements_counter + nonapodized_inaccurate_elements_counter;
    apodized_elements_percentage = apodized_elements_counter / total_elements;
    nonapodized_accurate_elements_percentage = nonapodized_accurate_elements_counter / total_elements;
    nonapodized_inaccurate_elements_percentage = nonapodized_inaccurate_elements_counter / total_elements;    
    message = ['Apodized elements: ', num2str(apodized_elements_percentage * 100), '%, non-apodized and accurate: ', num2str(nonapodized_accurate_elements_percentage * 100), '%, non-apodized and inaccurate: ', num2str(nonapodized_inaccurate_elements_percentage * 100), '%'];
    disp(message);

    delay_error_map_sc = ScanConvert3DPhased(probe, permute(delay_error_map, [3, 1, 2]), 1, 0, 0);
    figure
    colormap(jet)
    imagesc(permute(squeeze(delay_error_map_sc(:, round(size(delay_error_map_sc, 2) / 2), :)), [2 1]));
    title('Delay error map (XZ plane at mid-Y)');
    axis equal;

    if (use_discarding == 1)
        discarded_elements_map_sc = ScanConvert3DPhased(probe, permute(discarded_elements_map, [3, 1, 2]), 1, 0, 0);
        figure
        colormap(jet)
        imagesc(permute(squeeze(discarded_elements_map_sc(:, round(size(discarded_elements_map_sc, 2) / 2), :)), [2 1]));
        title('Elements to discard (XZ plane at mid-Y)');
        axis equal;
        colorbar
        caxis([0 probe.N_elements_x * probe.N_elements_y])
        
        discarded_elements_percentage_map_sc = ScanConvert3DPhased(probe, permute(discarded_elements_percentage_map, [3, 1, 2]), 1, 0, 0);
        figure
        colormap(jet)
        imagesc(permute(squeeze(discarded_elements_percentage_map_sc(:, round(size(discarded_elements_percentage_map_sc, 2) / 2), :)), [2 1]));
        title('Percentage of elements to discard (XZ plane at mid-Y)');
        axis equal;
        colorbar
        caxis([0 1])
    end

    avg_delay_delta = delay_delta_acc / delays;
    mean_delay_delta = mean_acc / delays;
    variance_delay_delta = sum_dev_acc / delays;
    
    discard_table = zeros(11);
    for discard_index = 0 : 1 : 10
        discard_table(discard_index + 1) = sum(sum(sum(discarded_elements_percentage_map < discard_index / 10))) / (phi_steps * theta_steps * r_steps);
    end
    
    off_samples = find(count_off_samples ~=0);
    min_off_samples = off_samples(1);
    max_off_samples = off_samples(end);
    taylor_inaccuracy_distr = count_off_samples(min_off_samples : max_off_samples); %[fliplr(count_negative(find(count_negative ~=0))) count_zero count_positive(find(count_positive ~=0))];
    taylor_inaccuracy = min_off_samples - center : max_off_samples - center; %[-fliplr(find(count_negative ~=0)) 0 find(count_positive ~=0)];

    if (use_discarding == 1)
        figure, plot(0 : 0.1 : 1, discard_table);
        title('CDF of the amount of focal points undergoing element discarding of less than X%');
    end
    
    [profile_x_14, profile_14] = ConvolveInaccuracyProfiles(probe, 14, taylor_inaccuracy, taylor_inaccuracy_distr, inaccuracy_grain_multiple);
    [profile_x_16, profile_16] = ConvolveInaccuracyProfiles(probe, 16, taylor_inaccuracy, taylor_inaccuracy_distr, inaccuracy_grain_multiple);
    [profile_x_18, profile_18] = ConvolveInaccuracyProfiles(probe, 18, taylor_inaccuracy, taylor_inaccuracy_distr, inaccuracy_grain_multiple);

    % TODO duplicate code, these first lines already occur inside ConvolveInaccuracyProfiles
    taylor_sampling_interval = 1 / inaccuracy_grain_multiple;
    taylor_interpolation_factor = round(taylor_sampling_interval / (1 / 1000));
    % Use non-default parameters for interpolation. In particular,
    % interpolate by using adjacent samples only (L = 1). This is because
    % the distribution can have steep slopes (high-frequency components)
    % that may throw the interpolation off, resulting even in overshoots
    % into negative (!) values for the interpolated distribution.
    interpolated_taylor_inaccuracy_distr = interp(taylor_inaccuracy_distr, taylor_interpolation_factor, 1, 0.5);
    interpolated_taylor_inaccuracy = interp(taylor_inaccuracy, taylor_interpolation_factor) * taylor_sampling_interval;
    % Now renormalize the distribution so that the Y axis shows the number of occurrences
    interpolated_taylor_inaccuracy_distr = interpolated_taylor_inaccuracy_distr ./ (sum(interpolated_taylor_inaccuracy_distr) / sum(taylor_inaccuracy_distr));
    % TODO not quite, in fact taylor_max_abs_error_N may be wider than it should be.
    taylor_max_abs_error_N = max(abs(interpolated_taylor_inaccuracy));               % Maximum absolute error in number of samples.
    taylor_max_abs_error_T = max(abs(interpolated_taylor_inaccuracy / probe.fs));    % Maximum absolute error in time (secs).
    message = ['Taylor alone: the max absolute error is ', num2str(taylor_max_abs_error_N), ' samples, and ', num2str(taylor_max_abs_error_T), ' [s].'];
    disp(message);
    taylor_avg_abs_error_N = sum(abs(interpolated_taylor_inaccuracy) * interpolated_taylor_inaccuracy_distr') / sum(interpolated_taylor_inaccuracy_distr);  % Average absolute error in terms of number of samples.
    taylor_avg_abs_error_T = sum(abs(interpolated_taylor_inaccuracy / probe.fs) * interpolated_taylor_inaccuracy_distr') / sum(interpolated_taylor_inaccuracy_distr); % Average absolute error in terms of number of samples.
    message = ['Taylor alone: the average absolute error is ', num2str(taylor_avg_abs_error_N), ' samples, and ', num2str(taylor_avg_abs_error_T), ' [s].'];
    disp(message);
    
    % Since we probably computed the distributions on a subset of the volume
    % for speed, multiply up to show the right numbers on the Y axis of this plot
    focal_point_ratio = (image.elevation_lines * image.azimuth_lines * image.radial_lines) / (phi_steps * theta_steps * r_steps);

    figure, p14 = plot(profile_x_14, profile_14 * focal_point_ratio, 'k');
        hold on, p16 = plot(profile_x_16, profile_16 * focal_point_ratio, 'r');
        hold on, p18 = plot(profile_x_18, profile_18 * focal_point_ratio, 'g');
        hold on, pt = plot(interpolated_taylor_inaccuracy, interpolated_taylor_inaccuracy_distr * focal_point_ratio, 'b');
        hold off,
    legend([p14, p16, p18, pt], 'Taylor + 14-bit', 'Taylor + 16-bit', 'Taylor + 18-bit', 'Taylor only')
    xlabel('Sampling inaccuracy [samples]'),
    ylabel('Occurrences [count of (S, D) pairs]'),
    title('Total sampling inaccuracy');
    currentlim = ylim;
    ylim(gca, [0 currentlim(2)]);
    set(gca, 'FontSize', 14)
    set(findall(gca, 'Type', 'Line'), 'LineWidth', 2);
    set([p14], 'LineStyle', '--')
    set([p16], 'LineStyle', ':')
    set([pt], 'LineStyle', '-.')
    set(findall(gcf, 'type', 'text'), 'FontSize', 12)

end
