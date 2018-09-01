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
%% Beamformed image compounding according to one of several mathematical
%% techniques.
%
% Inputs: bf_im - Base frequency matrix containing the summed and delayed
%                 backscattered echoes after demodulation.
%         compounding_operator - 0: Averaging
%                                1: Averaging without the maximum brightness voxel
%                                2: Maximum brightness voxel selected
%                                3: Minimum brightness voxel selected
%                                4: MSD compounding
%                                5: ZREV compounding
%                                See the paper "FREQUENCY AND SPATIAL
%                                COMPOUNDING TECHNIQUES FOR IMPROVED
%                                ULTRASONIC IMAGING",
%                                by Bencharit, Kaufman, Bilgutay and Saniie
%
% Outputs: avg_im - Compounded volume

function [avg_im] = Compounding3D(bf_im, compounding_operator)
    % Output image
    avg_im = zeros(size(bf_im, 1), size(bf_im, 2), size(bf_im, 3));
    switch (compounding_operator)
        % Averaging
        case 0
            % Just do the mean of all frames
            avg_im = mean(bf_im, 4);
        % Averaging without the maximum brightness voxel
        case 1
            % Sum all the images
            for i = 1 : size(bf_im, 4)
                avg_im = avg_im + squeeze(bf_im(:, :, :, i));           
            end
            % Removes the maximum value of each focal point across all
            % frames, then divides by the frame count - 1 to average
            avg_im = squeeze((avg_im - squeeze(max(bf_im, [], 4))) ./ (size(bf_im, 4) - 1)); 
        % Maximum brightness voxel selected
        case 2
            % Extracts the darkest value of each focal point across all
            % frames.
            avg_im = squeeze(max(bf_im, [], 4));
        % Minimum brightness voxel selected
        case 3
            % Extracts the darkest value of each focal point across all
            % frames.
            avg_im = squeeze(min(bf_im, [], 4));
        % Mean over Standard Deviation (MSD)
        case 4
            % Nominator: average of all frames
            % Denominator: standard deviation of each frame (sqrt of the abs of
            % average of the squares minus square of the averages)
            avg_im = squeeze(mean(bf_im, 4)) ./ (sqrt(abs(squeeze(mean(bf_im .^ 2, 4)) - squeeze(mean(bf_im, 4)) .^ 2)));
            % In case some focal points are divided by 0 and become NaN,
            % set them to the darkest focal point in the image
            min_voxel = min(avg_im(:));
            avg_im(isnan(avg_im)) = min_voxel;
            % TODO why do we square the output?
            avg_im = avg_im .^ 2;
        % Zero reversal (ZREV)
        case 5
            % Creates a matrix holding the sign changes across any of the
            % frames: 1 if the sign stays constant, 0 if it changes
            zrev = ones(size(bf_im, 1), size(bf_im, 2), size(bf_im, 3));
            for i = 2 : size(bf_im, 4)
                zrev = zrev & (squeeze(sign(bf_im(:, :, :, i - 1))) == squeeze(sign(bf_im(:, :, :, i))));
            end
            % TODO this mode is supposed to be an extension of MSD, but the calculation is different?
            avg_im = squeeze(mean(bf_im, 4));
            min_voxel = min(bf_im(:));
            avg_im = avg_im .* zrev + ~zrev * min_voxel;
    end
    
    cd(fileparts(mfilename('fullpath')));
    save('../data/avg_im.mat', 'avg_im');
end 
