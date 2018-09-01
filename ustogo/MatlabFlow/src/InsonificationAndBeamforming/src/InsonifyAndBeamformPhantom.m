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
%% Launches Field II to insonify a phantom and beamform the resulting echoes.
%
% Inputs: phantom - Description of the phantom; a struct holding the two following fields:
%                   phantom.pos - Nx3 array containing the scatterers' positions
%                   phantom.amp - N-long column vector holding the scatterers' amplitudes
%         probe - Description of the probe
%         tx_focus - Type of transmit focus
%         apod_full - the apodization-law matrix ("full" as we don't
%                     exploit symmetry to shrink it, yet)
%         el_max - the outermost element that must be included in
%                  beamforming calculations (depends on time and element
%                  directivity)
%         image - A structure with fields describing the desired output
%                 output resolution
%
% Outputs: bf_im - Base frequency image after beamforming and low-pass filtering

function [bf_im] = InsonifyAndBeamformPhantom(phantom, probe, tx_focus, apod_full, el_max, image)

    % TODO zone imaging is not supported here.

    %% Launch Simulation    
    % Initialize Field II.
    field_init(-1);

    % This setting improves simulation speed at little accuracy cost.
    set_field('fast_integration', 1)

    % The returned "rf" is a matrix representing the summed received echoes
    % over time.
    if (probe.is2D == 0 && probe.linear == 1)
        % Its size is M*N, where M is the number of time samples
        % and N is the number of probe elements.
        [rf] = SimulateAndBeamformRawData2DLinear(phantom, probe, tx_focus, apod_full, el_max);
    elseif (probe.is2D == 0 && probe.linear == 0)
        % Its size is M*N, where M is the number of time samples
        % and N is the number of probe elements.
        [rf] = SimulateAndBeamformRawData2DPhased(phantom, probe, tx_focus, apod_full, el_max, image);
    else
        % Its size is M*N*O, where M is the number of time samples,
        % N is the number of probe elements, and O is the number of
        % elevation planes.
        [rf] = SimulateAndBeamformRawData3DPhased(phantom, probe, tx_focus, apod_full, el_max, image);
    end

    % Save the echoes to disk, including probe settings.
    cd(fileparts(mfilename('fullpath')));
    save ('../data/beamformedechoes.mat', 'rf');
    save ('../data/beamformedechoes.mat', 'probe', '-append');
    
    %% Debug features
    % Plot the summed lines of sight.
    if (0 && probe.is2D == 0)
        figure;
        [M, N] = size(rf);
        normalization_factor = max(max(rf));
        for i = 1 : N;
            plot((0 : M - 1) / probe.fs, (rf(:, i) / normalization_factor) + i), hold on
        end
        title('Beamformed RF response')
        xlabel('Time [s]'), ylabel('Delayed and summed response')
    end
    
    %% Demodulate and low-pass filter
    % This code supports both 2D and 3D images
    for i = 1 : size(rf, 3)
        bf_im(:, :, i) = DemodulateRFImage(probe, rf(:, :, i), 1, 0); %TODO access this script from the appropriate folder
    end
    
    if (probe.linear == 1)
        save('../data/bf_im_linear.mat', 'bf_im');
    else
        save('../data/bf_im_phased.mat', 'bf_im');
    end
    
end
