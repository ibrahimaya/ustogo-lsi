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
%% input parameters. The probe is 1D (=> for 2D imaging).
%
% Inputs: linear - 0: Phased array, 1: Linear probe
%         z_focus - Focus depth in [m] (set to "infinity" for plane wave imaging)
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

function [probe] = Create1DProbe(linear, z_focus, tx_focus, dBRange, phantom_bbox)

    % Settings
    probe.linear = linear;                    % Whether the probe is linear or phased array
    probe.is2D = 0;                           % Whether the probe is 2D (3D Imaging) or 1D (2D Imaging) 
    probe.f0 = 3.5e6;                         % Transducer center frequency [Hz]
    probe.fs = 200e6;                         % Sampling frequency [Hz]
    probe.c = 1540;                           % Speed of sound [m/s]
    probe.lambda = probe.c / probe.f0;        % Wavelength [m]
    probe.height = 5 / 1000;                  % Height of element [m]
    if (linear == 0)
        probe.width = probe.lambda / 2;       % Width of element
        probe.kerf = probe.lambda / 20;       % Kerf [m]
        probe.N_elements = 32;                % Total physical elements
        probe.N_active_th = probe.N_elements; % Active elements in TX/RX (TODO this is unused for now)
        probe.N_active_rh = probe.N_elements;
    else
        probe.width = probe.lambda / 1;       % Width of element
        probe.kerf = probe.lambda / 10;       % Kerf [m]
        probe.N_elements = 192;               % Total physical elements
        probe.N_active_th = probe.N_elements; % Active elements in TX/RX (TODO this is unused for now)
        probe.N_active_rh = probe.N_elements;
    end
    probe.pitch = probe.width + probe.kerf;   % Element pitch [m]
    probe.focus = [0 0 z_focus];              % Fixed focal point of the probe [m]. In case of plane wave imaging, z_focus (focus depth) should be at "infinity".
                                              % Note that this parameter is only used for probe initialization but bears little relevance in the code.
    probe.tx_focus = tx_focus;                % This is the key parameter describing focusing in the flow.
                                              % 0 -> Plane wave (unfocused, i.e. focus at infinity)
                                              % 1 -> Focus at phantom's center
                                              % 2 -> Diverging beam (virtual source behind the transducer)
                                              % 3 -> Focus along each line of sight/sector (applies to multiple
                                              %      insonifications only, else behaves like focus 1)
                                              % 4 -> Weak focusing (like focus 3, but uses a wider beam)
    probe.elevation_focus_radius = 30 / 1000; % Curvature radius of the probe [m] for elevation focusing
    probe.transducer_width = (probe.N_elements - 1) * probe.pitch + probe.width;
    probe.phantom_bbox = phantom_bbox;        % Location of the phantom in the volume
    probe.dBRange = dBRange;
    
    % Apodization
    % No apodization in receive, because it will be dynamically applied
    % based on an expanding aperture during beamforming.
    probe.rx_apo = ones(1, probe.N_elements);
    % Transmit apodization depending on circumstances.
    % TODO as written, it assumes that the active elements are in the center.
    probe.tx_apo = [zeros(1, (probe.N_elements - probe.N_active_th) / 2) ones(1, probe.N_active_th) zeros(1, (probe.N_elements - probe.N_active_th) / 2)];

    % Calculate the impulse response
    % TODO play with these two lines
    probe.excitation = sin(2 * pi * probe.f0 * (0 : 1 / probe.fs : 2 / probe.f0));
    probe.impulse_response = probe.excitation .* hanning(max(size(probe.excitation)))';
    
end
