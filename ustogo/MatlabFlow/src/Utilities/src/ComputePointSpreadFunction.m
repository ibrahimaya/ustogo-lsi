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
%% Plots the PSF of the imager, and its azimuth projection.
%
% Inputs: probe - Description of the probe
%         image - A structure with fields describing the desired output
%                 output resolution
%         location_theta, location_phi, location_r - The expected location of the
%                                              point
%         ... - One or more beamformed images (2D or 3D) of the point
%
% Outputs: none

function [] = ComputePointSpreadFunction(probe, image, location_theta, location_phi, location_r, varargin)

var_args = length(varargin);
if (var_args == 0)
    error('At least one input image required.')
end
for k = 1 : var_args
    if (size(varargin{k}) ~= size(varargin{1}))
        error('All input images must have the same size.')
    end
end

[image_upper_limit_m, image_lower_limit_m, ~, ~, xz_sector, ~] = GetPhantomCoordinates(probe, image);

% TODO assumes that if the image is 3D, we always want a PSF projection at phi == 0
bf_im_slice = zeros(var_args, size(varargin{1}, 1), size(varargin{1}, 2));
logcomp_bf_im = zeros(var_args, size(varargin{1}, 1), size(varargin{1}, 2));
for k = 1 : var_args
    if (ndims(varargin{k}) == 3)
        bf_im_slice(k, :, :) = varargin{k}(:, :, round(size(varargin{k}, 3) / 2));
    else
        bf_im_slice(k, :, :) = varargin{k};
    end
    logcomp_bf_im(k, :, :) = 20 * log10(max(1e-12, squeeze(bf_im_slice(k, :, :)) / max(max(squeeze(bf_im_slice(k, :, :))))));
end

%% Contours of the PSF
contourlevels = [-5 -10 -20 -30 -40]; % in dB
theta = linspace(-xz_sector * 180 / pi / 2, xz_sector * 180 / pi / 2, size(varargin{1}, 2));
radius = linspace(image_upper_limit_m * 1000, image_lower_limit_m * 1000, size(varargin{1}, 1));

% TODO would be nice to have the vertical axis going the other way
figure
for k = 1 : var_args
    contour(theta, radius, squeeze(logcomp_bf_im(k, :, :)), contourlevels), hold on
end
plot(location_theta, location_r * 1000, '+k'),    % Plot the point phantom itself
xlabel('azimuth (degrees)'), ylabel('radius (mm)'), title(strcat('PSF contours for a scatterer at theta=', num2str(location_theta), ' deg, phi=', num2str(location_phi), ' deg, r=', num2str(location_r * 1000), ' mm'));

%% RMS Projection of the PSF
rms_exact = zeros(var_args, size(varargin{1}, 2));
rms_exact_log = zeros(var_args, size(varargin{1}, 2));
for k = 1 : var_args
    rms_exact(k, :) = rms(squeeze(bf_im_slice(k, :, :)));
    rms_exact_log(k, :) = 20 * log10(squeeze(rms_exact(k, :)) / max(squeeze(rms_exact(k, :))));
end

figure
for k = 1 : var_args
    plot(theta, squeeze(rms_exact_log(k, :))), hold on,
end
% TODO theta is actually plotted in lines, not degrees
xlabel('theta (degree)'), ylabel('amplitude (dB)'), title(strcat('RMS projection of a scatterer at theta=', num2str(location_theta), ' deg, phi=', num2str(location_phi), ' deg, r=', num2str(location_r * 1000), ' mm'));

end
