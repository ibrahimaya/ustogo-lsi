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
% Inputs: ref_image - Reference image (greyscale after SC/LC)
%         test_image - Processed/noisy image (greyscale after SC/LC)
%
% Outputs: PSNR - Peak Signal-to-Noise Ratio (dB)

function [PSNR] = PSNRMetric(ref_image, test_image)
    
    if (size(ref_image) ~= size(test_image))
        error('The images need to have the same size');
    end
    
    % Maximum brightness of an image pixel
    MAX = 255;
    
    sqrt_error = (ref_image - test_image) .^ 2;
    MSE = mean(sqrt_error(:)); % Mean Square Error
    PSNR = 20 * log10(MAX) - 10 * log10(MSE);

end