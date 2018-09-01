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
%% Defines a phantom comprising multiple stripes in a flat space
%% (X: along the transducer surface, Z: depth). The stripes alternate
%% black/white for an MTF test. They can be laid orthogonally in either
%% cartesian or polar spaces, for linear/phased array testing.
%
% Inputs: linear - Whether the probe is linear (1) or phased (0), and thus whether
%                  the stripes should be orthogonal in cartesian or polar spaces
%         azimuthal - Whether the testing is along the azimuth (1) or radial (0)
%                     direction (the stripes will then be orthogonal to this axis)
%         linear_phased_stripes_thickness_m, phased_stripes_thickness_degree -
%                     For either linear or phased arrays, the thickness of
%                     each alternating stripe, in m or degrees respectively
%
% Outputs: phantom_positions - Position of the scatterers in space (in
%                              meters)
%          phantom_amplitudes - Reflectivity of the scatterers
%          phantom_bbox - Coordinates of a bounding box around
%                         the scatterers' region, so that imaging
%                         can be done on that volume (in meters)

function [phantom_positions, phantom_amplitudes, phantom_bbox] = StripesPhantom(linear, azimuthal, linear_phased_stripes_thickness_m, phased_stripes_thickness_degree)
       
    narrow_step = 0.5 / 1000;
    resolution = 10;
    phantom_depth = 100 / 1000;
    % Only if linear
    phantom_width = 70 / 1000;
    % Only if phased
    phantom_halfsector = 36.5;
    
    % Cartesian stripes
    if (linear == 1)
        % Vertical stripes
        if (azimuthal == 1)
            x_comp = linspace(- phantom_width / 2, phantom_width / 2, round(phantom_width / linear_phased_stripes_thickness_m) + 1);
            z_comp  = (0 / 1000 : narrow_step : phantom_depth);
            for i = 2 : 2 : (length(x_comp) - 1)
                x_comp_tmp((i / 2 - 1) * resolution + 1 : i / 2 * resolution) = linspace(x_comp(i - 1), x_comp(i), resolution);
            end
            [x_comp_grid, z_comp_grid] = meshgrid(x_comp_tmp, z_comp);
        % Horizontal stripes
        else
            x_comp = (- phantom_width / 2 : narrow_step : phantom_width / 2);
            z_comp = linspace(0/1000, phantom_depth, round(phantom_depth / linear_phased_stripes_thickness_m) + 1);
            for i = 2 : 2 : (length(z_comp) - 1)
                z_comp_tmp((i / 2 - 1) * resolution + 1 : i / 2 * resolution) = linspace(z_comp(i - 1), z_comp(i), resolution);
            end
            [x_comp_grid, z_comp_grid] = meshgrid(x_comp, z_comp_tmp);
        end
    % Polar stripes
    else
        % Radial stripes
        if (azimuthal == 1)
            theta = linspace(- phantom_halfsector, phantom_halfsector, round(2 * phantom_halfsector / phased_stripes_thickness_degree) + 1);
            rho = (0 / 1000 : narrow_step : phantom_depth);              
          for i = 2 : 2 : (length(theta) - 1) 
              theta_tmp((i / 2 - 1) * resolution + 1 : i / 2 * resolution) = linspace(theta(i - 1), theta(i), resolution);
          end
          [theta_grid, rho_grid] = meshgrid(theta_tmp, rho);
          [z_comp_grid, x_comp_grid] = pol2cart(deg2rad(theta_grid), rho_grid);        
        % Concentric stripes
        else
            theta = linspace(- phantom_halfsector, phantom_halfsector, round(2 * phantom_halfsector) + 1);
            rho = linspace(0/1000, phantom_depth, round(phantom_depth/linear_phased_stripes_thickness_m) + 1);
            for i = 2 : 2 : (length(rho) - 1) 
              rho_tmp((i / 2 - 1) * resolution + 1 : i / 2 * resolution) = linspace(rho(i - 1), rho(i), resolution);
            end
            [theta_grid, rho_grid] = meshgrid(theta, rho_tmp);            
            [z_comp_grid, x_comp_grid] = pol2cart(deg2rad(theta_grid), rho_grid);
        end
    end
    y_comp_grid = zeros(size(x_comp_grid));        

    phantom_positions = [x_comp_grid(:), y_comp_grid(:), z_comp_grid(:)];
    phantom_amplitudes = ones(length(phantom_positions), 1);

    frame = 15 / 1000;   % How much "black space" to leave around the phantom in the image (in meters)
    phantom_bbox.min_x = min(min(x_comp_grid)) - frame;
    phantom_bbox.max_x = max(max(x_comp_grid)) + frame;
    phantom_bbox.min_y = min(min(y_comp_grid)) - frame;
    phantom_bbox.max_y = max(max(y_comp_grid)) + frame;
    phantom_bbox.min_z = max(0, min(min(z_comp_grid)) - frame);
    phantom_bbox.max_z = max(max(z_comp_grid)) + frame;
    
    scatterer_count = length(phantom_amplitudes);
    
    warning('The phantom contains %d scatterers', scatterer_count);

end
