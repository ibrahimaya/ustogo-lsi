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
%% Returns the Peak Signal-to-Noise Ratio (PSNR) of an image compared to a reference.
%
% Inputs: ref_image - Reference image (linear-scale after SC)
%         test_image - Processed/noisy image (linear-scale after SC)
%
% Outputs: PSNR - Peak Signal-to-Noise Ratio (dB)

function [PSNR] = PSNRMetricLinear(ref_image, test_image)
    
    if (size(ref_image) ~= size(test_image))
        error('The images need to have the same size');
    end
    
    sc_background_pixel_brightness = 128;
    
    % Maximum brightness of an image pixel
    % In linear scale, there is no obvious "maximum" brightness level.
    % Get it to 1 by normalizing the images to the brightest overall pixel.
    % TODO: assumption here that the two images have very similar
    % brightness. If not, there is some "cheating" involved in the
    % measurement, up or down.
    MAX = 1;
    
    % Special case: since these are the images after SC, the brightest
    % pixel could be in the area outside the image cone! (Note that those
    % pixels are OK in that they will contribute no noise, but they must
    % not be used as the brightest voxel value). If that is the case, take
    % the second-brightest pixel.
    if ((max(ref_image(:)) == sc_background_pixel_brightness) || (max(test_image(:)) == sc_background_pixel_brightness))
        ref_image_tmp = unique(ref_image);
        ref_image_max = ref_image_tmp(end - 1);
        test_image_tmp = unique(test_image);
        test_image_max = test_image_tmp(end - 1);
    else
        ref_image_max = max(ref_image(:));
        test_image_max = max(test_image(:));
    end        
    norm_factor = max(ref_image_max, test_image_max);
    ref_image = ref_image / norm_factor;
    test_image = test_image / norm_factor;
    
    sqrt_error = (ref_image - test_image) .^ 2;
    MSE = mean(sqrt_error(:)); % Mean Square Error
    PSNR = 20 * log10(MAX) - 10 * log10(MSE);

end