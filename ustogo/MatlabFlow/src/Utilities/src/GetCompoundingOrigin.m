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
%% Calculates the n-th location of the virtual source for image compounding.
%
% Inputs: probe - Description of the probe
%         image - A structure with fields describing the desired output
%                 output resolution
%         insonification_index - Which insonification is happening now
%
% Outputs: virtual_source_radius - The distance of the virtual source from
%                                  [0, 0, 0] [m]
%          xO, yO, zO - The coordinates of the virtual source [m]
%          delta, gamma - The insonification azimuth/elevation angles [rad]

function [virtual_source_radius, xO, yO, zO, delta, gamma] = GetCompoundingOrigin(probe, image, insonification_index)
    % Angles from which the insonification will be done
    % (azimuth/elevation). If no compounding: single insonification
    % from (0, 0), i.e. straight down the Z axis. E.g. if compounding of
    % five images: five insonifications from (0, 0) to (+-20, 0).
    % Also supported are 9-, 13- and 17- compounding, for 3D imaging.
    % Other numbers of frames are acceptable but asymmetrical.
    angles = [0 0; ...
              -10 0; 10 0; ...
              -20 0; 20 0; ...
              0 -10; 0 10; 0 -20; 0 20; ...
              -10 10; 10 -10; -10 -10; 10 10; ...
              -20 20; 20 -20; -20 -20; 20 20; ...
             ];
    % Maximum insonification angle (either negative or positive)
    max_angle = max(max(max(angles)), abs(min(min(angles))));
    
    [~, ~, ~, ~, sector_xz, ~] = GetPhantomCoordinates(probe, image);
    
    % TODO what is this calculation??
    a1 = (pi - sector_xz) / 2;
    a2 = pi - a1 - (pi / 2 - max_angle);
    virtual_source_radius = sin(a1) / sin(a2) * (probe.transducer_width / 2);
    
    delta = degtorad(angles(insonification_index, 1));
    gamma = degtorad(angles(insonification_index, 2));
    xO = - virtual_source_radius * sin(delta);
    yO = - virtual_source_radius * sin(gamma) * cos(delta);
    zO = - virtual_source_radius * cos(gamma) * cos(delta);
end
