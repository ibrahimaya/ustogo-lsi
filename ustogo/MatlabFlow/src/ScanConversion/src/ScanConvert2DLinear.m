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
%% B-mode ultrasound image beamforming based on RF data matrix
%
% Inputs: probe - Description of the probe
%         image - A structure with fields describing the desired output
%                 resolution
%         bf_im - Base frequency matrix containing the summed and delayed
%                 backscattered echoes (lines of sight along columns, time
%                 along rows) after demodulation. Note that in case of
%                 cropping of the upper slice of the image, bf_im is
%                 pre-cropped
%         downsampling_factor - If downsampling is used, what the
%                               downsampling factor is (1 = no downsampling)
%         enable_log_compression - 1: perform log compression
%                                  0: do not perform log compression
%         show_image - 1: actually display the 2D images and save them to disk,
%                      0: just return the processed image
%
% Outputs: im_log_rescaled - Scan-converted volume

function [im_log_rescaled] = ScanConvert2DLinear(probe, image, bf_im, downsampling_factor, enable_log_compression, show_image)
    % Imaging constants
    GSmax = 255;                         % Max greyscale value
    LC = 45;                             % Dynamic range to be visualized [dB]
    gain = 0;                            % Brightness gain [dB]
    % Whether we want to apply auto-gain (the image brightness is scaled so that
    % its highest intensity is pure white, with optionally "gain" on top)
    % or a fixed gain value (useful to compare images)
    use_automatic_gain = 1;
    fixed_gain_factor = 5e-22;
    
    fs = probe.fs / downsampling_factor;

    [image_upper_limit_m, ~, image_upper_limit_N, image_lower_limit_N, ~, ~] = GetPhantomCoordinates(probe, image);
    
    % Since the image's axial resolution may not be based on the full
    % available axial information, scale appropriately
    samples_per_row = (image_lower_limit_N - image_upper_limit_N) / size(bf_im, 1);
    image_upper_limit_N = round(image_upper_limit_N / samples_per_row) + 1;
    image_lower_limit_N = round(image_lower_limit_N / samples_per_row);
    
    % The number of actually displayed pixels is multiplied by an "im_factor"
    im_factor = 5;                       % Visualization scale factor (zoom)
    
    % Redefine the image height in [m] and pixels
    [bf_im_height_samples, bf_im_width_pixels] = size(bf_im);
    bf_im_width_m = probe.transducer_width;
    % Image geometry: define pixels as square.
    pixel_width = bf_im_width_m / bf_im_width_pixels; % Pixel width [m]
    pixel_height = pixel_width;                       % Pixel height [m]
    bf_im_height_m = bf_im_height_samples * samples_per_row * probe.c / (2 * probe.fs);
    bf_im_height_pixels = floor(bf_im_height_m / pixel_height);
    
    %% Adjust image brightness
    if (enable_log_compression == 1)
        im_max = max(max(bf_im));                   % Max image amplitude for auto-gain
        if (use_automatic_gain == 1)
            im_adj = im_max * 10 ^ (- gain / 20);
        else
            im_adj = fixed_gain_factor * 10 ^ (- gain / 20);
        end
        im_log = LogComp(bf_im, im_adj, GSmax, LC); % log compress the demodulated image with top value at im_adj
    else
        im_log = bf_im;
    end
    clear bf_im;
    
    %% Debug features
    if (0)
        color_map = gray(256);
        figure; imshow(im_log, color_map);
    end
    
    %% Scan conversion (image rescaling)
    im_log_rescaled = interp2(im_log, linspace(1, bf_im_width_pixels, im_factor * bf_im_width_pixels), linspace(1, bf_im_height_samples, im_factor * bf_im_height_pixels)');

    %% Final image display
    if (show_image == 1)
        % Display the image on a grey scale going from 0 to 255
        color_map = gray(256);
        [M, N] = size(im_log_rescaled);
        
        fig = figure;
        imshow(im_log_rescaled, color_map);
        colorbar('YTickLabel', '');
        axis on;
        set(gca, 'XTick', [1 (N / 2) N]);                                                                       % Location of X ticks
        set(gca, 'XTickLabel', [(- bf_im_width_m * 100 / 2) 0 (bf_im_width_m * 100 / 2)]);                      % Labels of X ticks
        if (bf_im_height_m < 30 / 1000)                                                                         % Location and labels of Y ticks
            set(gca, 'YTick', 1 : M / (bf_im_height_m * 1000) : M);      % every 1 mm
            set(gca, 'YTickLabel', (image_upper_limit_m * 100 : 0.1 : (bf_im_height_m + image_upper_limit_m) * 100));
        elseif (bf_im_height_m < 100 / 1000)
            set(gca, 'YTick', 1 : 5 * M / (bf_im_height_m * 1000) : M);  % every 5 mm
            set(gca, 'YTickLabel', (image_upper_limit_m * 100 : 0.5 : (bf_im_height_m + image_upper_limit_m) * 100)); % Labels of Y ticks
        else
            set(gca, 'YTick', 1 : 10 * M / (bf_im_height_m * 1000) : M); % every 10 mm
            set(gca, 'YTickLabel', (image_upper_limit_m * 100 : 1 : (bf_im_height_m + image_upper_limit_m) * 100)); % Labels of Y ticks
        end
        xlabel('x [cm]');
        ylabel('Depth [cm]');
        str = sprintf('Gain=%0.0f dB, immax=%0.3g, LC=%0.0f dB', gain, im_max, LC);
        title(str);
        
        cd(fileparts(mfilename('fullpath')));
        saveas(fig, '../data/image.jpg', 'jpg');
        saveas(fig, '../data/image.fig', 'fig');
    end
end
