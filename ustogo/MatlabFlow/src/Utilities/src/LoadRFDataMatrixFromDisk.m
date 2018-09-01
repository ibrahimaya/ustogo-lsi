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
%% These utility functions load and store from/to disk the TX delays and RF
%% data for different insonifications. Necessary as these matrices can be 4D
%% (when doing 3D imaging with zone imaging/compounding) and use way too much
%% memory.
% 
% Inputs: target_phantom - Phantom name
%         insonification_range - Which insonification data to return
%         max_radius - The deepest RF echo sample index across all
%                      insonifications. Used to pad the returned RF data
%                      with 0s to that depth for uniformity.
%         rows, columns - The size of the transducer
%
% Outputs: rf - Radio-frequency matrix containing the raw data of the
%               echoes scattered back.

function[rf] = LoadRFDataMatrixFromDisk(target_phantom, insonification_range, max_radius, rows, columns)
    rf_data = zeros(rows, columns, max_radius, max(insonification_range) - min(insonification_range) + 1);
    launch_folder = pwd;
    cd(fullfile(fileparts(mfilename('fullpath')), '..', '..', 'Insonification', 'data'));
    for insonification_index = min(insonification_range) : max(insonification_range)
        load(strcat('echoes_', target_phantom, '_', num2str(insonification_index), '.mat'));
        if (ndims(rf) == 2)
            rf_data(1, :, 1 : size(rf, 2), insonification_index - min(insonification_range) + 1) = rf;
        elseif (ndims(rf) == 3)
            rf_data(:, :, 1 : size(rf, 3), insonification_index - min(insonification_range) + 1) = rf;
        else
            error('Too many dimensions in the rf data.')
        end
    end
    rf = rf_data;
    cd(launch_folder);
end
