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
%% Defines a phantom comprising multiple cysts in a flat space
%% (X: along the transducer surface, Z: depth).
%
% Inputs: scatterer_count - Number of scatterers in the volume (higher = better definition, slower to simulate).
%
% Outputs: phantom_positions - Position of the scatterers in space (in
%                              meters)
%          phantom_amplitudes - Reflectivity of the scatterers
%          phantom_bbox - Coordinates of a bounding box around
%                         the scatterers' region, so that imaging
%                         can be done on that volume (in meters)

function [phantom_positions, phantom_amplitudes, phantom_bbox] = CystsPhantom(scatterer_count)

    box_width = 70 / 1000;
    box_height = 120 / 1000;
    box_z_center = 60.3 / 1000; % TODO workaround for a weird Field bug when scatterers are too close to the probe face (only shows up in linear).
    cyst_radius = 5 / 1000;     % This semi-fix just leaves 0.3 mm of blank space in front of the transducer.
    
    cyst_count = 6;
    
    cyst_center_x(1) = -10 / 1000;
    cyst_center_y(1) = 0;
    cyst_center_z(1) = 30 / 1000;
    cyst_reflectivity(1) = 32; % +15dB
    
    cyst_center_x(2) = -10 / 1000;
    cyst_center_y(2) = 0;
    cyst_center_z(2) = 60 / 1000;
    cyst_reflectivity(2) = 16; % +12dB
    
    cyst_center_x(3) = -10 / 1000;
    cyst_center_y(3) = 0;
    cyst_center_z(3) = 90 / 1000;
    cyst_reflectivity(3) = 4; % +6dB
    
    cyst_center_x(4) = 10 / 1000;
    cyst_center_y(4) = 0;
    cyst_center_z(4) = 30 / 1000;
    cyst_reflectivity(4) = 1 / 32; % -15dB
    
    cyst_center_x(5) = 10 / 1000;
    cyst_center_y(5) = 0;
    cyst_center_z(5) = 60 / 1000;
    cyst_reflectivity(5) = 1 / 16; % -12dB
    
    cyst_center_x(6) = 10 / 1000;
    cyst_center_y(6) = 0;
    cyst_center_z(6) = 90 / 1000;
    cyst_reflectivity(6) = 1 / 4; % -6dB
    
    % Randomly (i.e. Gaussian distribution) generate positions and amplitudes
    % of the scatterers in a cubic volume that bounds the sphere
    x = (rand(scatterer_count, 1) - 0.5) * box_width;
    y = (rand(scatterer_count, 1) - 0.5) * box_width;
    z = (rand(scatterer_count, 1) - 0.5) * box_height + box_z_center;
    pos = [x y z];
    
    % The amplitude (i.e. reflectivity) of the scatterers that construct the phantom.
    %amp = rand(scatterers_per_volume, 1) * amplitude;
    amp = ones(scatterer_count, 1);  % background brightness 0dB
    
    % Define cyst reflectivity
    for i = 1 : cyst_count
        distance_from_cyst_center = ((x - cyst_center_x(i)) .^2 + (y - cyst_center_y(i)) .^2 + (z - cyst_center_z(i)) .^2);
        outside_cyst = (distance_from_cyst_center <= cyst_radius ^ 2);
        valid_cyst_scatterer_index = find(outside_cyst == 1);
        amp(valid_cyst_scatterer_index, :) = cyst_reflectivity(i) * amp(valid_cyst_scatterer_index, :);
    end
    
    phantom_positions = pos;
    phantom_amplitudes = amp;    
    
    frame = 0 / 1000; %15 / 1000;   % How much "black space" to leave around the phantom in the image (in meters)
    phantom_bbox.min_x = -box_width / 2 - frame;
    phantom_bbox.max_x = box_width / 2 + frame;
    phantom_bbox.min_y = -box_width / 2 - frame;
    phantom_bbox.max_y = box_width / 2 + frame;
    phantom_bbox.min_z = max(0, box_z_center - box_height / 2 - frame);
    phantom_bbox.max_z = box_z_center + box_height / 2 + frame;
    
    warning('The phantom contains %d scatterers', scatterer_count);

end
