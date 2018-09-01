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
% Inputs: discarded_elements_percentage_map - a 3D table representing the
%                                             percentage of elements that
%                                             must be discarded, in addition
%                                             to the current apodization, in
%                                             the calculation of this point
%         threshold - Maximum acceptable % of elements that still need
%                     discarding.
%
% Outputs: r_index, theta_index, phi_index - Arrays of coordinates of the
%                                            locations that don't meet the
%                                            desired threshold.

function [r_index, theta_index, phi_index] = MapWorstPointsByThreshold(discarded_elements_percentage_map, threshold)
    worst_points = discarded_elements_percentage_map > threshold;
    [phi_index, theta_index, r_index] = ind2sub(size(worst_points), find(worst_points));
end
