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
%% Initializes and saves to disk the acoustic and probe coefficients for
%% subsequent linear-array 2D beamforming.
%
% Inputs: probe - Description of the probe
%         target_phantom - Phantom name
%         zone_count - If zone imaging is requested (zone_count > 1), how many zones the
%                      image should contain
%         compounding_count - If compound imaging is requested (compounding_count > 1), how
%                             many insonifications to compound
%         image - A structure with fields describing the desired output
%                 output resolution
%         with_static_apodization - 1: use the same apodization along the
%                                   whole volume, 0: expanding aperture
%
% Outputs: apod_full - the apodization-law matrix ("full" as we don't
%                      exploit symmetry to shrink it, yet)
%          el_max - the outermost element that must be included in
%                   beamforming calculations (depends on time and element
%                   directivity)
%          rx_delay - the RX delay-law matrix
%          The TX delay is saved to disk only as it may take too much space in memory.

function [apod_full, el_max, rx_delay] = InitializeBeamforming2DLinear(probe, target_phantom, zone_count, compounding_count, image, with_static_apodization)

    % Probe geometry
    el_width = probe.width;              % Transducer element width [m]
    el_height = 0;                       % Transducer element height [m]
    el_pitch_x = probe.pitch;            % Element pitch [m]: element width plus element kerf
    el_pitch_y = 0;
    n_el_x = probe.N_elements;           % Number of transducer elements
    n_el_y = 1;
    
    [~, ~, ~, image_lower_limit_N, xz_sector, yz_sector] = GetPhantomCoordinates(probe, image);
    
    % Time and sampling frequency
    ts = 1 / probe.fs;                   % RX sampling interval [s]

    %% Define apodization matrix and el_max (full geometry, ignoring symmetry around center aperture-element)
    % A scatterer on a line of sight is only visible from an
    % element on the probe that sits < delta_max off-axis
    delta_max = GetProbeElementDirectivity(probe);
    tangent_max = tan(delta_max); % calculated only once for speed
    
    % Initialize matrices.
    el_max = zeros(image_lower_limit_N, 1);
    radius_max = probe.c * image_lower_limit_N * ts / 2;
    width_han_max = radius_max * tangent_max;
    % Centered at n_el_x + 1 (edge of the matrix)
    apod_full = zeros(2 * n_el_x + 1, image_lower_limit_N);
    
    % Calculate the beamforming tables along the central line of sight
    for radius_index = 1 : image_lower_limit_N
        radius = probe.c * radius_index * ts / 2;
        % Max distance of a probe element from the probe center that still
        % allows that element to see the point:
        width_han = radius * tangent_max;           % Half-width to consider for Hanning apodization at that depth, in [m]
        % And therefore, farthest element to consider:
        n_width_han = round(width_han / el_pitch_x);  % Half-width to consider for Hanning at that depth, in element count
        % Max element-distance number to consider (one-sided)
        if (with_static_apodization)
            el_max(radius_index) = n_el_x / 2 - 1;
        else
            el_max(radius_index) = min(n_width_han, n_el_x / 2 - 1);
        end
        % Define a Hanning apodization window with a width
        % defined by el_max (i.e. changing over time and dependent on directivity)
        % During actual beamforming, this window will be centered appropriately.
        rows = 1 + 2 * el_max(radius_index);
        han = hanning(rows);
        apod_full((n_el_x + 1 - el_max(radius_index)) : (n_el_x + 1 + el_max(radius_index)), radius_index) = han;  % center at the edge of the matrix
        % TODO optimization: as this matrix is symmetrical, it could be reduced to half its size
    end
    
    %% Define focusing delay matrix
    
    % First, consider the delay from emission to the signal peak.
    % The convolution models the response of the probe; note that
    % we do two of them, because the probe response happens in both
    % TX and RX (we club both of them in the TX delay)
    excitation_impulse = conv(probe.impulse_response, conv(probe.impulse_response, probe.excitation));
    excitation_envelope = abs(hilbert(excitation_impulse));
    excitation_peak_time = find(excitation_envelope == max(excitation_envelope));
    
    % The TX delay matrix is explicitly calculated for every focal point in
    % the volume of interest.
    % By default, one image line per element. Can be changed up or down.
    % However, if a different number of lines is chosen in the
    % "with_exact_delays == 0" mode in Beamform2D, this table must be an
    % integer multiple of the chosen number of lines.
    azimuth_lines = n_el_x;
    azimuth_line_pitch = probe.transducer_width / azimuth_lines;
    insonification_count = compounding_count * zone_count;
    
    if (probe.tx_focus == 0)
        % Plane wave
        radius = probe.c * (1 : image_lower_limit_N) * ts / 2;
        for insonification_index = 1 : insonification_count
            % In this insonification mode, assume that each zone is
            % insonified by a steered plane wave.
            disp(['Initializing insonification ', num2str(insonification_index), ' of ', num2str(insonification_count)]);
            % Steering angle of the plane wave
            if (compounding_count ~= 1)
                [~, ~, ~, ~, delta, gamma] = GetCompoundingOrigin(probe, image, insonification_index);
            else
                delta = - xz_sector / 2 + (mod(insonification_index - 1, zone_count) + 0.5) * xz_sector / zone_count;
                gamma = - yz_sector / 2 + (floor((insonification_index - 1) / zone_count) + 0.5) * yz_sector / zone_count;
            end
            tx_offset = abs((el_width / 2 - probe.transducer_width / 2) * sin(delta)) / probe.c / ts;
            for azimuth_index = 1 : azimuth_lines
                xS = - probe.transducer_width / 2 + (azimuth_index - 0.5) * azimuth_line_pitch;
                zS = radius;
                distance = xS * sin(delta) + zS * cos(delta);
                tx_delay(azimuth_index, :) = distance / probe.c / ts + tx_offset + excitation_peak_time;
            end
            StoreTXDelayToDisk(target_phantom, insonification_index, tx_delay);
        end
    elseif (probe.tx_focus == 1 || probe.tx_focus == 3)
        % Converging beam
        for insonification_index = 1 : insonification_count
            % In this insonification mode, assume that each zone has a
            % focal point F with zF at the mid-depth of the volume, xF
            % and yF being swept across in intervals.
            % The TX delay cannot be perfectly accurate: the waves arrive
            % to any point in the volume, except F, spread in time. The
            % precomputed value only works well close to the focus point.
            disp(['Initializing insonification ', num2str(insonification_index), ' of ', num2str(insonification_count)]);
            
            % measure_average:
            % 1: try to figure out the average TX delay from each D to the given S,
            % knowing that the timing is designed for focus at F.
            % 0: just compute the TX delay from the central D to the given S.
            % This is much faster.
            measure_average = 0;
            
            zF = (image.target_shallow_bound + image.target_depth) / 2;
            xF = zF * tan(- xz_sector / 2 + (mod(insonification_index - 1, zone_count) + 0.5) * xz_sector / zone_count);
            yF = zF * tan(- yz_sector / 2 + (floor((insonification_index - 1) / zone_count) + 0.5) * yz_sector / zone_count);
            xD = (0 : n_el_x - 1) * el_pitch_x + el_width / 2 - probe.transducer_width / 2;
            yD = 0;
            DF = sqrt((xD - xF) .^ 2 + (yD - yF) ^ 2 + zF ^ 2);
            tx_time_to_F = DF / probe.c / ts;
            % Field uses as time origin the point (0, 0, 0) (unless
            % changed). Therefore, the emission instants can be either
            % positive or negative, depending on whether a given D is
            % closer or farther from F than the origin.
            reference_tx_time_to_F = sqrt(xF ^ 2 + yF ^ 2 + zF ^ 2) / probe.c / ts;
            tx_emission_instant = reference_tx_time_to_F - tx_time_to_F;
            for azimuth_index = 1 : azimuth_lines
                for radius_index = 1 : image_lower_limit_N
                    radius = probe.c * radius_index * ts / 2;
                    xS = - probe.transducer_width / 2 + (azimuth_index - 0.5) * azimuth_line_pitch;
                    yS = 0;
                    zS = radius;
                    if (measure_average == 1)
                        DS = sqrt((xD - xS) .^ 2 + (yD - yS) .^ 2 + zS .^ 2);
                        tx_time_to_S = DS / probe.c / ts;
                        tx_arrival_at_S = tx_emission_instant + tx_time_to_S;
                        tx_delay(azimuth_index, radius_index) = mean(tx_arrival_at_S) + excitation_peak_time;
                    else
                        DS = sqrt(xS ^ 2 + yS ^ 2 + zS ^ 2);
                        tx_time_to_S = DS / probe.c / ts;
                        % Due to the way Field simulates the
                        % insonification, the central element is
                        % excited at time 0.
                        tx_arrival_at_S = 0 + tx_time_to_S;
                        tx_delay(azimuth_index, radius_index) = tx_arrival_at_S + excitation_peak_time;
                    end
                end
            end
            StoreTXDelayToDisk(target_phantom, insonification_index, tx_delay);
        end
    elseif (probe.tx_focus == 2)
        % Diverging beam
        virtual_source_radius = (probe.transducer_width / 2) / tan(xz_sector / zone_count / 2);
        for insonification_index = 1 : insonification_count
            % In this insonification mode, if the probe is a linear array, always
            % use the same diverging insonification.
            disp(['Initializing insonification ', num2str(insonification_index), ' of ', num2str(insonification_count)]);
            xO = 0;
            yO = 0;
            zO = - virtual_source_radius;
            % The time origin of the insonification is not at the
            % emission from the virtual source, but at the
            % excitation of the central element
            tx_offset = virtual_source_radius / probe.c / ts;
            radius = probe.c * (1 : image_lower_limit_N) * ts / 2;
            for azimuth_index = 1 : azimuth_lines
                xS = - probe.transducer_width / 2 + (azimuth_index - 0.5) * azimuth_line_pitch;
                yS = 0;
                zS = radius;
                OS = sqrt((xS - xO) .^ 2 + (yS - yO) .^ 2 + (zS - zO) .^ 2);
                tx_delay(azimuth_index, :) = (OS / probe.c / ts) - tx_offset + excitation_peak_time;
            end
            StoreTXDelayToDisk(target_phantom, insonification_index, tx_delay);
        end
    elseif (probe.tx_focus == 4)
         % Weakly converging beam. Same as modes 1/3 if focus_weakness == 0.
         % TODO
    end
    
    % The RX delay matrix is calculated for every pair (R, D) where:
    % - D is each transducer element
    % - R is a focal point with coordinates (x = xR [in front of the 1st probe element], y = 0, z = radius)
    % in the volume of interest.
    rx_delay = zeros(n_el_x, image_lower_limit_N);
    for radius_index = 1 : image_lower_limit_N
        radius = probe.c * radius_index * ts / 2;
        xR = el_width / 2 - probe.transducer_width / 2;
        for col = 1 : n_el_x
            xD = (col - 1) * el_pitch_x + el_width / 2 - probe.transducer_width / 2;
            yD = 0;
            rx_delay_RD = sqrt((xD - xR) ^ 2 + yD ^ 2 + radius ^ 2) / probe.c / ts;
            rx_delay(col, radius_index) = rx_delay_RD;
        end
    end
    
    cd(fileparts(mfilename('fullpath')));
    save('../data/apod_full.mat', 'apod_full');
    save('../data/el_max.mat', 'el_max');
    save('../data/rx_delay.mat', 'rx_delay');

    %% Debug features
    if (0)
        figure, plot(apod_full), title('Apodization matrix');
        figure, imagesc(apod_full), title('Apodization matrix'), colorbar;
        for insonification_index = 1 : insonification_count
            plot_title = ['TX Delay matrix for insonification ', num2str(insonification_index), ' of ', num2str(insonification_count)];
            tx_delay = LoadTXDelayFromDisk(target_phantom, insonification_index);
            figure, imagesc(tx_delay), title(plot_title);
        end
        figure, imagesc(rx_delay), title('RX Delay matrix');
    end
end