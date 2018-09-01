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
%% Launches Field II to insonify a phantom and saves to disk the received echoes.
%
% Inputs: phantom - Description of the phantom; a struct holding the two following fields:
%                   phantom.pos - Nx3 array containing the scatterers' positions
%                   phantom.amp - N-long column vector holding the scatterers' amplitudes
%         target_phantom - Phantom name
%         probe - Description of the probe
%         image - A structure with fields describing the desired output
%                 resolution
%         zone_count - If zone imaging is requested (zone_count > 1), how many zones the
%                      image should contain (zone_count * zone_count in 3D)
%         compounding_count - If compound imaging is requested (compounding_count > 1), how
%                             many insonifications to compound
%         with_brightness_compensation - Whether to calculate a brightness compensation
%                                        map for later use in beamforming
%
% Outputs: t0 - Time delay from emission until receiving the first echoes
%          brightness_comp - Brightness compensation map due to non-even field
%                            focusing
%          The RF data is saved to disk only as it may take too much space in memory.

function [t0, brightness_comp] = InsonifyPhantom(phantom, target_phantom, probe, image, zone_count, compounding_count, with_brightness_compensation)

    %% Launch Simulation
    % Initialize Field II.
    field_init(-1);
    set_field('c', probe.c);

    % This setting improves simulation speed at little accuracy cost.
    set_field('fast_integration', 1);

    % The echo matrix "rf", which is only saved to disk in chunks (as it could become too large),
    % is a matrix representing the received echoes over time.
    if (probe.is2D == 0)
        % The logical RF matrix size is M*N*Z, where M is the number of time samples,
        % N is the number of probe elements, and Z is the number of insonifications.
        insonification_count = compounding_count * zone_count;
        for insonification_index = 1 : insonification_count
            [rf_insonification, t0, brightness_comp_zone] = SimulateRawData2D(phantom, probe, image, zone_count, compounding_count, insonification_index, with_brightness_compensation);
            StoreRFDataMatrixToDisk(target_phantom, insonification_index, rf_insonification);
            brightness_comp(:, :, insonification_index) = brightness_comp_zone;
            max_values(insonification_index) = max(abs(rf_insonification(:)));
            rf_data_size(insonification_index) = size(rf_insonification, 2);
            clear rf_insonification;
        end
        StoreRFDataMatrixMetadataToDisk(target_phantom, max(rf_data_size), 1, probe.N_elements, insonification_count, max_values);
        %TODOZONE also when Field
    else
        % The logical RF matrix size is M*N*O*Z, where M*N is the number of probe elements,
        % O is the number of time samples, and Z is the number of insonifications.
        insonification_count = compounding_count * zone_count * zone_count;
        for insonification_index = 1 : insonification_count
            [rf_insonification, t0, brightness_comp_zone] = SimulateRawData3D(phantom, probe, image, zone_count, compounding_count, insonification_index, with_brightness_compensation);
            StoreRFDataMatrixToDisk(target_phantom, insonification_index, rf_insonification);
            brightness_comp(:, :, :, insonification_index) = brightness_comp_zone;
            max_values(insonification_index) = max(rf_insonification(:));
            rf_data_size(insonification_index) = size(rf_insonification, 3);
            clear rf_insonification;
        end
        StoreRFDataMatrixMetadataToDisk(target_phantom, max(rf_data_size), probe.N_elements_y, probe.N_elements_x, insonification_count, max_values);
    end

    % Save the echoes to disk, including probe settings.
    cd(fileparts(mfilename('fullpath')));
    save ('../data/probe.mat', 'probe');
    save ('../data/brightness_comp.mat', 'brightness_comp');
    
    %% Debug features
    % Plot the echoes received at each individual element in the transducer
    % and a summed response (note that the latter is wildly off is
    % "set_focus()" is not used, because propagation delays are not
    % compensated).
    % Code based on the "Field_II" documentation at page 56.
    if (0)
        % For which zone to display this information.
        zone = 1;
        [max_radius, rows, columns, ~, max_values] = LoadRFDataMatrixMetadataFromDisk(target_phantom);
        rf = LoadRFDataMatrixFromDisk(target_phantom, zone, max_radius, rows, columns);
        normalization_factor = max_values(zone);
        figure;
        subplot(211)
        for i = 1 : rows
            for j = 1 : columns
                plot((0 : max_radius - 1) / probe.fs, squeeze((rf(i, j, :, 1)) / normalization_factor) + (i - 1) * columns + j), hold on
            end
        end
        hold off
        title('Individual traces')
        xlabel('Time [s]'), ylabel('Normalized response')
        subplot(212)
        % Sum along the first two dimensions (elements) and get an array
        % that is max_radius long
        summed_response = sum(sum(rf, 1), 2);
        plot((0 : max_radius - 1) / probe.fs, squeeze(summed_response(1, 1, :, zone)))
        title('Summed response')
        xlabel('Time [s]'), ylabel('Normalized response')
    end

end
