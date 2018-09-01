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
%% Calculates the volume to be beamformed based on phantom size.
%
% Inputs: probe - Description of the probe and phantom
%         image - A structure with fields describing the desired output
%                 resolution
%
% Outputs: image_upper_limit_m, image_lower_limit_m - Phantom bounds along
%                                                     the axial direction
%          image_upper_limit_N, image_lower_limit_N - Phantom bounds,
%                                                     expressed in index units
%          xz_sector, yz_sector - Circular sector containing the phantom on
%                                 the XZ, YZ plane (with some margin)

function [image_upper_limit_m, image_lower_limit_m, image_upper_limit_N, image_lower_limit_N, xz_sector, yz_sector] = ...
    GetPhantomCoordinates(probe, image)

    % How much wider to make the circular sector, to leave some margin
    % around the phantom's edges.
    sector_margin = 1.4;

    % Define the image portion (depth-wise) to be displayed on screen (crop)
    if (image.target_shallow_bound == -1)
        image_upper_limit_m = probe.phantom_bbox.min_z; % The depth corresponding to the upper edge of the image in [m]
    else
        image_upper_limit_m = image.target_shallow_bound;
    end
    if (image.target_depth == -1)
        image_lower_limit_m = probe.phantom_bbox.max_z; % The depth corresponding to the lower edge of the image in [m]
    else
        image_lower_limit_m = image.target_depth;
    end
    % Same as above, in index units. Assumes a finest grain on the radial axis of 
    % probe.c / (2 * probe.fs), where the 2 accounts for two-way propagation
    image_upper_limit_N = max(1, ceil((2 * image_upper_limit_m / probe.c) * probe.fs));
    image_lower_limit_N = floor((2 * image_lower_limit_m / probe.c) * probe.fs);
    
    if (image.target_azimuth == -1)
        xz_sector = 2 * atan(max(abs(probe.phantom_bbox.min_x), abs(probe.phantom_bbox.max_x)) * sector_margin / probe.phantom_bbox.max_z);
    else
        xz_sector = deg2rad(image.target_azimuth);
    end
    if (image.elevation_lines == 1)
        yz_sector = 0;
    else
        if (image.target_elevation == -1)
            yz_sector = 2 * atan(max(abs(probe.phantom_bbox.min_y), abs(probe.phantom_bbox.max_y)) * sector_margin / probe.phantom_bbox.max_z);
            %TODO this line of code is actually wrong, should be the Z at which the max X occurs
        else
            yz_sector = deg2rad(image.target_elevation);
        end
    end
end
