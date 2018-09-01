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
%% Calculates the directivity of a probe element with Selfridge and Kino's
%% model.
%
% Inputs: probe - Description of the probe
%
% Outputs: theta_max - the angle [rad] at which element directivity
%                      degrades by 1/sqrt(2)

function [theta_max] = GetProbeElementDirectivity(probe)

    % Over a circular sector
    theta = 0 : 0.01 : 1.2;
    % Calculate Selfridge and Kino's model of directivity
    x = probe.f0 / probe.c * probe.width .* sin(theta);
    directivity = sinc(x) .* cos(theta);
    % Identify at what angle directivity is reduced by 1/sqrt(2)
    directivity_th = 0.707;
    theta_max = theta(max(find(directivity > directivity_th)));

    %% Debug features
    if (0)
        figure; plot(theta, directivity); grid; title('Element directivity (Selfridge and Kino model)');
    end

end