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
%% Image demodulation based on RF data matrix.
%
% Inputs: probe - Description of the probe
%         rf_im - Radio-frequency matrix containing the summed and delayed
%                 backscattered echoes (RF lines along columns, time
%                 along rows)
%         downsampling_factor - If downsampling is used, what the
%                               downsampling factor is (1 = no downsampling)
%         use_phase_correction - Whether to use phase correction in case
%                                downsampling is used
%         demod_method - Which demodulation method to use:
%                        0: hilbert + Butterworth lowpass
%                        1: hilbert + FIR lowpass
%                        2: IQ demodulation + Butterworth lowpass
%                        3: IQ demodulation + FIR lowpass
%                        4: square root + Butterworth lowpass
%                        5: square root + FIR lowpass
%                        6: abs + Butterworth lowpass
%                        7: abs + FIR lowpass
%
% Outputs: bf_im - Base frequency image after beamforming and low-pass

function [bf_im] = DemodulateRFImage(probe, rf_im, downsampling_factor, use_phase_correction, demod_method)

    f_us = probe.f0;                     % Center RF frequency [Hz]
    fs = probe.fs / downsampling_factor; % RX sampling frequency [Hz]

    % Choose which type of envelope detection to implement.
    if (demod_method == 0 || demod_method == 1)
        use_hilbert = 1;                     % Use Hilbert to demodulate the image
        use_iqdem = 0;                       % Use IQ to demodulate the image
        use_sqrt = 0;                        % Use a square/squareroot to demodulate the image
    elseif (demod_method == 2 || demod_method == 3)
        use_hilbert = 0;                     % Use Hilbert to demodulate the image
        use_iqdem = 1;                       % Use IQ to demodulate the image
        use_sqrt = 0;                        % Use a square/squareroot to demodulate the image
    elseif (demod_method == 4 || demod_method == 5)
        use_hilbert = 0;                     % Use Hilbert to demodulate the image
        use_iqdem = 0;                       % Use IQ to demodulate the image
        use_sqrt = 1;                        % Use a square/squareroot to demodulate the image
    elseif (demod_method == 6 || demod_method == 7)
        use_hilbert = 0;                     % Use Hilbert to demodulate the image
        use_iqdem = 0;                       % Use IQ to demodulate the image
        use_sqrt = 0;                        % Use a square/squareroot to demodulate the image
        % If none of the above is set, use the simplest possible demodulation: abs() + lowpass
    end
    
    % Choose which type of lowpass filter to implement.
    if (demod_method == 0 || demod_method == 2 || demod_method == 4 || demod_method == 6)
        use_butter_filter = 1;
    elseif (demod_method == 1 || demod_method == 3 || demod_method == 5 || demod_method == 7)
        use_butter_filter = 0;
        % i.e., use a very simple FIR filter implementation
    end

    %% Define lowpass filter
    lp_fc = min(fs / 2, f_us / 2);       % Low-pass imaging filter cutoff frequency
    lp_filter_order = 4;
    wn_lp = 0.999 * (2 / fs * lp_fc);    % Solves a small issue where the cutoff frequency
                                         % may be exactly 1, while the filter requires <1
    if (use_butter_filter == 1)
        [b_lp, a_lp] = butter(lp_filter_order, wn_lp, 'low');
    else
        b_lp = fir1(lp_filter_order, wn_lp, 'low');
        a_lp = 1;
    end

    %% Lowpass filter delay compensation
    % Lowpass filters induce a delay in the filtered signal.
    % https://dsp.stackexchange.com/questions/18435/group-delay-of-the-fir-filter
    % Compensate it by adding an equal amount of extra samples to the end of the input signal,
    % then removing the same number of samples from the beginning of the output
    if (use_butter_filter == 1)
        induced_delay = 0; % TODO study the delay of a Butterworth filter
    else
        % FIR filters have a delay equal to (N - 1) / 2 samples, where N is the number of taps (== filter order + 1)
        induced_delay = (lp_filter_order + 1 - 1) / 2;
    end
    if (induced_delay > 0)
        rf_im = vertcat(rf_im, zeros(induced_delay, size(rf_im, 2)));
    end
    
    %% Demodulate
    if (use_phase_correction == 0)
        if (use_hilbert == 1)
            bf_im = hilbert(rf_im);
            if (use_butter_filter == 1)
                bf_im = filtfilt(b_lp, a_lp, abs(bf_im));
            else
                bf_im = filter(b_lp, a_lp, abs(bf_im));
            end
        elseif (use_iqdem == 1)
            bf_im = IQ_demod(rf_im, f_us, fs);
            if (use_butter_filter == 1)
                bf_im = filtfilt(b_lp, a_lp, abs(bf_im));
            else
                bf_im = filter(b_lp, a_lp, abs(bf_im));
            end                
        elseif (use_sqrt == 1)
            % http://www.mathworks.com/help/dsp/examples/envelope-detection.html
            if (use_butter_filter == 1)
                bf_im = sqrt(abs(filtfilt(b_lp, a_lp, 2 * rf_im .^ 2)));
            else
                bf_im = sqrt(abs(filter(b_lp, a_lp, 2 * rf_im .^ 2)));
            end
        else
            if (use_butter_filter == 1)
                bf_im = filtfilt(b_lp, a_lp, abs(rf_im));
            else
                bf_im = filter(b_lp, a_lp, abs(rf_im));
            end
        end
    else
        % When using phase correction, the beamformed image has already
        % undergone a Hilbert transform, so we should only do the low-pass
        % step here.
        if (use_butter_filter == 1)
            bf_im = filtfilt(b_lp, a_lp, sqrt(2) * abs(real(rf_im)));
        else
            bf_im = filter(b_lp, a_lp, sqrt(2) * abs(real(rf_im)));
        end
    end
    
    if (induced_delay > 0)
        bf_im = bf_im(induced_delay + 1 : size(bf_im, 1), :);
    end

end
