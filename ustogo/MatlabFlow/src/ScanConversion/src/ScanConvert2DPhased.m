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

function [im_log_rescaled] = ScanConvert2DPhased(probe, image, bf_im, downsampling_factor, enable_log_compression, show_image)
    GSmax = 255;                         % Max greyscale value
    LC = 45;                             % Dynamic range to be visualized [dB]
    gain = 0;                            % Brightness gain [dB]
    % Whether we want to apply auto-gain (the image brightness is scaled so that
    % its highest intensity is pure white, with optionally "gain" on top)
    % or a fixed gain value (useful to compare images)
    use_automatic_gain = 1;
    fixed_gain_factor = 5e-22;
    
    % Which version of the scan conversion algorithm to use:
    % - if 1: interp2-based
    % - if 0: scatteredInterpolant-based
    % The two are functionally equivalent. Performance seems similar too.
    % Hardware-friendliness is being assessed.
    use_interp2_algorithm = 1;

    [image_upper_limit_m, image_lower_limit_m, image_upper_limit_N, image_lower_limit_N, xz_sector, ~] = GetPhantomCoordinates(probe, image);
    
    % Create an output image that is "image_depth" pixels deep. In
    % principle, this should be the same depth of the beamformed image; can
    % scale down to reduce runtime; can scale up to magnify
    image_depth = size(bf_im, 1); % Z axis
    % We need the width and height to be an odd number, to be symmetric
    % around the central line of sight.
    half_image_width = ceil(image_depth * sin(xz_sector / 2));
    image_width = 2 * half_image_width + 1; % X axis
    half_image_height = 0;
    image_height = 2 * half_image_height + 1; % Y axis
    
    % Since the image's axial resolution may not be based on the full
    % available axial information, scale appropriately
    samples_per_depth = (image_lower_limit_N - image_upper_limit_N) / size(bf_im, 1);
    image_upper_limit_N = round(image_upper_limit_N / samples_per_depth) + 1;
    image_lower_limit_N = round(image_lower_limit_N / samples_per_depth);

    % If cropping is requested on the shallow side, we miss some data that will
    % need to be accessed below. Just add a black strip
    if (image_upper_limit_N ~= 1)
        bf_im = [zeros(image_upper_limit_N, size(bf_im, 2)); bf_im];
    end
    
    % Redefine the image height in [m] and pixels
    [bf_im_depth_samples, bf_im_width_pixels] = size(bf_im);
    % Image geometry: define pixels as square.
    bf_im_height_m = bf_im_depth_samples * samples_per_depth * probe.c / (2 * probe.fs);
    
    %% Adjust image brightness
    if (enable_log_compression == 1)
        im_max = max(max(bf_im));                   % Max image amplitude for auto-gain
        if (use_automatic_gain == 1)
            im_adj = im_max * 10 ^ (- gain / 20);
        else
            im_adj = fixed_gain_factor * 10 ^ (- gain / 20);
        end
        im_log = LogComp(bf_im, im_adj, GSmax, LC); % log compress the demodulated image with top value at im_adj

        % Color of the region outside the imaging cone. 128 (middle gray) is
        % a good color as the image will be ranging from black to white.
        background_level = 128;
    else
        im_log = bf_im;
        % Color of the region outside the imaging cone. As we are not going
        % to use log compression, choose a color that hopefully won't dwarf
        % the data if it has very small values (but still don't use black).
        % This parameter may need changing depending on images.
        background_level = 1e-12;
    end
    clear bf_im;
    
    %% Debug features
    if (0)
        color_map = gray(256);
        figure; imshow(im_log, color_map);
    end
    
    %% Scan conversion
    if (use_interp2_algorithm == 1)
        % Derive the matrices X and Y that define how to warp into a conical shape
        
        % Samples the radius in the old coordinate space
        X = zeros(image_width, image_depth);
        % Samples the azimuth in the old coordinate space
        Y = zeros(image_width, image_depth);
        
        % X in the new coordinate space
        for new_x = -half_image_width : half_image_width
            x_index = half_image_width + 1 + new_x;
            % Z in the new coordinate space (depth)
            for new_z = 1 : image_depth
                z_index = new_z;
                % Ensure that the X, Y matrices are indexed at a positive
                % index; the matrices are "shifted up" and their virtual center
                % is at (half_image_width + 1, image_depth / 2 + 0.5)
                X(x_index, z_index) = sqrt(new_x * new_x + new_z * new_z);
                Y(x_index, z_index) = (xz_sector / 2) + atan(new_x / new_z);
            end
        end
        
        % Scale the geometry to match the bounds of the input image
        X = X * ((bf_im_depth_samples + image_upper_limit_N) / image_depth);
        % The added "+ 1" is to center the matrix, which would be
        % otherwise "tilted". For example:
        % size(bf_im, 2) = bf_im_width_pixels = 73 (bf_im sweeps from 1 to 73 azimuth angles)
        % then the center line of bf_im is at azimuth 37.
        % At the center of Y, when new_x = 0:
        % Y = (xz_sector / 2) * bf_im_width_pixels / xz_sector = 36.5
        Y = Y * ((bf_im_width_pixels + 1) / xz_sector);
        
        % Actually warp the image. Use interp2 to map the original image,
        % sampled at a default orthogonal mesh, onto the new grid, with interpolation
        im_log_rescaled = interp2(im_log, Y', X', 'linear', background_level);
        
        % Apply cropping on the shallow side
        im_log_rescaled = im_log_rescaled(floor((image_upper_limit_N / (bf_im_depth_samples / image_depth)) * cos(xz_sector / 2)) + 1 : image_depth, :);
    else
	    % TODO probably non-operational now.
        [im_log_rescaled] = Scan_converter_ma2D(conic_image_size, im_log, image_lower_limit_m - image_upper_limit_m, image_upper_limit_m, 0, sector * 180 / pi, probe.fs, probe.c);
    end
    
    cd(fileparts(mfilename('fullpath')));
    % The '-v7.3' setting works around a possible Matlab bug when saving
    % large data matrices.
    save('../data/sc_im_phased.mat', 'im_log_rescaled', '-v7.3');
    
    %% Final image display
    if (show_image == 1)
        % Display the image on a grey scale going from 0 to 255
        color_map = gray(256); % TODO not sure if [0 160] improves legibility
        [M, N] = size(im_log_rescaled);
        
        fig = figure;
        imshow(im_log_rescaled, color_map);
        colorbar('YTickLabel', '');
        axis on;
        set(gca, 'XTick', (1 : (N / (2 * image_lower_limit_m * 100)) : N - 2));                % Location of X ticks
        set(gca, 'XTickLabel', (- image_lower_limit_m * 100 : 1 : image_lower_limit_m * 100)); % Labels of X ticks
        % The location of the Y ticks is tricky, because the image curls up
        % above image_upper_limit_m if the latter is non-zero. Compensate for
        % this.
        set(gca, 'YTick', round(image_upper_limit_m * (1 - cos(xz_sector / 2)) * M / (bf_im_height_m - image_upper_limit_m * cos(xz_sector / 2))) : ...
                          round(M / ((bf_im_height_m - image_upper_limit_m * cos(xz_sector / 2)) * 100)) : ...
                          M);                                                                % Location of Y ticks
        set(gca, 'YTickLabel', (image_upper_limit_m * 100 : 1 : image_lower_limit_m * 100)); % Labels of Y ticks
        xlabel('x [cm]');
        ylabel('Depth [cm]');
        str = sprintf('Gain=%0.0f dB, immax=%0.3g, LC=%0.0f dB', gain, im_max, LC);
        title(str);
        
        cd(fileparts(mfilename('fullpath')));
        saveas(fig, '../data/image.jpg', 'jpg');
        saveas(fig, '../data/image.fig', 'fig');
    end
end
