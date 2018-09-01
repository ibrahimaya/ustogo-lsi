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
%% This function does IQ demodulation of a signal. The output is similar to
%% a Hilbert filter.
%
% Inputs: x - Signal to demodulate; entered as a matrix
%             (if RF signal: [#time samples : #transducer elements])
%         f_us - Downmixing frequency [Hz]
%         fs - Frequency at which x has been sampled [Hz]
%
% Outputs: out - Demodulated signal

function [out] = IQ_demod(x, f_us, fs)

    % Figure out the dimensions of signal x
    [siz1, siz2] = size(x); % [number of time samples, number of transducer elements]
    % kos = cos(2 * pi * f_us * ([1 : siz1] / fs));
    % zin = sin(2 * pi * f_us * ([1 : siz1] / fs));
    carriers = exp(1i * 2 * pi * f_us * (1 : siz1) / fs)';

    %% Demodulation
    % Multiply carriers (replicated as many times as the time
    % samples of x) by x. The output "IQ" is complex
    % I = kos(:) .* x(:);
    % Q = zin(:) .* x(:);
    % IQ = I + j * Q;
    out = repmat(carriers, [1 siz2]) .* x;

end
