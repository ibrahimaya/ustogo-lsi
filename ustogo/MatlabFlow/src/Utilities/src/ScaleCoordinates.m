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
%% Finds the worst locations in the volume terms of delay calculation
%% accuracy, based on a threshold of acceptable element discarding still
%% required.
%
% Inputs: probe - Description of the probe
%         image - A structure with fields describing the desired output
%                 output resolution
%         old_r_index, old_theta_index, old_phi_index - Arrays of coordinates of the
%                                                       locations expressed in the
%                                                       scaled resolution of the
%                                                       inaccuracy map.
%         phi_steps, theta_steps, r_steps - the focal point density in each
%                                           axis with which the inaccuracy
%                                           map had been calculated.
%
% Outputs: new_r_index, new_theta_index, new_phi_index - Arrays of coordinates of the
%                                                        locations expressed in global
%                                                        coordinates.

function [new_r_index, new_theta_index, new_phi_index] = ScaleCoordinates(probe, image, old_r_index, old_theta_index, old_phi_index, r_steps, theta_steps, phi_steps)

    [~, ~, r_min_N, r_max_N, xz_sector, yz_sector] = GetPhantomCoordinates(probe, image);
    r_step = (r_max_N - r_min_N) / r_steps;

    new_phi_index = round(old_phi_index * rad2deg(yz_sector) / phi_steps);
    new_theta_index = round(old_theta_index * rad2deg(xz_sector) / theta_steps);
    new_r_index = (round(old_r_index * r_step) + r_min_N - 1);
    
end
