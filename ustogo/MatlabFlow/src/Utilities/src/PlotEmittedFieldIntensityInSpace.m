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
%% Plots the field intensity of an insonification.
% NOTE: Field II must be running before this function is called.
%
% Inputs: probe - Description of the probe
%         min_x, max_x, min_z, max_z - Area of the space to be plotted in [m]
%         grain - Resolution of the plot (fine grain means long calculation
%                 time!, scales quadratically) [m]
%         makelogplot - Whether the resulting plot should be in log (1) or
%                       linear (0) scale
%         makesliceplot - 1: also plot a cross-section field intensity diagram
%         sliceplotz - If the above is set to 1, for what depth [m] this
%                      diagram should be shown
%         polar - whether the sliceplotz refers to a depth (0) or
%                 distance from origin (1)
%         tx, rx - 1, 0: calculate emitted field only
%                  0, 1: calculate received field only
%                  1, 1: calculate two-way transmitted field
%
% Outputs: None

function [] = PlotEmittedFieldIntensityInSpace(probe, min_x, max_x, min_z, max_z, grain, makelogplot, makesliceplot, sliceplotz, polar, tx, rx)

    %% Compute field intensity on a regular grid in space. Since the
    %% number of points may be huge, save memory by studying a few
    %% thousand points at a time.
    [X, Z] = meshgrid(min_x : grain : max_x, min_z : grain : max_z);
    X = reshape(X, [], 1);
    % TODO allow for plotting at varying Y, too.
    Y = zeros(size(X));
    Z = reshape(Z, [], 1);
    points = [X Y Z];
    max_points = 6000;
    for j = 1 : max_points : size(X, 1)
        points_to_calculate = min(max_points - 1, size(X, 1) - j);
        message = ['Calculating field intensity for points ', num2str(j), ' to ', num2str(j + points_to_calculate), ' of ', num2str(size(X, 1))];
        disp(message);
        if (tx == 1 && rx == 0)
            [hp, ~] = calc_hp(probe.th, points(j : j + points_to_calculate, :, :));
        elseif (tx == 0 && rx == 1)
            [hp, ~] = calc_hp(probe.rh, points(j : j + points_to_calculate, :, :));
        elseif (tx == 1 && rx == 1)
            [hp, ~] = calc_hhp(probe.th, probe.rh, points(j : j + points_to_calculate, :, :));
        else
            error ('Undefined TX/RX settings for field display.');
        end;
        if (makelogplot == 1)
            intensity(j : j + points_to_calculate) = 20 * log10(max(abs(hp)));
        else
            intensity(j : j + points_to_calculate) = max(abs(hp));
        end
    end

    %% Plot the field intensity in space
    field = reshape(intensity, size(min_z : grain : max_z, 2), size(min_x : grain : max_x, 2));
    if (tx == 1 && rx == 0)
        title_string = sprintf('Emitted Field (cell size %.2f mm)', grain * 1000);
    elseif (tx == 0 && rx == 1)
        title_string = sprintf('Received Field (cell size %.2f mm)', grain * 1000);
    else
        title_string = sprintf('Two-way Field (cell size %.2f mm)', grain * 1000);
    end
    figure
    imagesc(1 : ((max_x - min_x) / grain) + 1, 1 : ((max_z - min_z) / grain) + 1, field);
    title(title_string);
    colorbar;
    set(gca, 'XTick', (1 : (10 / 1000) / grain : size(field, 2) - 1));  % Location of X ticks
    set(gca, 'XTickLabel', (min_x * 100 : 1 : max_x * 100));            % Labels of X ticks
    set(gca, 'YTick', (1 : (10 / 1000) / grain : size(field, 1) - 1));  % Location of Y ticks
    set(gca, 'YTickLabel', (min_z * 100 : 1 : max_z * 100));            % Labels of Y ticks
    xlabel('x [cm]'),
    ylabel('z [cm]');
    axis equal;

    %% Plot a cross-section at a given depth, if requested
    if (makesliceplot)
        % Locate the points that lie on the desired cross-section
        if (polar == 0)
            mask = (abs(Z - sliceplotz) < 0.00001);
        else
            mask = (abs(X .* X + Z .* Z - sliceplotz * sliceplotz) < 0.00001);
        end
        slice = intensity(mask');
        
        % Define the coordinates to put on the X axis of the plot below
        if (polar == 0)
            pointsonline = (X(mask))';
        else
            thetas = atan(X(mask) ./ Z(mask));
        end
        
        % Plot
        if (polar == 0)
            if (tx == 1 && rx == 0)
                title_string = sprintf('Emitted field at depth %.3f [m]', sliceplotz);
            elseif (tx == 0 && rx == 1)
                title_string = sprintf('Received field at depth %.3f [m]', sliceplotz);
            else
                title_string = sprintf('Two-way field at depth %.3f [m]', sliceplotz);
            end
            figure
            plot(pointsonline, slice);
            title(title_string);
            xlabel('X (m)');
            if (makelogplot == 1)
                ylabel('Pressure field (dB)');
            else
                ylabel('Pressure field');
            end
        else
            if (tx == 1 && rx == 0)
                title_string = sprintf('Emitted field at distance %.3f [m]', sliceplotz);
            elseif (tx == 0 && rx == 1)
                title_string = sprintf('Received field at distance %.3f [m]', sliceplotz);
            else
                title_string = sprintf('Two-way field at distance %.3f [m]', sliceplotz);
            end
            figure
            plot(thetas, slice);
            title(title_string);
            xlabel('theta (rad)');
            if (makelogplot == 1)
                ylabel('Pressure field (dB)');
            else
                ylabel('Pressure field');
            end
        end
    end
    
end
