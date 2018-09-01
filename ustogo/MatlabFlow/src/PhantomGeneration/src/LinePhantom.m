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
%% Defines a phantom composed of a line in space
%% (X: along the transducer surface, Y: across the transducer surface, Z: depth).
%
% Inputs: begin_x, begin_y, begin_z, end_x, end_y, end_z - Coordinates of the line endpoints (in meters)
%         scatterer_count - How many scatterers to distribute along the line
%         amplitude - Parameter to scale the maximum reflectivity of the
%                     scatterers. Supposed to be in the interval ]0, 1.0].
%
% Outputs: phantom_positions - Position of the scatterers in space
%          phantom_amplitudes - Reflectivity of the scatterers
%          phantom_bbox - Coordinates of a bounding box around
%                         the scatterers' region, so that imaging
%                         can be done on that volume (in meters)

function [phantom_positions, phantom_amplitudes, phantom_bbox] = LinePhantom(begin_x, begin_y, begin_z, end_x, end_y, end_z, scatterer_count, amplitude)

    [X, Z] = deal(linspace(begin_x, end_x, scatterer_count), linspace(begin_z, end_z, scatterer_count));
    Y = zeros(size(X));
   
    % figure, plot3 (X, Y, Z), xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis'), title('The "Line" phantom');
   
    phantom_positions = [X', Y', Z'];
    phantom_amplitudes = (rand(1, scatterer_count) * amplitude)';   % The amplitude (i.e. reflectivity) of the scatterers that construct the phantom.
    
    frame = 5 / 1000;   % How much "black space" to leave around the phantom in the image (in meters)
    phantom_bbox.min_x = min(begin_x, end_x) - frame;
    phantom_bbox.max_x = max(begin_x, end_x) + frame;
    phantom_bbox.min_y = max(begin_y, end_y) - frame;
    phantom_bbox.max_y = max(begin_y, end_y) + frame;
    phantom_bbox.min_z = max(0, min(begin_z, end_z) - frame);
    phantom_bbox.max_z = max(begin_z, end_z) + frame;

    warning('The phantom contains %d scatterers', scatterer_count);

end
