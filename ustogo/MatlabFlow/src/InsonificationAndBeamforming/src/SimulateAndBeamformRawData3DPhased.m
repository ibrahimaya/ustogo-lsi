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
%% Insonifies a given phantom with a Field II simulation, in a 3D volume.
%% Relies on Field II also for beamforming, assuming a phased matrix.
% NOTE: Field II must be running before this function is called.
%
% Inputs: phantom - Description of the phantom; a struct holding the two following fields:
%                   phantom.pos - Nx3 array containing the scatterers' positions
%                   phantom.amp - N-long column vector holding the scatterers' amplitudes
%         probe - Description of the probe
%         tx_focus - Type of transmit focus
%         apod_full - the apodization-law matrix ("full" as we don't
%                     exploit symmetry to shrink it, yet)
%         el_max - the outermost element that must be included in
%                  beamforming calculations (depends on time and element
%                  directivity)
%         image - A structure with fields describing the desired output
%                 output resolution
%
% Outputs: rf - Radio-frequency matrix containing the summed backscattered echoes

function [rf] = SimulateAndBeamformRawData3DPhased(phantom, probe, tx_focus, apod_full, el_max, image)

    %% Parameter check
    if nargin < 2
        error('Not enough input arguments.')
    end
    if ~isfield(phantom, 'pos')
        error('phantom: required field missing: pos')
    end
    if ~isfield(phantom, 'amp')
        error('phantom: required field missing: amp')
    end
    if size(phantom.pos, 2) ~= 3
        error('phantom.pos must be a Nx3 matrix')
    end
    if size(phantom.amp, 2) ~= 1
        error('phantom.amp must be a column vector')
    end
    if size(phantom.pos, 1) ~= size(phantom.amp, 1)
        error('The number of given scatterer positions is different from the number of given scatterer amplitudes.')
    end
    if ~isfield(probe, 'fs')
        error('probe: required field missing: fs')
    end
    if ~isfield(probe, 'c')
        error('probe: required field missing: c')
    end
    % TODO more error checking throughout
    
    %% General probe properties
    % We assume 1x1 sub-element grid for Field insonification accuracy (i.e.
    % not the most accurate, but faster)
    % Sampling rate of the probe
    set_sampling(probe.fs);
    
    [image_upper_limit_m, image_lower_limit_m, image_upper_limit_N, image_lower_limit_N, xz_sector, yz_sector] = GetPhantomCoordinates(probe, image);

    %% Probe Design
    % TODO some of this stuff should go into Create2DProbe.m
    use_transmit_apodization = 1;
    
    % See Field documentation (page 38) for the meaning of the columns of
    % the "rect" data structure
    N_elements_total = probe.N_elements_x * probe.N_elements_y;
    rect = zeros(N_elements_total, 19);
    % Column 1: element index
    rect(:, 1) = 1 : N_elements_total;
    % Columns 2 : 13: corner coordinates
    X1 = zeros(N_elements_total, 1);
    X2 = zeros(N_elements_total, 1);
    Y1 = zeros(N_elements_total, 1);
    Y3 = zeros(N_elements_total, 1);
    Z1 = zeros(N_elements_total, 1); 
    C1 = zeros(N_elements_total, 1); 
    C2 = zeros(N_elements_total, 1); 
    el_index = 1;
    for i = 0 : probe.N_elements_y - 1
        for j = 0 : probe.N_elements_x - 1
            % Edges
            X1(el_index) = -((8 - j) * probe.width + (7.5 - j) * probe.kerf_x);
            X2(el_index) = -((7 - j) * probe.width + (7.5 - j) * probe.kerf_x);
            Y1(el_index) = -((8 - i) * probe.height + (7.5 - i) * probe.kerf_y);
            Y3(el_index) = -((7 - i) * probe.height + (7.5 - i) * probe.kerf_y);
            % Center
            C1(el_index) = X1(el_index) + 0.5 * probe.width;
            C2(el_index) = Y1(el_index) + 0.5 * probe.height;
            el_index = el_index + 1;
        end
    end
    X4 = X1;
    X3 = X2;
    Y2 = Y1;
    Y4 = Y3;
    Z2 = Z1; Z3 = Z1; Z4 = Z1;
    C3 = zeros(N_elements_total, 1); 
    rect(:, 2 : 13) = horzcat(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, X4, Y4, Z4);
    % Column 14: apodization
    rect(:, 14) = 1;  % Initialize the apodization with 1s (no apodization).
    % Columns 15, 16: element size
    rect(:, 15) = probe.width;
    rect(:, 16) = probe.height;
    % Columns 17 : 19: center coordinates
    rect(:, 17 : 19) = horzcat(C1, C2, C3);
    center = rect(:, 17 : 19);
    rect_th = rect;
    rect_rh = rect;
    if (use_transmit_apodization == 1)
        % Defines a 2D Hanning, centered on the center of the matrix
        matrix_diagonal = sqrt((probe.transducer_width - probe.width) ^ 2 + (probe.transducer_height - probe.height) ^ 2);
        Hm_xy = 0.54 + 0.46 * cos(2 * pi * sqrt(rect(:, 17) .^ 2 + rect(:, 18) .^ 2) / matrix_diagonal);
        Hm_xy = Hm_xy / mean(Hm_xy);
        rect_th(:, 14) = Hm_xy;
    end
    
    %% Transmission properties
    probe.th = xdc_rectangles(rect_th, center, probe.focus);
    xdc_excitation(probe.th, probe.excitation);
    xdc_impulse(probe.th, probe.impulse_response);
    xdc_center_focus(probe.th, [0 0 0]);
    if (tx_focus == 0)
        % Plane wave
        xdc_focus(probe.th, 0, [0 0 10]);
    elseif (tx_focus == 1 || tx_focus == 3)
        % Converging beam
        % For case 3, the focus will be updated for each insonification.
        transmit_focus_offset = (probe.phantom_bbox.min_x + probe.phantom_bbox.max_x) / 2; 
        transmit_focus_elevation = (probe.phantom_bbox.min_y + probe.phantom_bbox.max_y) / 2;
        transmit_focus_depth = (probe.phantom_bbox.min_z + probe.phantom_bbox.max_z) / 2;
        xdc_focus(probe.th, 0, [transmit_focus_offset transmit_focus_elevation transmit_focus_depth]);
    else
        % Diverging beam
        virtual_source_depth = -(probe.transducer_width / 2) / tan(sector / 2);
        el_index = 1;
        for i = 1 : probe.N_elements_y
            for j = 1 : probe.N_elements_x
                x = (j - 1) * probe.pitch_x + probe.width / 2;
                x_from_vs(el_index) = x - probe.transducer_width / 2;
                y = (i - 1) * probe.pitch_y + probe.height / 2;
                y_from_vs(el_index) = y - probe.transducer_height / 2;
                el_index = el_index + 1;
            end
        end
        distance_from_vs = sqrt(x_from_vs .^ 2 + y_from_vs .^ 2 + virtual_source_depth ^ 2);
        offset_profile = (distance_from_vs - min(distance_from_vs)) / probe.c;
        xdc_focus_times(probe.th, 0, offset_profile);
    end
    % Apodization is not defined here because it comes from rect_th
    xdc_baffle(probe.th, 1);      % Soft baffle

    %% Reception properties
    probe.rh = xdc_rectangles(rect_rh, center, probe.focus);
    xdc_excitation(probe.rh, probe.excitation);
    xdc_impulse(probe.rh, probe.impulse_response);
    % Focus and apodization defined below.
    xdc_baffle(probe.rh, 1);      % Soft baffle

    %% Launch the actual simulation with the probe and phantom as parameters
    % Image a symmetrical conical sector (measured in [rad]) around the
    % phantom, with a 40% lateral margin
    if (image.azimuth_lines == -1)
        no_xz_lines = round(xz_sector * 180 / pi); % By default, one image line per degree
    else
        no_xz_lines = image.azimuth_lines;
    end
    if (image.elevation_lines == -1)
        no_yz_lines = round(yz_sector * 180 / pi); % By default, one image line per degree
    else
        no_yz_lines = image.elevation_lines;
    end
    d_theta = xz_sector / no_xz_lines;
    theta = - xz_sector / 2;
    phi = - yz_sector / 2;
    d_phi = yz_sector / no_yz_lines;

    % Create a vector of indices in [m] at each mm from the transducer
    % surface to the lower edge of the image. Then calculate the corresponding
    % time of flight for returning echoes in [s] (uni-directional flight).
    % This will serve as the timeline for dynamically focusing in receive
    focus_points = (1 / 1000 : 0.1 / 1000 : probe.phantom_bbox.max_z)';
    focus_times = focus_points / probe.c;
    
    rf = zeros(image_lower_limit_N - image_upper_limit_N + 1, no_xz_lines, no_yz_lines);

    %% Time-Gain Compensation (TGC) vector: compensate RX amplitudes for propagation attenuation
    atten_dB_cm = 1;                       % Attenuation coefficient [dB/cm]
    tgc = 10.^(atten_dB_cm / 20 * probe.c * (1 : image_lower_limit_N) * 1 / probe.fs * 1e2);
    tgc_elements = ones(probe.N_elements_x * probe.N_elements_y, 1) * tgc; % ULA-OP style
    tgc_elements = reshape(tgc_elements, probe.N_elements_y, probe.N_elements_x, image_lower_limit_N);
    % Factor TGC into the apodization table
    apod_full = tgc_elements .* apod_full;
    % Used later to specify at what times apodization is worth what
    apodization_timeline = (1 : image_lower_limit_N)' / probe.fs;
    
    % Gather echoes line-of-sight by line-of-sight across the whole 3D
    % plane or sector, according to the configured number of lines of sight
    % Main loop on different elevation angles
    for i = 1 : no_yz_lines
        message = ['Beamforming elevation slice ', num2str(i), ' of ', num2str(no_yz_lines)];
        disp(message);
        rf_slice = zeros(ceil((2 * probe.phantom_bbox.max_z / probe.c) * probe.fs), no_xz_lines);
        theta = - xz_sector / 2;    % Reinitialize theta for each elevation.
        % Inner loop on lines of sight
        for j = 1 : no_xz_lines
            message = ['Insonifying and beamforming line of sight ', num2str(j), ' of ', num2str(no_xz_lines)];
            disp(message);

            %% Transmit focus
            % For cases tx_focus == 0-2, the focusing was done outside the loop already.
            if (tx_focus == 3)
                % Refocus for each line of sight.
                xdc_center_focus(probe.th, [0 0 0]);
                xdc_focus(probe.th, 0, [transmit_focus_depth * sin(theta) * cos(phi) transmit_focus_depth * sin(phi) transmit_focus_depth * cos(theta) * cos(phi)]);
            end
	    
            %% Transmit apodization
            % Stays unchanged
	    
            %% Receive focus
            % Receive focus changes according to a timeline, also along the line
            % of sight, but at varying distance from the probe
            xdc_center_focus(probe.rh, [0 0 0]);
            xdc_focus(probe.rh, focus_times, [focus_points * sin(theta) * cos(phi) focus_points * sin(phi) focus_points * cos(theta) * cos(phi)]);
            % Can also use xdc_dynamic_focus(probe.rh, ...);

            %% Debug features
            % Plot the dynamically chosen focus line (note that we should choose for what line
            % or many plots will need to be calculated)
            if (0 && i == 1 && j == 1)
                focusline = [focus_points * sin(theta) * cos(phi) focus_points * sin(phi) focus_points * cos(theta) * cos(phi)];
                figure, stem3(focusline(:,1), focusline(:,2), focusline(:,3), 'linestyle', 'none'), ...
                xlabel('x (m)'), ylabel('y (m)'), zlabel('z (m)'), ...
                axis([probe.phantom_bbox.min_x probe.phantom_bbox.max_x probe.phantom_bbox.min_y probe.phantom_bbox.max_y probe.phantom_bbox.min_z probe.phantom_bbox.max_z]);
            end
 
            %% Receive apodization
            rx_apo = zeros(image_lower_limit_N, probe.N_elements_y, probe.N_elements_x);
            % Apply Selfridge and Kino directivity model to elements. Since
            % steered lines of sight are attenuated due to element directivity,
            % we should compensate for that here.
            x = probe.f0 / probe.c * probe.width * sin(theta);
            y = probe.f0 / probe.c * probe.height * sin(phi);
            directivity_factor = 1 / (sinc(x) * cos(theta) * sinc(y) * cos(phi));
            for nt = 1 : image_lower_limit_N
                % Horizontal elements:
                el_inf_columns = probe.N_elements_x / 2 - el_max(nt);   
                el_sup_columns = probe.N_elements_x / 2 + el_max(nt) + 1;
                % Vertical elements:
                el_inf_rows = probe.N_elements_y / 2 - el_max(nt);
                el_sup_rows = probe.N_elements_y / 2 + el_max(nt) + 1;
                % Innermost loops on aperture
                rx_apo(nt, el_inf_rows : el_sup_rows, el_inf_columns : el_sup_columns) = directivity_factor * apod_full(el_inf_rows : el_sup_rows, el_inf_columns : el_sup_columns, nt);
            end
            xdc_apodization(probe.rh, apodization_timeline, reshape(rx_apo, image_lower_limit_N, 1, probe.N_elements_x * probe.N_elements_y));

            % Next line of sight
            theta = theta + d_theta;
            
            %% Debug features
            if (0 && i == round(no_yz_lines / 2) && j == round(no_xz_lines / 2))
                % RX apodization matrix
                time_sample = 6000;
                apo_slice = reshape(rx_apo(time_sample, :, :), probe.N_elements_y, probe.N_elements_x);
                size(apo_slice)
                figure, imagesc(apo_slice), title(['RX Apodization compensated for directivity and TGC at time sample of ', num2str(time_sample)]), colorbar;

                % Emitted field
                % TODO also provide a way to specify a Y value
                PlotEmittedFieldIntensityInSpace(probe, ...
                    -30 / 1000, 30 / 1000, 0 / 1000, 50 / 1000, ...
                    0.20 / 1000, ...
                    1, ...
                    1, 30 / 1000, 1, ...
                    1, 0);
                    % Box in which to plot the field
                    % Resolution
                    % 1 = log scale, 0 = linear
                    % Whether to plot a cross-section at the given depth (polar == 0) or distance from origin (polar == 1)
                    % Whether to plot TX aperture (1, 0), RX aperture (0, 1), or two-way (1, 1)
            end
            
            % Insonify and beamform the line of sight
            [rf_line, t0] = calc_scat(probe.th, probe.rh, phantom.pos, phantom.amp);
            % Store the line in the overall RF image. Note that the first
            % slice (time duration "t0") of the "rf" matrix is chopped
            % by Field II because it contains no echoes yet: paste properly
            % in the 0-initialized matrix.
            blank_echoes = floor(t0 * probe.fs);
            rf_slice(blank_echoes : (blank_echoes + max(size(rf_line)) - 1), j) = rf_line;
        end
        
        %% Debug features
        if (0 && i == round(no_yz_lines / 2))
            % TX apodization matrix
            time_sample = 2000;
            figure, plot(Hm_xy), title(['Apodization matrix at time sample of ', num2str(time_sample)]);
            figure, imagesc(reshape(Hm_xy, probe.N_elements_x, probe.N_elements_y)), title(['Apodization matrix at time sample of ', num2str(time_sample)]);
        end
        
        % If necessary, crop away the unwanted shallow band
        rf(:, :, i) = rf_slice(image_upper_limit_N : image_lower_limit_N, :);
        phi = phi + d_phi;
    end
    
    xdc_free(probe.th);
    xdc_free(probe.rh);
    
end
