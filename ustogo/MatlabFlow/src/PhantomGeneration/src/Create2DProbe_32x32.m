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
%% Generates a data structure modeling an ultrasound probe based on a few
%% input parameters. The probe is 2D (=> for 3D imaging).
%
% Inputs: linear - 0: Phased array, 1: Linear probe
%         z_focus - Focus depth in [m]
%         tx_focus - key parameter describing focusing in the flow.
%                    0 -> Plane wave (unfocused, i.e. focus at infinity)
%                    1 -> Focus at phantom's center
%                    2 -> Diverging beam (virtual source behind the transducer)
%                    3 -> Focus along each line of sight/sector (applies to multiple
%                         insonifications only, else behaves like focus 1)
%                    4 -> Weak focusing (like focus 3, but uses a wider beam)
%         dBRange - TODO?
%         phantom_bbox - Location (namely: depth) of the phantom in the
%                        volume. TODO: looks slightly inappropriate here.
%
% Outputs: probe - Description of the probe. Will set: width = lambda / 2,
%                  kerf = lambda / 10 (linear) or kerf = lambda / 2 (sectorial)

function [probe] = Create2DProbe(linear, z_focus, tx_focus, dBRange, phantom_bbox)

    % Settings
    probe.linear = linear;                        % Whether the probe is linear or phased array
    probe.is2D = 1;                               % Whether the probe is 2D (3D Imaging) or 1D (2D Imaging) 
    probe.f0 = 4e6;                               % Transducer center frequency [Hz]
    probe.fs = 20e6;                              % Sampling frequency [Hz]
    probe.c = 1540;                               % Speed of sound [m/s]
    probe.lambda = probe.c / probe.f0;            % Wavelength [m]
    probe.width = probe.lambda / 4;               % Width of element
    probe.height = probe.lambda / 4;              % Height of element [m]
    if (linear == 0)
        probe.kerf_x = probe.lambda / 4;          % Kerf [m]
        probe.kerf_y = probe.lambda / 4;          % Kerf [m]
        probe.N_elements_x = 32;                  % Physical elements in the x direction
        probe.N_elements_y = probe.N_elements_x;  % Physical elements in the y direction
        probe.N_active_th_x = probe.N_elements_x; % Active elements in the x, y direction for TX (TODO unsupported for now, also below)
        probe.N_active_th_y = probe.N_elements_y;
        probe.N_active_rh_x = probe.N_elements_x; % Active elements in the x, y direction for RX
        probe.N_active_rh_y = probe.N_elements_y;
    else % TODO This mode is not defined yet
        probe.kerf_x = probe.lambda / 10;         % Kerf [m]
        probe.kerf_y = probe.lambda / 10;         % Kerf [m]
        probe.N_elements_x = 16;                  % Physical elements in the x direction
        probe.N_elements_y = probe.N_elements_x;  % Physical elements in the y direction
        probe.N_active_th_x = probe.N_elements_x; % Active elements in the x, y direction for TX
        probe.N_active_th_y = probe.N_elements_y;
        probe.N_active_rh_x = probe.N_elements_x; % Active elements in the x, y direction for RX
        probe.N_active_rh_y = probe.N_elements_y;
    end
    probe.pitch_x = probe.width + probe.kerf_x;   % Element pitch in the x direction [m]
    probe.pitch_y = probe.height + probe.kerf_y;  % Element pitch in the y direction [m]
    probe.focus = [0 0 z_focus];                  % Fixed focal point of the probe [m]. In case of plane wave imaging, z_focus (focus depth) should be at "infinity".
                                                  % Note that this parameter is only used for probe initialization but bears little relevance in the code.
    probe.tx_focus = tx_focus;                    % This is the key parameter describing focusing in the flow.
                                                  % 0 -> Plane wave (unfocused, i.e. focus at infinity)
                                                  % 1 -> Focus at phantom's center
                                                  % 2 -> Diverging beam (virtual source behind the transducer)
                                                  % 3 -> Focus along each line of sight/sector (applies to multiple
                                                  %      insonifications only, else behaves like focus 1)
                                                  % 4 -> Weak focusing (like focus 3, but uses a wider beam)
    % TODO the code is untested for non-square matrices and indices in some
    % places may be swapped for x/y if different.
    probe.transducer_width = (probe.N_elements_x - 1) * probe.pitch_x + probe.width;
    probe.transducer_height = (probe.N_elements_y - 1) * probe.pitch_y + probe.height;
    probe.xm = linspace(- probe.transducer_width / 2, probe.transducer_width / 2, probe.N_elements_x*probe.N_elements_y); % TODO?
    probe.phantom_bbox = phantom_bbox;            % Location of the phantom in the volume
    probe.dBRange = dBRange;
    
    % Apodization
    % No apodization in receive, because it will be dynamically applied
    % based on an expanding aperture during beamforming.
    probe.rx_apo = ones(probe.N_elements_y, probe.N_elements_x);
    % Transmit apodization depending on circumstances.
    probe.tx_apo = ones(probe.N_elements_y, probe.N_elements_x);

    % Calculate the impulse response
    % TODO play with these two lines
    probe.excitation = sin(2 * pi * probe.f0 * (0 : 1 / probe.fs : 2 / probe.f0));
    probe.impulse_response = probe.excitation .* hanning(max(size(probe.excitation)))';

end
