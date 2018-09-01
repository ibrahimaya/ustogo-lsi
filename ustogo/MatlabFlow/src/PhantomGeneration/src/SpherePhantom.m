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
%% Defines a phantom composed of a sphere in a volume, with a central cyst
%% (X: along the transducer surface, Y: across the transducer surface, Z: depth).
%
% Inputs: center_x, center_y, center_z - Center of the sphere (in meters)
%         inner_r - Radius of the inner cyst sphere (in meters)
%         outer_r - Radius of the outer phantom sphere (in meters)
%         amplitude - Parameter to scale the maximum reflectivity of the
%                     scatterers. Supposed to be in the interval ]0, 1.0].
%         scatterers_per_volume - How many scatterers a cubic volume bounding
%                                 the sphere should contain
%
% Outputs: phantom_positions - Position of the scatterers in space
%          phantom_amplitudes - Reflectivity of the scatterers
%          phantom_bbox - Coordinates of a bounding box around
%                         the scatterers' region, so that imaging
%                         can be done on that volume (in meters)

function [phantom_positions, phantom_amplitudes, phantom_bbox] = SpherePhantom(center_x, center_y, center_z, inner_r, outer_r, amplitude, scatterers_per_volume)

    % Randomly (i.e. Gaussian distribution) generate positions and amplitudes
    % of the scatterers in a cubic volume that bounds the sphere
    x = (rand(scatterers_per_volume, 1) - 0.5) * 2 * outer_r + center_x;
    y = (rand(scatterers_per_volume, 1) - 0.5) * 2 * outer_r + center_y;
    z = (rand(scatterers_per_volume, 1) - 0.5) * 2 * outer_r + center_z;
    pos = [x y z];
    % The amplitude (i.e. reflectivity) of the scatterers that construct the phantom.
    amp = rand(scatterers_per_volume, 1) * amplitude;

    % Prune from the set of scatterers those that fall inside the inner
    % radius (cyst) or outside the outer radius (sphere)
    radii = ((x - center_x) .^ 2 + (y - center_y) .^ 2 + (z - center_z) .^ 2);
    outside_volume = ((inner_r ^ 2 > radii) | (radii > outer_r ^ 2));
    valid_scatterer_index = find(outside_volume ~= 1);
    phantom_positions = pos(valid_scatterer_index, :);
    phantom_amplitudes = amp(valid_scatterer_index, :);
    
    frame = 15 / 1000;   % How much "black space" to leave around the phantom in the image (in meters)
    phantom_bbox.min_x = center_x - outer_r - frame;
    phantom_bbox.max_x = center_x + outer_r + frame;
    phantom_bbox.min_y = center_y - outer_r - frame;
    phantom_bbox.max_y = center_y + outer_r + frame;
    phantom_bbox.min_z = max(0, center_z - outer_r - frame);
    phantom_bbox.max_z = center_z + outer_r + frame;
    
    warning('The phantom contains %d scatterers from a starting %d', size(phantom_amplitudes, 2), scatterers_per_volume);
    
end
