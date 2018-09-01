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
%% calculation. For a selected voxel, shows how the inaccuracy is distributed
%% over the transducer face, and how the apodization is discarding the
%% impermissible elements.
%
% Inputs: probe - description of the probe
%         image - A structure with fields describing the desired output
%                 output resolution
%         rx_delay - the RX delay-law matrix
%         el_max - the outermost element that must be included in
%                  beamforming calculations (edges of the apodization)
%                  (standard expanding apodization)
%         el_max_width, el_max_height, x_c, y_c - width and height of the
%                                                 apodization window, and
%                                                 its center (trimmed apodization)
%         phi_index, theta_index, r_index - the focal point for which the
%                                           map is calculated
%         superimpose_default_apodization - display a white rectangle
%                                           corresponding to a default
%                                           expanding-aperture apodization.
%         superimpose_current_apodization - display a black rectangle
%                                           corresponding to the current apodization.
%
% Outputs: none

function [] = PlotTransducerInaccuracyAndApodization(probe, image, rx_delay, el_max, el_max_width, el_max_height, x_c, y_c, phi_index, theta_index, r_index, superimpose_default_apodization, superimpose_current_apodization, r_steps)

    [~, ~, r_min_N, r_max_N, xz_sector, yz_sector] = GetPhantomCoordinates(probe, image);

    [r_steps, phi_steps, theta_steps] = size(el_max_width);
    
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
    
    phi = phi_start + (phi_index - 1) * phi_step;
    theta = theta_start + (theta_index - 1) * theta_step;
    r = (round(r_index * r_step) + r_min_N - 1) / 2 * c / fs;
    xS = r * sin(theta);
    yS = r * sin(phi) * cos(theta);
    zS = r * cos(phi) * cos(theta);
    zSD2 = zS ^ 2;
    element_inaccuracy = zeros(Ny, Nx);

    for el_row = 1 : Ny
        yD = (el_row - 1) * ypitch + yoff;
        correction2 = yD * cos(theta) * sin(phi) / c;
        ySD2 = (yS - yD) ^ 2;
        for el_column = 1 : Nx
            xD = (el_column - 1) * xpitch + xoff;
            correction1 = xD * sin(theta) / c;
            xSD2 = (xS - xD) ^ 2;
            d_Rx = sqrt(xSD2 + ySD2 + zSD2) / c;
            % Both the below should include "+ d_Tx", but
            % since we only care about their difference, we
            % can ignore that
            delay_exact = d_Rx; % + d_Tx
            delay_approx = rx_delay_shrunk(el_row, el_column, r_index) / fs - correction1 - correction2; % + d_Tx
            delay_delta = abs(delay_exact - delay_approx);
            delay_delta_samples = delay_delta * fs;
            
            element_inaccuracy(el_row, el_column) = delay_delta_samples;            
        end
    end
        
    % Adjust the colormap. The contour having inaccuracy of 2 elements is magenta.
    jet_edited = jet;
    % Bound the dynamic range of the colormap so that we have comparable
    % and legible plots.
    start_color = 0;
    end_color = 10;
    discard_threshold = round(probe.fs / (4 * probe.f0));
    contour_profile = ceil((length(jet) / (end_color - start_color)) * discard_threshold);
    jet_edited(contour_profile, :) = [1 0 1]; % magenta
    jet_edited(contour_profile + 1, :) = [1 0 1]; % magenta
        
    %% Display the transducer face
    figure
    imagesc(element_inaccuracy)
    colorbar
    caxis([start_color end_color])
    colormap(jet_edited)
    title(['Inaccuracy and apodization at phi=', num2str(phi_index), ' of ', num2str(phi_steps), ', theta=', num2str(theta_index), ' of ', num2str(theta_steps), ', r=', num2str(r_index), ' of ', num2str(r_steps)]);
    xlabel('Probe width [elements]')
    ylabel('Probe height [elements]')

    %% Display the inaccuracy projection with showing the typical apodization (extended aperture) rectangle:
    if (superimpose_default_apodization == 1)
        start_tp_w = Nx / 2 - el_max_shrunk(r_index);
        end_tp_w = Nx / 2 + el_max_shrunk(r_index) + 1;
        start_tp_h = Ny / 2 - el_max_shrunk(r_index);
        end_tp_h = Ny / 2 + el_max_shrunk(r_index) + 1;
        
        line([start_tp_w, end_tp_w], [start_tp_h, start_tp_h], 'LineWidth', 3, 'Color', [1 1 1]);
        line([start_tp_w, end_tp_w], [end_tp_h, end_tp_h], 'LineWidth', 3, 'Color', [1 1 1]);
        line([start_tp_w, start_tp_w], [start_tp_h, end_tp_h], 'LineWidth', 3, 'Color', [1 1 1]);
        line([end_tp_w, end_tp_w], [start_tp_h, end_tp_h], 'LineWidth', 3, 'Color', [1 1 1]);
        
        elements_to_be_discarded_after_default_apodization = 0;
        for el_row = 1 : Ny
            for el_column = 1 : Nx
                if (element_inaccuracy(el_row, el_column) > discard_threshold ...
                    && el_column >= start_tp_w && el_column <= end_tp_w ...
                    && el_row >= start_tp_h && el_row <= end_tp_h)
                    elements_to_be_discarded_after_default_apodization = elements_to_be_discarded_after_default_apodization + 1;
                end
            end
        end
        
        message = ['At location phi=', num2str(phi_index), ' of ', num2str(phi_steps), ', theta=', num2str(theta_index), ' of ', num2str(theta_steps), ', r=', num2str(r_index), ' of ', num2str(r_steps), ', ', num2str(elements_to_be_discarded_after_default_apodization), ' elements need discarding (threshold=', num2str(discard_threshold), ' samples) after using the default apodization.'];
        disp(message);
    end

    %% Display the inaccuracy projection with showing both typical and proposed apodization rectangles:
    if (superimpose_current_apodization == 1)
        start_new_w = max(x_c_shrunk(r_index, theta_index) - floor(el_max_width_shrunk(r_index, phi_index, theta_index) / 2), 1);   
        end_new_w = min(x_c_shrunk(r_index, theta_index) + floor(el_max_width_shrunk(r_index, phi_index, theta_index) / 2), Nx);
        start_new_h = max(y_c_shrunk(r_index, phi_index) - floor(el_max_height_shrunk(r_index, phi_index, theta_index) / 2), 1); 
        end_new_h = min(y_c_shrunk(r_index, phi_index) + floor(el_max_height_shrunk(r_index, phi_index, theta_index) / 2), Ny);
        
        line([start_new_w, end_new_w], [start_new_h, start_new_h], 'LineWidth', 3, 'Color', [0 0 0]);
        line([start_new_w, end_new_w], [end_new_h, end_new_h], 'LineWidth', 3, 'Color', [0 0 0]);
        line([start_new_w, start_new_w], [start_new_h, end_new_h], 'LineWidth', 3, 'Color', [0 0 0]);
        line([end_new_w, end_new_w], [start_new_h, end_new_h], 'LineWidth', 3, 'Color', [0 0 0]);
        
        elements_to_be_discarded_after_current_apodization = 0;
        for el_row = 1 : Ny
            for el_column = 1 : Nx
                if (element_inaccuracy(el_row, el_column) > discard_threshold ...
                    && el_column >= start_new_w && el_column <= end_new_w ...
                    && el_row >= start_new_h && el_row <= end_new_h)
                    elements_to_be_discarded_after_current_apodization = elements_to_be_discarded_after_current_apodization + 1;
                end
            end
        end
        
        message = ['At location phi=', num2str(phi_index), ' of ', num2str(phi_steps), ', theta=', num2str(theta_index), ' of ', num2str(theta_steps), ', r=', num2str(r_index), ' of ', num2str(r_steps), ', ', num2str(elements_to_be_discarded_after_current_apodization), ' elements need discarding (threshold=', num2str(discard_threshold), ' samples) after using the current apodization.'];
        disp(message);
    end
    
    % TODO at times, this code leaves blank, hanging figure windows.

end
