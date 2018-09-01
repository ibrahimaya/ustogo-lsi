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
%% Saves to disk .mat files describing a phantom, the imaging settings, and
%% the probe settings.
%
% Inputs: phantom_type - Supported: 'six_points' (6 points in space)
%                                   'pointgrid' (a grid of points)
%                                   'circle' (a flat circle)
%                                   'line' (a line in space)
%                                   'sphere' (a sphere in space)
%                                   'spherewithwire' (a sphere in space + wire)
%                                   'dicom_XXX' (a phantom from the DICOM set)
%                                   'field_XXX' (a phantom from the DICOM set)
%         linear - 0: Phased array, 1: Linear probe
%         image - A structure with fields describing the desired output
%                 resolution
%         tx_focus - key parameter describing focusing in the flow.
%                    0 -> Plane wave (unfocused, i.e. focus at infinity)
%                    1 -> Focus at phantom's center
%                    2 -> Diverging beam (virtual source behind the transducer)
%                    3 -> Focus along each line of sight/sector (applies to multiple
%                         insonifications only, else behaves like focus 1)
%                    4 -> Weak focusing (like focus 3, but uses a wider beam)
%
% Outputs: phantom - Description of the phantom; a struct holding the two following fields:
%                    phantom.pos - Nx3 array containing the scatterers' positions
%                    phantom.amp - N-long column vector holding the scatterers' amplitudes
%          probe - Description of the probe

function [phantom, probe] = GeneratePhantomAndProbe(phantom_type, linear, image, tx_focus)

    cd(fileparts(mfilename('fullpath')));

    %% Generate and save the phantom
    if (strcmp(phantom_type, 'pointcartesian'))
        [phantom.pos, phantom.amp, phantom_bbox] = ...
            PointCartesianPhantom(0 / 1000, 0 / 1000, 30 / 1000);
            % point_x, point_y, point_z
    elseif (strcmp(phantom_type, 'pointpolar'))
        [phantom.pos, phantom.amp, phantom_bbox] = ...
            PointPolarPhantom(0, 0, 30 / 1000);
            % point_azimuth, point_elevation, point_radius
    elseif (strcmp(phantom_type, 'six_points'))
        [phantom.pos, phantom.amp, phantom_bbox] = SixPointsPhantom();
    elseif (strcmp(phantom_type, 'pointgrid'))
        [phantom.pos, phantom.amp, phantom_bbox] = PointGridPhantom();
    elseif (strcmp(phantom_type, 'circle'))
        [phantom.pos, phantom.amp, phantom_bbox] = ...
            CirclePhantom(10 / 1000, 20 / 1000, 5 / 1000, 10, 1.0);
            % center_x, center_z, r, scatterer_count, amplitude
    elseif (strcmp(phantom_type, 'line'))
        [phantom.pos, phantom.amp, phantom_bbox] = ...
            LinePhantom(1 / 1000, 0 / 1000, 10 / 1000, 5 / 1000, 0 / 1000, 20 / 1000, 100, 1.0);
            % begin_x, begin_y, begin_z, end_x, end_y, end_z, scatterer_count, amplitude
            % This line is actually in the XZ plane only
    elseif (strcmp(phantom_type, 'sphere'))
        [phantom.pos, phantom.amp, phantom_bbox] = ...
            SpherePhantom(0 / 1000, 0 / 1000, 20 / 1000, 5 / 1000, 10 / 1000, 1.0, 10000);
            % center_x, center_y, center_z, inner_r, outer_r, amplitude, scatterers_per_volume
    elseif (strcmp(phantom_type, 'spherewithwire'))
        [phantom.pos, phantom.amp, phantom_bbox] = ...
            SphereWithWirePhantom(0 / 1000, 0 / 1000, 20 / 1000, 5 / 1000, 10 / 1000, 1.0, 10000, 200, 0, 0, 0);
            % center_x, center_y, center_z, inner_r, outer_r, amplitude, scatterers_per_volume, wire_scatterer_count, wire_rho, wire_phi, wire_theta
    elseif (strcmp(phantom_type, 'cysts'))
        [phantom.pos, phantom.amp, phantom_bbox] = ...
            CystsPhantom(200000);
            % scatterer_count
    elseif (strcmp(phantom_type, 'stripes'))
        [phantom.pos, phantom.amp, phantom_bbox] = ...
            StripesPhantom(linear, 1, 10 / 1000, 10);
            % linear, azimuthal, linear_phased_stripes_thickness_m, phased_stripes_thickness_degree
    elseif (strfind(phantom_type, 'dicom') == 1)
        [phantom.pos, phantom.amp, phantom_bbox] = ...
            DICOMPhantom(-30 / 1000, -30 / 1000, 5 / 1000, 100 / 1000, 1e3, phantom_type, 1);
            % min_x=-max_x, min_y=-max_y, min_z, max_z, scatterer_count, phantom_name, y_trim
    elseif (strfind(phantom_type, 'field') == 1)
        [phantom.pos, phantom.amp, phantom_bbox] = ...
            FieldPhantom(phantom_type);
            % phantom_name
    else
        error('Unsupported phantom type "%s"; supported are "six_points", "circle", "line", "sphere", "spherewithwire", "dicom_XXX", "field_XXX"', phantom_type);
    end
    save(strcat('../data/pht_', phantom_type, '.mat'), 'phantom');

    %% Save the probe settings
    % 1D linear probe
    if (linear == 1 && image.elevation_lines == 1)
        z_focus = 10; % Transmission focus depth in [m], set to "infinity" (e.g. 10 m)
    % 1D phased probe
    elseif (linear == 0 && image.elevation_lines == 1)
        z_focus = (phantom_bbox.min_z + phantom_bbox.max_z) / 2; % Transmission focus depth in [m]
    % 2D phased probe
    elseif (linear == 0 && image.elevation_lines > 1)
        z_focus = (phantom_bbox.min_z + phantom_bbox.max_z) / 2; % Transmission focus depth in [m]
    % 2D linear probe
    else
        error ('Undefined probe definition mode: 3D Imaging only supports phased arrays.');
    end
    dBRange = 50;
    if (image.elevation_lines == 1)
        [probe] = Create1DProbe(linear, z_focus, tx_focus, dBRange, phantom_bbox);
    else
        [probe] = Create2DProbe(linear, z_focus, tx_focus, dBRange, phantom_bbox);
    end
    save('../data/probe.mat', 'probe');

    %% Debug features
    if (0)
        figure, stem3(phantom.pos(:,1), phantom.pos(:,2), phantom.pos(:,3), 'linestyle', 'none'), ...
            xlabel('x (m)'), ylabel('y (m)'), zlabel('z (m)'), ...
            axis([phantom_bbox.min_x phantom_bbox.max_x phantom_bbox.min_y phantom_bbox.max_y phantom_bbox.min_z phantom_bbox.max_z]);
        disp(probe)
    end

end