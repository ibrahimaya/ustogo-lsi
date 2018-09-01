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
%% Inputs: data_aurora_fifo - this should be the signal recorded by hw_ila_1. Note
%% importantly, that this array should be in "Signed Decimal" format, not
%% binary nor hex. This can be controlled using via the Radix of the ila in vivado.
%
% Outputs: data_aurora_fifo_matlab

function [data_aurora_fifo_matlab] = aurorachanorder_to_matlab (data_aurora_fifo)

    %% DATE 2017 reordering of the transducer channels:
    chan_order = [17, 2,  6,  10, 14, 37, 33, 29, ...
        25, 21, 50, 54, 58, 62, 45, 41, ...
        19, 0,  4,  8,  12, 39, 35, 31, ...
        27, 23, 48, 52, 56, 60, 47, 43, ...
        16, 3,  7,  11, 15, 36, 32, 28, ...
        24, 20, 51, 55, 59, 63, 44, 40, ...
        18, 1,  5,  9,  13, 38, 34, 30, ...
        26, 22, 49, 53, 57, 61, 46, 42];

    %% Put the "data_aurora_fifo" recorded by "hw_ila_1" in matlab format, i.e. 64 * time_samples
    chan_count = 64;
    data_aurora_fifo_matlab = zeros(chan_count, length(data_aurora_fifo) / chan_count);

    for i = 1 : length(data_aurora_fifo)
        counter = mod(i, chan_count);
        if counter == 0
            counter = chan_count;
        end
        time_sample = ceil(i / chan_count);
        data_aurora_fifo_matlab(chan_order(counter) + 1, time_sample) = data_aurora_fifo(i);
    end

    % %% Plotting data_aurora_fifo_matlab as subplots: 
    % figure, 
    % for i = 1 : chan_count
    % subplot(chan_count, 1, i);
    % plot(data_aurora_fifo_matlab(i, :));
    % ylim([-2000 2000])
    % xlim([1 length_data_recorded / chan_count])
    % end

    figure, imagesc(data_aurora_fifo_matlab)
end

