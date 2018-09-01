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
%         show_image - 1: actually display the 3D images and save them to disk,
%                      0: just return the processed volume
%
% Outputs: im_log_rescaled - Scan-converted volume

function [im_log_rescaled] = ScanConvert3DPhased(probe, image, bf_im, downsampling_factor, enable_log_compression, show_image)
    GSmax = 255;                         % Max greyscale value
    LC = 45;                             % Dynamic range to be visualized [dB]
    gain = 0;                            % Brightness gain [dB]
    % Whether we want to apply auto-gain (the image brightness is scaled so that
    % its highest intensity is pure white, with optionally "gain" on top)
    % or a fixed gain value (useful to compare images)
    use_automatic_gain = 1;
    fixed_gain_factor = 5e-22;
    
    [image_upper_limit_m, image_lower_limit_m, image_upper_limit_N, image_lower_limit_N, xz_sector, yz_sector] = GetPhantomCoordinates(probe, image);
    
    % Create an output image that is "image_depth" pixels deep. In
    % principle, this should be the same depth of the beamformed image; can
    % scale down to reduce runtime; can scale up to magnify
    image_depth = size(bf_im, 1); % Z axis
    % We need the width and height to be an odd number, to be symmetric
    % around the central line of sight.
    half_image_width = ceil(image_depth * sin(xz_sector / 2));
    image_width = 2 * half_image_width + 1; % X axis
    half_image_height = ceil(image_depth * sin(yz_sector / 2));
    image_height = 2 * half_image_height + 1; % Y axis
    
    % Since the image's axial resolution may not be based on the full
    % available axial information, scale appropriately
    samples_per_depth = (image_lower_limit_N - image_upper_limit_N) / size(bf_im, 1);
    image_upper_limit_N = round(image_upper_limit_N / samples_per_depth) + 1;
    image_lower_limit_N = round(image_lower_limit_N / samples_per_depth);

    % If cropping is requested on the shallow side, we miss some data that will
    % need to be accessed below. Just add a black strip
    [bf_im_depth_samples, bf_im_width_pixels, bf_im_slices] = size(bf_im);
    if (image_upper_limit_N ~= 1)
        for i = 1 : bf_im_slices
            bf_im_padded(:, :, i) = [zeros(image_upper_limit_N, bf_im_width_pixels); bf_im(:, :, i)];
        end
        bf_im = bf_im_padded;
    end
    
    %% Adjust image brightness
    if (enable_log_compression == 1)
        im_max = max(max(max(bf_im)));                   % Max image amplitude for auto-gain
        if (use_automatic_gain == 1)
            im_adj = im_max * 10 ^ (- gain / 20);
        else
            im_adj = fixed_gain_factor * 10 ^ (- gain / 20);
        end
        for i = 1 : bf_im_slices
            im_log(:, :, i) = LogComp(bf_im(:, :, i), im_adj, GSmax, LC); % log compress the demodulated image with top value at im_adj
        end
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
    
    %% Scan conversion
    im_log_rescaled = zeros(image_width, image_height, image_depth);

    tic
    % Derive the matrices X, Y and Z that define how to warp into a quasi-pyramidal shape
    
    % In order to save memory (large 3D volumes become hard to
    % process), do the scan conversion in depth-wise slices.
    slice_thickness = 20; % 1 to image_depth
    
    for depth_index = 1 : slice_thickness : image_depth
        message = ['Scan converting at depth ', num2str(depth_index), ' of ', num2str(image_depth)];
        disp(message);
        
        % At the last slice, we may overstep the image bounds.
        if (depth_index + slice_thickness - 1 > image_depth)
            slice_thickness = image_depth - depth_index + 1;
            % These initializations must be done here or we might have
            % matrices too large for the last slice.
            % Samples the radius in the old coordinate space
            X = zeros(image_width, image_height, slice_thickness);
            % Samples the azimuth in the old coordinate space
            Y = zeros(image_width, image_height, slice_thickness);
            % Samples the elevation in the old coordinate space
            Z = zeros(image_width, image_height, slice_thickness);
        end
        
        % X in the new coordinate space
        for new_x = -half_image_width : half_image_width
            x_index = half_image_width + 1 + new_x;
            % Y in the new coordinate space
            for new_y = -half_image_height : half_image_height
                y_index = half_image_height + 1 + new_y;
                % Z in the new coordinate space (depth)
                for new_z = depth_index : min(depth_index + slice_thickness - 1, image_depth)
                    z_index = new_z - depth_index + 1;
                    % Ensure that the X, Y, Z matrices are indexed at a positive
                    % index; the matrices are "shifted up" and their virtual center
                    % is at (half_image_width + 1, half_image_height + 1, image_depth / 2 + 0.5).
                    X(x_index, y_index, z_index) = sqrt(new_x * new_x + new_y * new_y + new_z * new_z);
                    Y(x_index, y_index, z_index) = (xz_sector / 2) + atan(new_x / sqrt(new_y * new_y + new_z * new_z));
                    Z(x_index, y_index, z_index) = (yz_sector / 2) + atan(new_y / new_z);
                end
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
        Z = Z * ((bf_im_slices + 1) / yz_sector);
        
        % Actually warp the image. Use an interpolation function to map the original image,
        % sampled at a default orthogonal mesh, onto the new grid, with interpolation
        im_log_rescaled(:, :, depth_index : depth_index + slice_thickness - 1) = Interp3D(im_log, X, Y, Z, background_level);
        % This function is equivalent to launching:
        % im_log_rescaled = interp3(permute(im_log, [2, 1, 3]), X, Y, Z, 'linear', background_level);
        % if "slice_thickness" as defined above is the whole "image_depth".
        % The latter call is faster, but uses too much memory for high-resolution volumes.
    end
    
    % Apply cropping on the shallow side
    %TODO unsupported ATM
    %im_log_rescaled = im_log_rescaled(floor((image_upper_limit_N / radius_normalization) * cos(xz_sector / 2)) + 1 : conic_image_size, :, :);
    
    toc
    
    cd(fileparts(mfilename('fullpath')));
    % The '-v7.3' setting works around a possible Matlab bug when saving
    % large data matrices.
    save('../data/sc_im_phased.mat', 'im_log_rescaled', '-v7.3');
    
    %% Final image display
    if (show_image == 1)
        % Display the image on a grey scale going from 0 to 255
        color_map = gray(256); % TODO not sure if [0 160] improves legibility
        [M, N, O] = size(im_log_rescaled);
        % Removes a strange warning with imshow3D
        set(0, 'defaultfigurepaperpositionmode', 'auto');
        
        fig1 = figure;
        imshow3D(im_log_rescaled);
        str = sprintf('YX plane - Gain=%0.0f dB, immax=%0.3g, LC=%0.0f dB', gain, im_max, LC);
        title(str);
        
        fig2 = figure;
        imshow3D(permute(im_log_rescaled, [3, 2, 1]));
        str = sprintf('YZ plane - Gain=%0.0f dB, immax=%0.3g, LC=%0.0f dB', gain, im_max, LC);
        title(str);
        
        fig3 = figure;
        imshow3D(permute(im_log_rescaled, [3, 1, 2]));
        str = sprintf('XZ plane - Gain=%0.0f dB, immax=%0.3g, LC=%0.0f dB', gain, im_max, LC);
        title(str);
        
        % TODO 3D axis labels
        
        cd(fileparts(mfilename('fullpath')));
        saveas(fig1, '../data/image_yx.jpg', 'jpg');
        saveas(fig2, '../data/image_yz.jpg', 'jpg');
        saveas(fig3, '../data/image_xz.jpg', 'jpg');
    end
end

