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
%% Computes the compounded sampling error due to Taylor geometric
%% approximations plus the effects of fixed-point roundings. Outputs the
%% corresponding distribution profile.
%
% Inputs: probe - description of the probe
%         bits - the number of bits used for the fixed-point representation
%         taylor_inaccuracy, taylor_inaccuracy_distr - the distribution of
%                      the Taylor inaccuracy (X and Y axes). The X axis
%                      must be sampled at a fraction "1/inaccuracy_grain_multiple"
%                      of the sampling period probe.fs.
%         inaccuracy_grain_multiple - the frequency multiplier used for the
%                                     previous parameter, e.g. 10 ->
%                                     distribution sampled with a grain of
%                                     0.1 delay samples. Must be integer.
%
% Outputs: compound_sampling_error, compound_sampling_error_distr - the
%                               distribution of the compound sampling
%                               error (X and Y axes). The X axis is sampled
%                               at a fraction "step" (defined below) of the
%                               sampling period probe.fs.

function [compound_sampling_error, compound_sampling_error_distr] = ConvolveInaccuracyProfiles(probe, bits, taylor_inaccuracy, taylor_inaccuracy_distr, inaccuracy_grain_multiple)

    %% Fixed-point representation accuracy
    % [samples]
    % 13.N bit representation for the reference delays 
    ref_decimal_bits = bits - 13;
    lsb_ref = 1 / (2 ^ ref_decimal_bits);
    % +/-13.M bit representation for the correction factors
    cor_decimal_bits = bits - 14;
    lsb_cor1 = 1 / (2 ^ cor_decimal_bits);
    lsb_cor2 = 1 / (2 ^ cor_decimal_bits);

    % Calculate inaccuracies in 1/100th of a sample intervals
    step = 1 / 1000;

    % Sampling rate (as a fraction of probe.fs) of the taylor_inaccuracy,
    % taylor_inaccuracy_distr inputs
    taylor_sampling_interval = 1 / inaccuracy_grain_multiple;

    %% Inaccuracy distribution due to fixed-point representation
    % Inaccuracy interval [s]
    x_ref = (-0.5 * lsb_ref : step : 0.5 * lsb_ref);
    x_cor1 = (-0.5 * lsb_cor1 : step : 0.5 * lsb_cor1);
    x_cor2 = (-0.5 * lsb_cor2 : step : 0.5 * lsb_cor2);
    x_rounding = (-0.5 : step : 0.5);
    % Inaccuracy distribution
    f_ref(1 : length(x_ref)) = 1 / lsb_ref;
    f_cor1(1: length(x_cor1)) = 1 / lsb_cor1;
    f_cor2(1 : length(x_cor2)) = 1 / lsb_cor2;
    f_rounding(1 : length(x_rounding)) = 1 / 0.5;

    %figure, plot(x_ref, f_ref, 'r'), hold on,
    %plot(x_cor1, f_cor1, 'b'), hold on,
    %plot(x_cor2, f_cor2, 'g'), hold on,
    %plot(x_rounding, f_rounding, 'k'), hold off

    % tmp_pad_min = min([min(x_ref) min(x_cor1) min(x_cor2) min(x_count)]);
    % tmp_pad_max = max([max(x_ref) max(x_cor1) max(x_cor2) max(x_count)]);

    %% Inaccuracy distribution due to Taylor approximation
    % First, interpolate the input Taylor distribution to use the same step
    % defined for the correction coefficients. This relies on the input Taylor
    % distribution being defined on a grid that is based on a fraction of a sample.
    taylor_interpolation_factor = round(taylor_sampling_interval / step);
    % Use non-default parameters for interpolation. In particular,
    % interpolate by using adjacent samples only (L = 1). This is because
    % the distribution can have steep slopes (high-frequency components)
    % that may throw the interpolation off, resulting even in overshoots
    % into negative (!) values for the interpolated distribution.
    interpolated_taylor_inaccuracy_distr = interp(taylor_inaccuracy_distr, taylor_interpolation_factor, 1, 0.5);    
    interpolated_taylor_inaccuracy = interp(taylor_inaccuracy, taylor_interpolation_factor) * taylor_sampling_interval;
    % Now renormalize the distribution so that the Y axis shows the number of occurrences
    interpolated_taylor_inaccuracy_distr = interpolated_taylor_inaccuracy_distr ./ (sum(interpolated_taylor_inaccuracy_distr) / sum(taylor_inaccuracy_distr));

    % taylor_fit = fit(taylor_inaccuracy', taylor_inaccuracy_distr', 'gauss4');
    % f_taylor = feval(taylor_fit, x_count);
    % x_count_new = min(taylor_inaccuracy) : step : max(taylor_inaccuracy);
    % f_taylor = feval(taylor_fit, x_count_new);

    %% Convolution of all effects
    g = conv(f_ref, f_cor1);
    h = conv(g, f_cor2);
    i = conv(h, f_rounding);
    compound_sampling_error_distr = conv(interpolated_taylor_inaccuracy_distr, i);
    % Interval over which the convolution is defined
    x_g = x_ref(1) + x_cor1(1) : step : x_ref(end) + x_cor1(end);
    x_h = x_ref(1) + x_cor1(1) + x_cor2(1) : step : x_ref(end) + x_cor1(end) + x_cor2(end);
    x_i = x_ref(1) + x_cor1(1) + x_cor2(1) + x_rounding(1) : step : x_ref(end) + x_cor1(end) + x_cor2(end) + x_rounding(end);
    compound_sampling_error = x_ref(1) + x_cor1(1) + x_cor2(1) + x_rounding(1) + interpolated_taylor_inaccuracy(1) : step : x_ref(end) + x_cor1(end) + x_cor2(end) + x_rounding(end) + interpolated_taylor_inaccuracy(end);
    % This "trick" is because, due to roundings, the two arrays may have one-off sizes.
    compound_sampling_error_distr = compound_sampling_error_distr(1 : size(compound_sampling_error, 2));
    % Now renormalize the distribution so that the Y axis shows the number of occurrences
    compound_sampling_error_distr = compound_sampling_error_distr ./ (sum(compound_sampling_error_distr) / sum(taylor_inaccuracy_distr));

    % figure, plot(x_w, w, 'k'),
    %         %hold on, plot(interpolated_taylor_inaccuracy, interpolated_taylor_inaccuracy_distr, 'r'),
    %         %hold on, plot(x_ref, f_ref, 'c'),
    %         %hold on, plot(x_cor1, f_cor1, 'b'),
    %         %hold on, plot(x_cor2, f_cor2, 'g'),
    %         hold off,
    % xlabel('Sampling inaccuracy [samples]'),
    % ylabel('Occurrences [count of (S, D) pairs]'),
    % title('Total sampling inaccuracy');
    % currentlim = ylim;
    % ylim(gca, [0 currentlim(2)]);
    % set(gca, 'FontSize', 14)
    % set(findall(gcf, 'type', 'text'), 'FontSize', 12)

    %% Maximum and average absolute error
    message = ['For a precision of ', num2str(bits), ' bits:'];
    disp(message);
    max_abs_error_N = max(abs(compound_sampling_error));     % Maximum absolute error in terms of number of samples.
    max_abs_error_T = max(abs(compound_sampling_error / probe.fs));                % Maximum absolute error in time (secs).
    message = ['The max absolute error is ', num2str(max_abs_error_N), ' samples, and ', num2str(max_abs_error_T), ' [s].'];
    disp(message);
    avg_abs_error_N = sum(abs(compound_sampling_error) * compound_sampling_error_distr') / sum(compound_sampling_error_distr);  % Average absolute error in terms of number of samples.
    avg_abs_error_T = sum(abs(compound_sampling_error / probe.fs) * compound_sampling_error_distr') / sum(compound_sampling_error_distr); % Average absolute error in terms of number of samples.
    message = ['The average absolute error is ', num2str(avg_abs_error_N), ' samples, and ', num2str(avg_abs_error_T), ' [s].'];
    disp(message);

end
