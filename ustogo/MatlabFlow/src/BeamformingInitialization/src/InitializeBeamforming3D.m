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
%% subsequent phased-array 3D beamforming.
%
% Inputs: probe - Description of the probe
%         target_phantom - Phantom name
%         zone_count - If zone imaging is requested (zone_count > 1), how many zones the
%                      image should contain (zone_count * zone_count)
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

function [apod_full, el_max, rx_delay] = InitializeBeamforming3D(probe, target_phantom, zone_count, compounding_count, image, with_static_apodization)
    
    % Probe geometry
    el_width = probe.width;              % Transducer element width [m]
    el_height = probe.height;            % Transducer element height [m]
    el_pitch_x = probe.pitch_x;          % Element pitch [m]: element width plus element kerf
    el_pitch_y = probe.pitch_y;          % TODO Assumes the same as pitch_x
    n_el_x = probe.N_elements_x;         % Number of transducer elements
    n_el_y = probe.N_elements_y;
    
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
    % Centered at n_el_x / 2, n_el_y / 2 (center of the matrix)
    apod_full = zeros(n_el_x, n_el_y, image_lower_limit_N);
    
    % Calculate the beamforming tables along the central line of sight
    for radius_index = 1 : image_lower_limit_N
        radius = probe.c * radius_index * ts / 2;
        % Max distance of a probe element from the probe center that still
        % allows that element to see the point:
        width_han = radius * tangent_max;           % Half-width to consider for Hanning apodization at that depth, in [m]
        % And therefore, farthest element to consider:
        n_width_han = round(width_han / el_pitch_x);  % Half-width to consider for Hanning at that depth, in element count
        % Max element-distance number to consider (one-sided)
        % TODO assumes symmetry
        if (with_static_apodization)
            el_max(radius_index) = n_el_x / 2 - 1;
        else
            el_max(radius_index) = min(n_width_han, n_el_x / 2 - 1);
        end
        % Define a Hanning apodization window with a width
        % defined by el_max (i.e. changing over time and dependent on directivity)
        % During actual beamforming, this window will be centered appropriately.
        rows = 2 + 2 * el_max(radius_index);
        columns = 2 + 2 * el_max(radius_index);
        matrix_diagonal = sqrt(((columns - 1) * el_pitch_x) ^ 2 + ((rows - 1) * el_pitch_y) ^ 2);
        han_matrix = zeros(rows, columns);
        center_y = ((1 : rows) - 0.5 * (1 + rows)) * el_pitch_y;
        for col = 1 : columns
            center_x = (col - 0.5 * (1 + columns)) * el_pitch_x;
            % 2D Hanning function
            han_matrix(:, col) = 0.54 + 0.46 * cos(2 * pi * sqrt(center_x ^ 2 + center_y .^ 2) / matrix_diagonal);
        end
        % han_matrix = 2.^round(log2(han_matrix)); % power-of-2 Hanning
        apod_full((n_el_y / 2 - el_max(radius_index)) : (n_el_y / 2 + el_max(radius_index) + 1), ...
                  (n_el_x / 2 - el_max(radius_index)) : (n_el_x / 2 + el_max(radius_index) + 1), radius_index) = han_matrix;
        % TODO optimization: as this matrix is symmetrical, it could be reduced to one fourth its size
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
    % By default, one image line per degree
    if (image.azimuth_lines == -1)
        azimuth_lines = round(xz_sector * 180 / pi);
    else
        azimuth_lines = image.azimuth_lines;
    end
    if (image.elevation_lines == -1)
        elevation_lines = min(1, round(yz_sector * 180 / pi));
    else
        elevation_lines = image.elevation_lines;
    end
    insonification_count = compounding_count * zone_count * zone_count;
    
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
            for elev_index = 1 : elevation_lines
                phi = - yz_sector / 2 + (elev_index - 0.5) * yz_sector / elevation_lines;
                for azimuth_index = 1 : azimuth_lines
                    theta = - xz_sector / 2 + (azimuth_index - 0.5) * xz_sector / azimuth_lines;
                    distance_scaling = (cos(delta - theta) + cos(theta) * cos(delta) * (cos(phi - gamma) - 1));
                    tx_delay(elev_index, azimuth_index, :) = radius * distance_scaling / probe.c / ts + excitation_peak_time;
                end
            end
            tx_offset = - min(tx_delay(:));
            StoreTXDelayToDisk(target_phantom, insonification_index, tx_delay + tx_offset);
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
            yD = (0 : n_el_y - 1) * el_pitch_y + el_height / 2 - probe.transducer_width / 2;
            [xD, yD] = meshgrid(xD, yD);
            DF = sqrt((xD - xF) .^ 2 + (yD - yF) .^ 2 + zF ^ 2);
            tx_time_to_F = DF / probe.c / ts;
            % Field uses as time origin the point (0, 0, 0) (unless
            % changed). Therefore, the emission instants can be either
            % positive or negative, depending on whether a given D is
            % closer or farther from F than the origin.
            reference_tx_time_to_F = sqrt(xF ^ 2 + yF ^ 2 + zF ^ 2) / probe.c / ts;
            tx_emission_instant = reference_tx_time_to_F - tx_time_to_F;
            for elev_index = 1 : elevation_lines
                phi = - yz_sector / 2 + (elev_index - 0.5) * yz_sector / elevation_lines;
                for azimuth_index = 1 : azimuth_lines
                    theta = - xz_sector / 2 + (azimuth_index - 0.5) * xz_sector / azimuth_lines;            
                    for radius_index = 1 : image_lower_limit_N
                        radius = probe.c * radius_index * ts / 2;
                        xS = radius * sin(theta);
                        yS = radius * sin(phi) * cos(theta);
                        zS = radius * cos(phi) * cos(theta);
                        if (measure_average == 1)
                            DS = sqrt((xD - xS) .^ 2 + (yD - yS) .^ 2 + zS .^ 2);
                            tx_time_to_S = DS / probe.c / ts;
                            tx_arrival_at_S = tx_emission_instant + tx_time_to_S;
                            tx_delay(elev_index, azimuth_index, radius_index) = mean(mean(tx_arrival_at_S)) + excitation_peak_time;
                        else
                            DS = sqrt(radius * radius); % == sqrt(xS ^ 2 + yS ^ 2 + zS ^ 2);
                            tx_time_to_S = DS / probe.c / ts;
                            % Due to the way Field simulates the
                            % insonification, the central element is
                            % excited at time 0.
                            tx_arrival_at_S = 0 + tx_time_to_S;
                            tx_delay(elev_index, azimuth_index, radius_index) = tx_arrival_at_S + excitation_peak_time;
                        end
                    end
                end
            end
            StoreTXDelayToDisk(target_phantom, insonification_index, tx_delay);
        end
    elseif (probe.tx_focus == 2)
        % Diverging beam
        for insonification_index = 1 : insonification_count
            % In this insonification mode, insonify in the direction
            % identified by the sector's center in each zone.
            disp(['Initializing insonification ', num2str(insonification_index), ' of ', num2str(insonification_count)]);
            if (compounding_count ~= 1)
                [virtual_source_radius, xO, yO, zO, ~, ~] = GetCompoundingOrigin(probe, image, insonification_index);
            else
                virtual_source_radius = (probe.transducer_width / 2) / tan(xz_sector / zone_count / 2);
                % For single-zone insonification,
                % O = (0, 0, -(probe.transducer_width / 2) / tan(xz_sector / 2))
                % (just behind the center of the transducer).
                zone_width = xz_sector / zone_count;
                zone_height = yz_sector / zone_count;
                central_angle_azimuth =  - xz_sector / 2 + mod(insonification_index - 1, zone_count) * zone_width + (zone_width / 2);
                central_angle_elevation = - yz_sector / 2 + (floor((insonification_index - 1) / zone_count)) * zone_height + (zone_height / 2);
                xO = - virtual_source_radius * sin(central_angle_azimuth);
                yO = - virtual_source_radius * sin(central_angle_elevation) * cos(central_angle_azimuth);
                zO = - virtual_source_radius * cos(central_angle_elevation) * cos(central_angle_azimuth);
            end
            % The time origin of the insonification is not at the
            % emission from the virtual source, but at the
            % excitation of the central element
            tx_offset = virtual_source_radius / probe.c / ts;
            radius = probe.c * (1 : image_lower_limit_N) * ts / 2;
            for elev_index = 1 : elevation_lines
                phi = - yz_sector / 2 + (elev_index - 0.5) * yz_sector / elevation_lines;
                for azimuth_index = 1 : azimuth_lines
                    theta = - xz_sector / 2 + (azimuth_index - 0.5) * xz_sector / azimuth_lines;            
                    xS = radius * sin(theta);
                    yS = radius * sin(phi) * cos(theta);
                    zS = radius * cos(phi) * cos(theta);
                    OS = sqrt((xS - xO) .^ 2 + (yS - yO) .^ 2 + (zS - zO) .^ 2);
                    tx_delay(elev_index, azimuth_index, :) = (OS / probe.c / ts) - tx_offset + excitation_peak_time;
                end
            end
            StoreTXDelayToDisk(target_phantom, insonification_index, tx_delay);
        end
    elseif (probe.tx_focus == 4)
         % Weakly converging beam. Same as modes 1/3 if focus_weakness == 0.
         % TODO
    end
    
    % The RX delay matrix is calculated for every pair (R, D) where:
    % - D is each transducer element
    % - R is a focal point with coordinates (theta = 0, phi = 0, r = radius)
    % in the volume of interest.
    rx_delay = zeros(n_el_x, n_el_y, image_lower_limit_N);
    for radius_index = 1 : image_lower_limit_N
        radius = probe.c * radius_index * ts / 2;
        for row = 1 : n_el_y
            for col = 1 : n_el_x
                xD = (col - 1) * el_pitch_x + el_width / 2 - probe.transducer_width / 2;
                yD = (row - 1) * el_pitch_y + el_height / 2 - probe.transducer_height / 2;
                rx_delay_RD = sqrt(xD ^ 2 + yD ^ 2 + radius ^ 2) / probe.c / ts;
                rx_delay(row, col, radius_index) = rx_delay_RD;
            end
        end
    end
    
    cd(fileparts(mfilename('fullpath')));
    save('../data/apod_full.mat', 'apod_full');
    save('../data/el_max.mat', 'el_max');
    save('../data/rx_delay.mat', 'rx_delay');

    %% Debug features
    if (0)
        radius_index = round(size(apod_full, 3) / 2);
        figure, plot(apod_full(:, :, radius_index)), title(['Apodization matrix at radius index ', num2str(radius_index)]);
        figure, imagesc(apod_full(:, :, radius_index)), title(['Apodization matrix at radius index ', num2str(radius_index)]);
        for insonification_index = 1 : insonification_count
            plot_title = ['TX Delay matrix for insonification ', num2str(insonification_index), ' of ', num2str(insonification_count), ' at radius index ', num2str(radius_index)];
            tx_delay = LoadTXDelayFromDisk(target_phantom, insonification_index);
            figure, imagesc(tx_delay(:, :, radius_index)), title(plot_title);
        end
        figure, imagesc(rx_delay(:, :, radius_index)), title(['RX Delay matrix at radius index ', num2str(radius_index)]);
    end
end
