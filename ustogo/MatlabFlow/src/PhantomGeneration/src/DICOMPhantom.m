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
%% Defines a phantom from the http://www.osirix-viewer.com/datasets/ website
%% (X: along the transducer surface, Y: across the transducer surface, Z: depth).
%
% Inputs: min_x=-max_x, min_y=-max_y, min_z, max_z - Location of the
%                                                    phantom in space
%         scatterer_count - How many scatterers to generate in the volume
%         phantom_name - Name of the phantom to generate
%         y_trim - Whether to keep a whole 3D volume, or to trim it to a
%                  2mm slice around the XZ plane (speeds up imaging of the
%                  cross section)
%
% Outputs: phantom_positions - Position of the scatterers in space
%          phantom_amplitudes - Reflectivity of the scatterers
%          phantom_bbox - Coordinates of a bounding box around
%                         the scatterers' region, so that imaging
%                         can be done on that volume (in meters)

function [phantom_positions, phantom_amplitudes, phantom_bbox] = DICOMPhantom(min_x, min_y, min_z, max_z, scatterer_count, phantom_name, y_trim)

    % TODO extend this
    if (strcmp(phantom_name, 'dicom_fourdix'))
        basedir = '../dicom/FOURDIX/RATIB1/Cardiac 1CTA_CORONARY_ARTERIES_lowHR_TESTBOLUS (Adult)/CorCTALow  0.75  B25f  Diastolic/';
    elseif (strcmp(phantom_name, 'dicom_magix'))
        basedir = '../dicom/MAGIX/Cardiaque Cardiaque_standard (Adulte)/Cir  CardiacCirc  3.0  B20f  0-90% RETARD_DECLECHEMENT 50 % - 10/';
    end
    listing = dir(basedir);
    for i = 3 : length(listing)
        data(:, i - 2, :) = dicomread(strcat(basedir, listing(i).name));
    end

    % Bounding box
    ss.scope.xminmax = - min_x;
    ss.scope.yminmax = - min_y;
    ss.scope.zmin = min_z;
    ss.scope.zmax = max_z;

    % Transpose input to work around a bug in the script below
    addpath('../../../../IIS/DelayComputationSimulation/lib/system');
    addpath('../../../../IIS/DelayComputationSimulation/lib/system/auxiliary');
    phantom = SC_gen_from_volume(ss, permute(data, [3 2 1]), scatterer_count);
    phantom_positions = phantom.pos;
    phantom_amplitudes = phantom.amp;
    
    if (y_trim == 1)
        indx = 1;
        for i = 1 : size(phantom.pos, 1)
            if (phantom.pos(i, 2) < 0.001 && phantom.pos(i, 2) > -0.001)
                trimmed_phantom.pos(indx, :) = phantom.pos(i, :);
                trimmed_phantom.amp(indx, :) = phantom.amp(i);
                indx = indx + 1;
            end
        end
        phantom = trimmed_phantom;
    end

    frame = 15 / 1000;   % How much "black space" to leave around the phantom in the image (in meters)
    phantom_bbox.min_x = min(phantom.pos(:, 1)) - frame;
    phantom_bbox.max_x = max(phantom.pos(:, 1)) + frame;
    phantom_bbox.min_y = min(phantom.pos(:, 2)) - frame;
    phantom_bbox.max_y = max(phantom.pos(:, 2)) + frame;
    phantom_bbox.min_z = max(0, min(phantom.pos(:, 3)) - frame);
    phantom_bbox.max_z = max(phantom.pos(:, 3)) + frame;

    warning('The phantom contains %d scatterers', scatterer_count);

end
