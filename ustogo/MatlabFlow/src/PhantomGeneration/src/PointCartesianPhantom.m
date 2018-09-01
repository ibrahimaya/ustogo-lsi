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
%% Defines a phantom composed of a single point in space
%% (X: along the transducer surface, Y: across the transducer surface, Z: depth).
%
% Inputs: point_x, point_y, point_z - The location of the scatterer representing the point phantom (in meters)
%
% Outputs: phantom_positions - Position of the scatterer in space
%          phantom_amplitudes - Reflectivity of the scatterer
%          phantom_bbox - Coordinates of a bounding box around
%                         the scatterer' region, so that imaging
%                         can be done on that volume (in meters)

function [phantom_positions, phantom_amplitudes, phantom_bbox] = PointCartesianPhantom(point_x, point_y, point_z)
   
   phantom_positions = [point_x, point_y, point_z];
   phantom_amplitudes = 1;
   
   frame = 15 / 1000;   % How much "black space" to leave around the phantom in the image (in meters)
   phantom_bbox.min_x = point_x - frame;
   phantom_bbox.max_x = point_x + frame;
   phantom_bbox.min_y = point_y - frame;
   phantom_bbox.max_y = point_y + frame;
   phantom_bbox.min_z = max(0, point_z - frame);
   phantom_bbox.max_z = point_z + frame;
   
end