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
% NOTE: Field II must be running before this function is called.
%
% Inputs: phantom - Description of the phantom; a struct holding the two following fields:
%                   phantom.pos - Nx3 array containing the scatterers' positions
%                   phantom.amp - N-long column vector holding the scatterers' amplitudes
%         probe - Description of the probe
%         image - A structure with fields describing the desired output
%                 resolution
%         zone_count - If zone imaging is requested (zone_count > 1), how many zones the
%                      image should contain
%         compounding_count - If compound imaging is requested (compounding_count > 1), how
%                             many insonifications to compound
%         insonification_index - If zone/compound imaging is requested, which
%                                insonification is happening now
%         with_brightness_compensation - Whether to calculate a brightness compensation
%                                        map for later use in beamforming
%
% Outputs: rf - Radio-frequency matrix containing the raw data of the
%               backscattered echoes
%          t0 - Time delay from emission until receiving the first echoes
%          brightness_comp - Brightness compensation map due to non-even field
%                            focusing

function [rf, t0, brightness_comp] = SimulateRawData2D(phantom, probe, image, zone_count, compounding_count, insonification_index, with_brightness_compensation)

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
    % Attenuation enabling 
    set_field('use_att', 1);
    set_field('att', 1 * 100); % 1 dB/cm attenuation
    
    [~, ~, image_upper_limit_N, image_lower_limit_N, sector_xz, sector_yz] = GetPhantomCoordinates(probe, image);

    if (compounding_count ~= 1)
        insonification_count = compounding_count;
    else
        insonification_count = zone_count;
    end
    
    %% Transmission properties
    probe.th = xdc_focused_array(probe.N_elements, probe.width, probe.height, probe.kerf, probe.elevation_focus_radius, sub_elements_x, sub_elements_y, probe.focus);
    xdc_excitation(probe.th, probe.excitation);
    xdc_impulse(probe.th, probe.impulse_response);
    xdc_center_focus(probe.th, [0 0 0]);
    if (probe.tx_focus == 0)
        % Plane wave
        % In this insonification mode, assume that each
        % insonification is a steered plane wave.
        % Steering angle of the plane wave
        if (compounding_count ~= 1)
            [~, ~, ~, ~, delta, gamma] = GetCompoundingOrigin(probe, image, insonification_index);
        else
            delta = - sector_xz / 2 + (mod(insonification_index - 1, zone_count) + 0.5) * sector_xz / zone_count;
            gamma = - sector_yz / 2 + (floor((insonification_index - 1) / zone_count) + 0.5) * sector_yz / zone_count;
        end
        % This should also work, but for some reason yields quite worse results (TODO: why???):
        %infinite_depth = 10;         % Focusing at 10m approximates a plane wave
        %xdc_focus(probe.th, 0, [infinite_depth * tan(delta) 0 infinite_depth]);
        x = (0 : probe.N_elements - 1) * probe.pitch + probe.width / 2 - probe.transducer_width / 2;
        offset_profile = x * sin(delta) / probe.c;
        xdc_focus_times(probe.th, 0, offset_profile - min(offset_profile));
    elseif (probe.tx_focus == 1 || probe.tx_focus == 3)
        % Converging beam
        % In this insonification mode, assume that each insonification is
        % focused at a point F, with zF at the mid-depth of the volume, xF
        % and yF being swept across in intervals.
        transmit_focus_depth = (probe.phantom_bbox.min_z + probe.phantom_bbox.max_z) / 2;
        transmit_focus_offset = transmit_focus_depth * tan(- sector_xz / 2 + (mod(insonification_index - 1, zone_count) + 0.5) * sector_xz / zone_count);
        transmit_focus_elevation = transmit_focus_depth * tan(- sector_yz / 2 + (floor((insonification_index - 1) / zone_count) + 0.5) * sector_yz / zone_count);
        xdc_focus(probe.th, 0, [transmit_focus_offset transmit_focus_elevation transmit_focus_depth]);
    elseif (probe.tx_focus == 2)
        % Diverging beam
        % In this insonification mode, if the probe is linear, always
        % use the same diverging insonification. If the probe is a phased array:
        % If zone imaging: insonify in the direction identified by the sector's center in each zone.
        % If compound imaging: steer the beam according to a list of angles.
        if (probe.linear == 1)
            virtual_source_radius = (probe.transducer_width / 2) / tan(sector_xz / zone_count / 2);
            xO = 0;
            yO = 0;
            zO = - virtual_source_radius;
        else
            if (compounding_count ~= 1)
                [virtual_source_radius, xO, yO, zO, ~, ~] = GetCompoundingOrigin(probe, image, insonification_index);
            else
                virtual_source_radius = (probe.transducer_width / 2) / tan(sector_xz / zone_count / 2);
                % For single-zone insonification,
                % O = (0, 0, -(probe.transducer_width / 2) / tan(sector_xz / 2))
                % (just behind the center of the transducer).
                zone_width = sector_xz / zone_count;
                zone_height = sector_yz / zone_count;
                central_angle_azimuth = - sector_xz / 2 + mod(insonification_index - 1, zone_count) * zone_width + (zone_width / 2);
                central_angle_elevation = - sector_yz / 2 + (floor((insonification_index - 1) / zone_count)) * zone_height + (zone_height / 2);
                xO = - virtual_source_radius * sin(central_angle_azimuth);
                yO = - virtual_source_radius * sin(central_angle_elevation) * cos(central_angle_azimuth);
                zO = - virtual_source_radius * cos(central_angle_elevation) * cos(central_angle_azimuth);
            end
        end

        x = - probe.transducer_width / 2 + (0 : probe.N_elements - 1) * probe.pitch + probe.width / 2;
        y = 0;
        distance_from_vs = sqrt((x - xO) .^ 2 + (y - yO) .^ 2 + (0 - zO) ^ 2);
        % The time origin of the insonification is not at the
        % emission from the virtual source, but at the
        % excitation of the central element
        offset_profile = (distance_from_vs - virtual_source_radius) / probe.c;
        xdc_focus_times(probe.th, 0, offset_profile);
    elseif (probe.tx_focus == 4)
        % Weakly converging beam. Same as modes 1/3 if focus_weakness == 0.
        % TODO
%        % Else, focus is spread around by a width of "focus_weakness" [m].
%        focus_weakness = 0.005;
%        transmit_focus_depth = (probe.phantom_bbox.min_z + probe.phantom_bbox.max_z) / 2;
%        if (zone_count == 1)
%            transmit_focus_offset = (probe.phantom_bbox.min_x + probe.phantom_bbox.max_x) / 2;
%        else
%            transmit_focus_offset = transmit_focus_depth * tan(- sector / 2 + (zone_index - 0.5) * sector / zone_count);
%        end
%        for i = 1 : probe.N_elements
%            x = (i - 1) * probe.pitch + probe.width / 2 - probe.transducer_width / 2;
%            % This element focuses not on the X of the focal point, but
%            % slightly off, depending on the "focus_weakness" control
%            x_from_focus(i) = x - transmit_focus_offset + ((i - ((probe.N_elements + 1) / 2)) / probe.N_elements) * focus_weakness;
%        end
%        distance_from_focus = sqrt(x_from_focus .^ 2 + transmit_focus_depth ^ 2);
%        offset_profile = (max(distance_from_focus) - distance_from_focus) / probe.c;
%        xdc_focus_times(probe.th, 0, offset_profile);
    end
    xdc_apodization(probe.th, 0, probe.tx_apo);
    xdc_baffle(probe.th, 1);      % Soft baffle

    %% Reception properties
    probe.rh = xdc_focused_array(probe.N_elements, probe.width, probe.height, probe.kerf, probe.elevation_focus_radius, sub_elements_x, sub_elements_y, probe.focus);
    xdc_excitation(probe.rh, probe.excitation);
    xdc_impulse(probe.rh, probe.impulse_response);
    xdc_center_focus(probe.rh, [0 0 0]);
    xdc_focus(probe.rh, 0, [0 0 10]); % Native focus at infinity - we want to focus manually in beamform
    xdc_apodization(probe.rh, 0, probe.rx_apo);
    xdc_baffle(probe.rh, 1);      % Soft baffle

    %% Launch the actual simulation with the probe and phantom as parameters
    disp(['Insonification ', num2str(insonification_index), ' of ', num2str(insonification_count)]);
    [rf, t0] = calc_scat_multi(probe.th, probe.rh, phantom.pos, phantom.amp);

    % The first slice (time duration "t0") of the "rf" matrix is chopped
    % by Field II because it contains no echoes yet. Thus, restore it.
    % In some cases, "t0" can be negative. This happens when the scatterers
    % are very close to the probe surface and the emission angle is
    % extermely aside (i.e. in compounding or zone imaging). We account for 
    % that case by dropping the echoes coming before time t = 0.
    rf = [zeros(max(round(t0 * probe.fs), 0), probe.N_elements); rf]';
    
    %% Brightness Compensation
    % If the feature is not requested, the brightness compensation map is all 1s.
    % The map has a resolution of 1' radially and 1 mm axially.
    samples_per_mm = 0.001 / probe.c * probe.fs;
    depth_locations = ((image_upper_limit_N : samples_per_mm : image_lower_limit_N) * probe.c / (2 * probe.fs))';
    depth_samples = size(depth_locations, 1);
    xz_samples = round(rad2deg(sector_xz / zone_count));
    yz_samples = max(1, round(rad2deg(sector_yz / zone_count)));
    brightness_comp = ones(depth_samples, xz_samples, yz_samples);
    if (with_brightness_compensation == 1)
        disp(['Calculating the brightness compensation map for zone ', num2str(insonification_index), ' of ', num2str(insonification_count)]);
        intensity = zeros(depth_samples, xz_samples, yz_samples);
        % 1 line per degree, in the zone of interest
        phi_start = -(sector_yz / 2) + (floor((insonification_index - 1) / zone_count) * sector_yz / zone_count);
        theta_start = -(sector_xz / 2) + (mod(insonification_index - 1, zone_count) * sector_xz / zone_count);
        for yz_line_index = 1 : yz_samples
            if (image.elevation_lines == 1)
                phi = 0;
            else
                phi = phi_start + deg2rad(yz_line_index - 0.5);
            end
            disp(['Phi = ', num2str(rad2deg(phi)), char(176), ' (', num2str(yz_line_index), ' of ', num2str(yz_samples), ')']);
            % TODO this can probably be sped up significantly by first
            % coalescing the X Y Z coordinates and then feeding them to
            % calc_hp in one pass (see PlotEmittedFieldIntensityInSpace.m).
            for xz_line_index = 1 : xz_samples
                theta = theta_start + deg2rad(xz_line_index - 0.5);
                %disp(['Theta = ', num2str(rad2deg(theta)), char(176), ' (', num2str(xz_line_index), ' of ', num2str(xz_samples), ')']);
                X = depth_locations * cos(phi) * sin(theta);
                Y = depth_locations * sin(phi);
                Z = depth_locations * cos(phi) * cos(theta);
                [hp, ~] = calc_hp(probe.th, [X Y Z]);
                intensity(:, xz_line_index, yz_line_index) = max(abs(hp))';
            end
        end
        brightness_comp = brightness_comp ./ intensity;
        
        %% Debug features
        if (0)
            figure, imagesc(brightness_comp(:, :));
            set(gca, 'XTick', (1 : 4 : size(brightness_comp, 2) - 1));          % Location of X ticks
            set(gca, 'XTickLabel', (0.5 : 4 : size(brightness_comp, 2) - 1));   % Labels of X ticks
            set(gca, 'YTick', (1 : round(size(brightness_comp, 1) / 5) : size(brightness_comp, 1) - 1));  % Location of Y ticks
            set(gca, 'YTickLabel', sprintf('%.2f|', (image_upper_limit_N * probe.c * 100 / 2 / probe.fs : ((image_lower_limit_N - image_upper_limit_N) * probe.c * 100 / 2 / probe.fs / 5) : image_lower_limit_N * probe.c * 100 / 2 / probe.fs)));            % Labels of Y ticks
            str = sprintf('Brightness compensation map for zone %d', insonification_index);
            title(str);
            xlabel(['lines on XZ plane [', char(176), ']']);
            ylabel('r [cm]');
        end
    end
    
    %% Debug features
    if (0)
        % Plot the emitted field
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

    xdc_free(probe.th);
    xdc_free(probe.rh);
    
end
