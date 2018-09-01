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
%% Compares a beamformed image coming from the RTL simulation or an FPGA
%% run against a Matlab reference.
%
% Inputs: target_phantom - Phantom name
%         nappe_index - The nappe to compare
%         image - A structure with fields describing the desired output
%                 resolution
%         bf_im - Beamformed image
%         (optional) zone_index - Which image zone to compare (if available
%                                 on disk, which is the case for RTL simulation
%                                 but not for FPGA runs).
% 
% Outputs: diff_metric - A quantitative measurement of the difference
%                        between the two images
%
% Example usage:
% Run a TopLevel flow to the end.
% Having chosen a nappe to inspect (e.g. 1),
% diff_metric = CompareBeamformingResults(ext_target_phantom, 1, image, bf_im);
% If trying to compare the output of a single zone,
% diff_metric = CompareBeamformingResults(ext_target_phantom, 1, image, bf_im, 1);
% Note that this latter syntax is also useful when running long 3D
% simulations, for which the nappe_*_zone_1.txt files will be dumped on disk
% little by little but the nappe_*.txt files are only collected at the end
% of the simulation much, much later.

function [diff_metric] = CompareBeamformingResults(target_phantom, nappe_index, image, bf_im, varargin)

% TODO could add a feature to compare the full Matlab image vs. a
% single-zone BF image for speed of debugging in multizone setups.

var_args = length(varargin);
if (var_args == 0)
    filename = strcat(target_phantom, '_nappe_', num2str(nappe_index), '.txt');
elseif (var_args == 1)
    filename = strcat(target_phantom, '_nappe_', num2str(nappe_index), '_zone_', num2str(varargin{1}), '.txt');
elseif (var_args > 1)
    error('Too many arguments.')
end

fID = fopen(filename, 'r');
hdl_nappe_array = cell2mat(textscan(fID, '%f', -1));
fclose(fID);
% Along the columns: constant phi
% Along the rows: constant theta
if (image.elevation_lines == 1) % To see if this is 2D or 3D imaging
    hdl_nappe = hdl_nappe_array';
    matlab_nappe = squeeze(bf_im(nappe_index, :));
else
    hdl_nappe = reshape(hdl_nappe_array, image.elevation_lines, image.azimuth_lines);
    matlab_nappe = squeeze(bf_im(nappe_index, :, :));
end
if (size(hdl_nappe) == size(matlab_nappe))
    diff_nappe = hdl_nappe - matlab_nappe;
    diff_metric = sqrt(sum(sum(diff_nappe .* diff_nappe)));
else
    disp('Warning: cannot produce a meaningful diff_metric because the image sizes are different.');
    diff_metric = 0;
end

figure('units', 'normalized', 'position', [0.1 0.2 0.8 0.6])
% TODO harmonize colorbar
% TODO assumes nappes are square
min_limit = min(min(min(hdl_nappe)), min(min(matlab_nappe)));
max_limit = max(max(max(hdl_nappe)), max(max(matlab_nappe)));
if (max_limit == min_limit) % Typically, when the images are all 0s
    min_limit = min_limit - 0.5;
    max_limit = max_limit + 0.5;
end
subplot(1, 2, 1);
yax = gca;
imagesc(hdl_nappe), title(strcat('HDL nappe #', num2str(nappe_index))), caxis(yax, [min_limit max_limit]), colorbar, axis square;
subplot(1, 2, 2);
yax = gca;
imagesc(matlab_nappe), title(strcat('Matlab nappe #', num2str(nappe_index))), caxis(yax, [min_limit max_limit]), colorbar, axis square;
%figure, imagesc(diff_nappe), title(strcat('Difference for nappe #', num2str(nappe_index))), colorbar;

message = ['The nappe difference metric is ', num2str(diff_metric)];
disp(message);

end
