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
%% Compares a scan-converted image coming from the RTL simulation or an FPGA
%% run against a Matlab reference.
%
% Inputs: probe - Description of the probe
%         dest_dir - Folder in which to look for the FPGA data
%         target_phantom - Phantom name
%         cut_dir - 'azi-rad', 'ele-azi' or 'ele-rad'. If image is 2D,
%                   'azi-rad' is always used.
%         cut_val - The cross-section level at which to take the cut;
%                   ignored in 2D.
%         sc_width, sc_height - Width and height of the RTL SC image output. 
%         image - A structure with fields describing the desired output
%                 resolution
%         downsampling_factor - If downsampling is used, what the
%                               downsampling factor is (1 = no downsampling)
%         bf_im - Base frequency matrix containing the summed and delayed
%                 backscattered echoes (lines of sight along columns, time
%                 along rows) after demodulation. Note that in case of
%                 cropping of the upper slice of the image, bf_im is
%                 pre-cropped
% 
% Outputs: diff_metric - A quantitative measurement of the difference
%                        between the two images
%
% Note: this script uses the same conventions as the RTL SC, which is a
% deformed scan-conversion. For example, instead of a cut along an XZ plane
% at a given Y, it will render a cut along an azimuth-radius plane at a
% given elevation. Geometric distortions not accounted.
%
% Example usage:
% Run a TopLevel flow to the end.
% Assuming the image is 3D, choose a cut direction (e.g. 0) and a cut value (e.g. mid-elevation).
% diff_metric = CompareScanConversionResults(probe, dest_dir, ext_target_phantom, 'azi-rad', floor(size(bf_im, 3) / 2), 153, 128, image, downsampling_factor, bf_im);

function [diff_metric] = CompareScanConversionResults(probe, dest_dir, target_phantom, cut_dir, cut_val, sc_width, sc_height, image, downsampling_factor, bf_im)

filename = strcat(dest_dir, target_phantom, '_output.txt');
fID = fopen(filename, 'r');
image_slice = cell2mat(textscan(fID, '%f', -1, 'delimiter', ','));
fclose(fID);
image_slice = permute(reshape(image_slice, sc_width, sc_height), [2 1]);

% bf_im has size(rad, azi, ele)
% Leverages ScanConvert2DPhased even if the images are 3D, because of the
% above mentioned geometric assumptions, to be comparable to the RTL.
% Note that "probe" is out of sync, since it describes a probe for 3D (not
% 2D) imaging, but that's fine as ScanConvert2DPhased only uses probe.fs
% and probe.c.
% TODO pass down brightness/contrast settings for an even better comparison
% of the log compression.
if (image.elevation_lines > 1)
    if (strcmp(cut_dir, 'azi-rad'))
        matlab_slice = ScanConvert2DPhased(probe, squeeze(bf_im(:, :, cut_val)), downsampling_factor, 1, 0);
        direction_string = 'azimuth-radius';
    elseif (strcmp(cut_dir, 'ele-azi'))
        matlab_slice = ScanConvert2DPhased(probe, squeeze(bf_im(cut_val, :, :)), downsampling_factor, 1, 0);
        direction_string = 'elevation-azimuth';
    elseif (strcmp(cut_dir, 'ele-rad'))
        matlab_slice = ScanConvert2DPhased(probe, squeeze(bf_im(:, cut_val, :)), downsampling_factor, 1, 0);
        direction_string = 'elevation-radius';
    end
else
    matlab_slice = ScanConvert2DPhased(probe, bf_im, downsampling_factor, 1, 0);
    direction_string = 'azimuth-radius';
    cut_val = 0;
end

if (size(image_slice) == size(matlab_slice))
    diff_image = image_slice - matlab_slice;
    diff_metric = sqrt(sum(sum(diff_image .* diff_image)));
else
    disp('Warning: cannot produce a meaningful diff_metric because the image sizes are different.');
    diff_metric = 0;
end

figure('units', 'normalized', 'position', [0.1 0.2 0.8 0.6])
colormap gray(256);
subplot(1, 2, 1)
yax = gca;
imagesc(image_slice), title(['HDL image for cut ', num2str(cut_val), ' on plane ', direction_string]), caxis(yax, [1 256]), axis image, colorbar;
subplot(1, 2, 2);
yax = gca;
imagesc(matlab_slice), title(['Matlab image for cut ', num2str(cut_val), ' on plane ', direction_string]), caxis(yax, [1 256]), axis image, colorbar;

message = ['The nappe difference metric is ', num2str(diff_metric)];
disp(message);

end
