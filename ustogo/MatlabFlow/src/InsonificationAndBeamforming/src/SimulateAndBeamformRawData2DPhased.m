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
%% Insonifies a given phantom with a Field II simulation, on a 2D plane.
%% Relies on Field II also for beamforming, assuming a phased array.
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

function [rf] = SimulateAndBeamformRawData2DPhased(phantom, probe, tx_focus, apod_full, el_max, image)

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
    % These two are exclusively for Field II insonification accuracy (not
    % a real physical property): higher value -> more accurate, but slower
    sub_elements_x = 5;           %  Number of virtual elements x-wise
    sub_elements_y = 10;          %  Number of virtual elements y-wise
    % Sampling rate of the probe
    set_sampling(probe.fs);

    [~, ~, image_upper_limit_N, image_lower_limit_N, sector, ~] = GetPhantomCoordinates(probe, image);

    %% Transmission properties
    probe.th = xdc_focused_array(probe.N_elements, probe.width, probe.height, probe.kerf, probe.elevation_focus_radius, sub_elements_x, sub_elements_y, probe.focus);
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
        transmit_focus_depth = (probe.phantom_bbox.min_z + probe.phantom_bbox.max_z) / 2;
        xdc_focus(probe.th, 0, [transmit_focus_offset 0 transmit_focus_depth]);
    else
        % Diverging beam
        virtual_source_depth = -(probe.transducer_width / 2) / tan(sector / 2);
        for i = 1 : probe.N_elements
            x = (i - 1) * probe.pitch + probe.width / 2;
            x_from_vs(i) = x - probe.transducer_width / 2;
        end
        distance_from_vs = sqrt(x_from_vs .^ 2 + virtual_source_depth ^ 2);
        offset_profile = (distance_from_vs - min(distance_from_vs)) / probe.c;
        xdc_focus_times(probe.th, 0, offset_profile);
    end
    xdc_apodization(probe.th, 0, probe.tx_apo);
    xdc_baffle(probe.th, 1);      % Soft baffle

    %% Reception properties
    probe.rh = xdc_focused_array(probe.N_elements, probe.width, probe.height, probe.kerf, probe.elevation_focus_radius, sub_elements_x, sub_elements_y, probe.focus);
    xdc_excitation(probe.rh, probe.excitation);
    xdc_impulse(probe.rh, probe.impulse_response);
    % Focus and apodization defined below.
    xdc_baffle(probe.rh, 1);      % Soft baffle

    %% Launch the actual simulation with the probe and phantom as parameters
    % Image a symmetrical conical sector (measured in [rad]) around the
    % phantom, with a 40% lateral margin
    if (image.azimuth_lines == -1)
        no_lines = round(sector * 180 / pi); % By default, one image line per degree
    else
        no_lines = image.azimuth_lines;
    end
    d_theta = sector / no_lines;
    theta = - sector / 2;
    rf = zeros(ceil((2 * probe.phantom_bbox.max_z / probe.c) * probe.fs), no_lines);

    % Create a vector of indices in [m] at each mm from the transducer
    % surface to the lower edge of the image. Then calculate the corresponding
    % time of flight for returning echoes in [s] (uni-directional flight).
    % This will serve as the timeline for dynamically focusing in receive
    focus_points = (1 / 1000 : 0.1 / 1000 : probe.phantom_bbox.max_z)';
    focus_times = focus_points / probe.c;

    %% Time-Gain Compensation (TGC) vector: compensate RX amplitudes for propagation attenuation
    atten_dB_cm = 1;                       % Attenuation coefficient [dB/cm]
    tgc = 10.^(atten_dB_cm / 20 * probe.c * (1 : image_lower_limit_N) * 1 / probe.fs * 1e2);
    tgc_elements = ones(size(apod_full, 1), 1) * tgc; % ULA-OP style
    % Factor TGC into the apodization table
    apod_full = tgc_elements .* apod_full;
    % Used later to specify at what times apodization is worth what
    apodization_timeline = (1 : image_lower_limit_N)' / probe.fs;
    
    % Gather echoes line-of-sight by line-of-sight across the whole
    % plane or sector, according to the configured number of lines of sight
    for i = 1 : no_lines
        message = ['Insonifying and beamforming line of sight ', num2str(i), ' of ', num2str(no_lines)];
        disp(message);

        %% Transmit focus
        % For cases tx_focus == 0-2, the focusing was done outside the loop already.
        if (tx_focus == 3)
            % Refocus for each line of sight.
            xdc_center_focus(probe.th, [0 0 0]);
            xdc_focus(probe.th, 0, [transmit_focus_depth * sin(theta) 0 transmit_focus_depth * cos(theta)]);
        end

        %% Transmit apodization
        xdc_apodization(probe.th, 0, probe.tx_apo);

        %% Receive focus
        % Receive focus changes according to a timeline, also along the line
        % of sight, but at varying distance from the probe
        xdc_center_focus(probe.rh, [0 0 0]);
        xdc_focus(probe.rh, focus_times, [focus_points * sin(theta) zeros(size(focus_points)) focus_points * cos(theta)]);
        % Can also use xdc_dynamic_focus(probe.rh, ...);

        %% Receive apodization
        rx_apo = zeros(image_lower_limit_N, probe.N_elements);
        % Apply Selfridge and Kino directivity model to elements. Since
        % steered lines of sight are attenuated due to element directivity,
        % we should compensate for that here.
        x = probe.f0 / probe.c * probe.width .* sin(theta);
        directivity_factor = 1 / (sinc(x) .* cos(theta));
        for nt = 1 : image_lower_limit_N
            el_inf = probe.N_elements / 2 - el_max(nt);
            el_sup = probe.N_elements / 2 + el_max(nt) + 1;
            rx_apo(nt, el_inf : el_sup) = directivity_factor * apod_full(el_inf : el_sup, nt)'; % TODO it is unclear why we have to add this directivity factor
        end
        xdc_apodization(probe.rh, apodization_timeline, rx_apo);

        % Next line of sight
        theta = theta + d_theta;
        
        %% Debug features
        if (0 && i == round(no_lines / 2))
            % RX apodization matrix
            figure, imagesc(rx_apo), title('RX Apodization compensated for directivity and TGC'), colorbar;

            % Emitted field
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
        rf(blank_echoes : (blank_echoes + max(size(rf_line)) - 1), i) = rf_line;
    end

    % If necessary, crop away the unwanted shallow band
    rf = rf(image_upper_limit_N : image_lower_limit_N, :);

    xdc_free(probe.th);
    xdc_free(probe.rh);
    
end
