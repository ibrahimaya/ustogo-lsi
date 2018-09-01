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
%% Defines a phantom composed of a circle lying on a horizontal XZ plane
%% (X: along the transducer surface, Z: depth).
%
% Inputs: center_x, center_z - Coordinates of the center of the circle (in meters)
%         r - Radius of the circle
%         scatterer_count - How many scatterers to distribute along the circle
%         amplitude - Parameter to scale the maximum reflectivity of the
%                     scatterers. Supposed to be in the interval ]0, 1.0].
%
% Outputs: phantom_positions - Position of the scatterers in space
%          phantom_amplitudes - Reflectivity of the scatterers
%          phantom_bbox - Coordinates of a bounding box around
%                         the scatterers' region, so that imaging
%                         can be done on that volume (in meters)

function [phantom_positions, phantom_amplitudes, phantom_bbox] = CirclePhantom(center_x, center_z, r, scatterer_count, amplitude)
     
    th = 0 : 2 * pi / scatterer_count : 2 * pi;               % Uniformly spread along the circle
    X = r * cos(th) + center_x;
    Y = zeros(size(X));
    Z = r * sin(th) + center_z;
    [N M] = size(X);
    
    phantom_positions = [X', Y', Z'];
    phantom_amplitudes = (rand(N, M) * amplitude)';  % The amplitude (i.e. reflectivity) of the scatterers that construct the phantom.

    frame = 15 / 1000;   % How much "black space" to leave around the phantom in the image (in meters)
    phantom_bbox.min_x = center_x - r - frame;
    phantom_bbox.max_x = center_x + r + frame; 
    phantom_bbox.min_y = - frame;
    phantom_bbox.max_y = frame;
    phantom_bbox.min_z = max(0, center_z - r - frame);
    phantom_bbox.max_z = center_z + r + frame;
    
    warning('The phantom contains %d scatterers', scatterer_count);

end
