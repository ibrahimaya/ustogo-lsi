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
% 
% Outputs: max_radius - The deepest RF echo sample index across all insonifications
%          rows, columns - The size of the transducer
%          insonifications - The insonification count, either for zone
%                            imaging or compounding
%          max_values - An array of the highest echo amplitude in each
%                       insonification

function[max_radius, rows, columns, insonifications, max_values] = LoadRFDataMatrixMetadataFromDisk(target_phantom)
    launch_folder = pwd;
    cd(fullfile(fileparts(mfilename('fullpath')), '..', '..', 'Insonification', 'data'));
    load(strcat('echo_metadata_', target_phantom, '.mat'));
    cd(launch_folder);
end
