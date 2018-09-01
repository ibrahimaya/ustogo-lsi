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
%% Models and saves to disk the "Trimming" apodization scheme for the
%% subsequent 3D BF-initialization function.
%
% Inputs: probe - Description of the probe
%         image - A structure with fields describing the desired output
%                 output resolution
%         with_square_apodization - 0: calculate independently the height and
%                                      width of the apodization windows;
%                                   1: make the windows square
%
% Outputs: el_max_width, el_max_height - the outermost element in the 
%                                        azimuth and elevation directions
%                                        that must be included in beamforming
%                                        calculations (depends on "Trimming"
%                                        apodization model)
%          x_c, y_c - the center of the apodization window

function [el_max_width, el_max_height, x_c, y_c] = TrimmingApodizationScheme(probe, image, with_square_apodization)
    % TODO relies on 73, 73, 1:8311 resolution

    [~, ~, ~, image_lower_limit_N, xz_sector, yz_sector] = GetPhantomCoordinates(probe, image);
    azimuth_lines = round(xz_sector * 180 / pi); % By default, one image line per degree
    elevation_lines = round(yz_sector * 180 / pi);  % By default, one elevation slice per degree

    el_max = zeros(image_lower_limit_N, 1);
    el_max_width = zeros(image_lower_limit_N, elevation_lines, azimuth_lines);
    el_max_height = zeros(image_lower_limit_N, elevation_lines, azimuth_lines);
    x_c = zeros(image_lower_limit_N, azimuth_lines);
    y_c = zeros(image_lower_limit_N, elevation_lines);

    % A scatterer on the central line of sight is only visible from an
    % element on the probe that sits < delta_max off-axis
    delta_max = GetProbeElementDirectivity(probe);
    tangent_max = tan(delta_max); % calculated only once for speed
    
    for radius_index = 1 : image_lower_limit_N
        radius = probe.c * radius_index / probe.fs / 2;
        width_han = radius * tangent_max;           % Half-width to consider for Hanning apodization at that depth, in [m]
        % And therefore, farthest element to consider:
        n_width_han = round(width_han / probe.pitch_x);  % Half-width to consider for Hanning at that depth, in element count
        el_max(radius_index) = min(n_width_han, probe.N_elements_x / 2 - 1);  % Max element-distance number to consider (one-sided); bound at N_elements_x / 2 - 1
        
        %% Radius 1 to 140
        if (radius_index < 140)
            % Square apodization window
            el_max_width(radius_index, :, :) = round((3 * radius_index) / 28) + 4;
            el_max_height(radius_index, :, :) = round((3 * radius_index) / 28) + 4;
            x_c(radius_index, :) = 51;
            y_c(radius_index, :) = 51;
        %% Radius 140 to 1500
        elseif (radius_index >= 140) && (radius_index < 1500)  % 1120
            radius_factor_w_h =  round(13 * radius_index / 140);
            radius_factor_x_y = round(3 * radius_index / 140);
            for elev_index = 1 : elevation_lines
                if elev_index > 37   %% The other side of phi
                    corrected_elev_index = 73 - elev_index + 1;
                else
                    corrected_elev_index = elev_index;
                end
                for azimuth_index = 1 : azimuth_lines
                    if azimuth_index > 37 %% The other side of theta
                        corrected_azimuth_index = 73 - azimuth_index + 1;
                    else
                        corrected_azimuth_index = azimuth_index;
                    end
                    if ((azimuth_index >= 1) && (azimuth_index <= 18)) || ((azimuth_index >= 56) && (azimuth_index <= 73))
                        if ((elev_index >= 1) && (elev_index <= 18)) || ((elev_index >= 56) && (elev_index <= 73))
                            if (with_square_apodization == 1)
                                el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h + 13;
                                el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h + 13;
                            else
                                el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((- corrected_azimuth_index + corrected_elev_index) / 3.5) + 13;
                                el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((corrected_azimuth_index - corrected_elev_index) / 3.5) + 13;
                            end
                        elseif ((elev_index >= 19) && (elev_index <= 37)) || ((elev_index >= 37) && (elev_index <= 55))
                            if (with_square_apodization == 1)
                                el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h + 19;
                                el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h;
                            else
                                el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((- corrected_azimuth_index - corrected_elev_index) / 3.5) + 19;
                                el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((corrected_azimuth_index + corrected_elev_index) / 3.5);
                            end
                        end
                    elseif ((azimuth_index >= 19) && (azimuth_index <= 37)) || ((azimuth_index >= 37) && (azimuth_index <= 55))
                        if ((elev_index >= 1) && (elev_index <= 18)) || ((elev_index >= 56) && (elev_index <= 73))
                            if (with_square_apodization == 1)
                                el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h;
                                el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h + 19;
                            else
                                el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((corrected_azimuth_index + corrected_elev_index) / 3.5);
                                el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((- corrected_azimuth_index - corrected_elev_index) / 3.5) + 19;
                            end
                        elseif ((elev_index >= 19) && (elev_index <= 37)) || ((elev_index >= 37) && (elev_index <= 55))
                            if (azimuth_index == elev_index) && (azimuth_index == 37)  % The central line-of-sight
                                % Extended aperture apod. (typical apodization) for the central line-of-sight
                                el_max_width(radius_index, elev_index, azimuth_index) = 2 + 2 * el_max(radius_index);
                                el_max_height(radius_index, elev_index, azimuth_index) = 2 + 2 * el_max(radius_index);
                            else
                                if (with_square_apodization == 1)
                                    el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h + 33 ;
                                    el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h + 33 ;
                                else
                                    el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((corrected_azimuth_index - corrected_elev_index) / 3.5) + 33;
                                    el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((-corrected_azimuth_index + corrected_elev_index) / 3.5) + 33;
                                end
                            end
                        end
                    end
                    %%To decrease width and height at broad angles:
%                     if (azimuth_index >= 1) && (azimuth_index <= 37) || (azimuth_index >= 37) && (azimuth_index <= 73)
%                         if (elev_index >= 1) && (elev_index <= 37) || (elev_index >= 37) && (elev_index <= 73)
%                             if (azimuth_index == elev_index) && (elev_index == 37)
%                                 el_max_width(radius_index, elev_index, azimuth_index) = el_max_width(radius_index, elev_index, azimuth_index);
%                                 el_max_height(radius_index, elev_index, azimuth_index) = el_max_height(radius_index, elev_index, azimuth_index);
%                             else
%                                 el_max_width(radius_index, elev_index, azimuth_index) = 0.5*el_max_width(radius_index, elev_index, azimuth_index);
%                                 el_max_height(radius_index, elev_index, azimuth_index) = 0.5*el_max_height(radius_index, elev_index, azimuth_index);
%                             end
%                         end
%                     end

                    if ((elev_index >= 1) && (elev_index <= 18)) || ((elev_index >= 56) && (elev_index <= 73))
                        if ((azimuth_index >= 1) && (azimuth_index <= 18)) || ((azimuth_index >= 56) && (azimuth_index <= 73))
                            el_max_width(radius_index, elev_index, azimuth_index) = 0.4*el_max_width(radius_index, elev_index, azimuth_index);
                            el_max_height(radius_index, elev_index, azimuth_index) = 0.4*el_max_height(radius_index, elev_index, azimuth_index);
                        end
                    end
                    if ((elev_index >= 19) && (elev_index <= 37)) || ((elev_index >= 37) && (elev_index <= 55))
                        if ((azimuth_index >= 19) && (azimuth_index <= 37)) || ((azimuth_index >= 37) && (azimuth_index <= 55))
                            if (azimuth_index == elev_index) && (azimuth_index == 37)  % The central line-of-sight
                                % Extended aperture apod. (typical apodization) for the central line-of-sight
                                el_max_width(radius_index, elev_index, azimuth_index) = el_max_width(radius_index, elev_index, azimuth_index);
                                el_max_height(radius_index, elev_index, azimuth_index) = el_max_height(radius_index, elev_index, azimuth_index);
                            else

                                el_max_width(radius_index, elev_index, azimuth_index) = 0.6*el_max_width(radius_index, elev_index, azimuth_index);
                                el_max_height(radius_index, elev_index, azimuth_index) = 0.6*el_max_height(radius_index, elev_index, azimuth_index);
                            end
                        end
                    end

                    if (radius_index < 415)
                        a = 0.7;

                    else
                        a = 0.5;

                    end
                    if ((azimuth_index >= 19) && (azimuth_index <= 37)) || ((azimuth_index >= 37) && (azimuth_index <= 55))
                        if ((elev_index >= 1) && (elev_index <= 8)) || ((elev_index >= 66) && (elev_index <= 73))

                            el_max_width(radius_index, elev_index, azimuth_index) = a*el_max_width(radius_index, elev_index, azimuth_index);
                            el_max_height(radius_index, elev_index, azimuth_index) = a*el_max_height(radius_index, elev_index, azimuth_index);

                        elseif ((elev_index >= 9) && (elev_index <= 18)) || ((elev_index >= 56) && (elev_index <= 65))
                            el_max_width(radius_index, elev_index, azimuth_index) = 0.7 * el_max_width(radius_index, elev_index, azimuth_index);
                            el_max_height(radius_index, elev_index, azimuth_index) = 0.7 * el_max_height(radius_index, elev_index, azimuth_index);
                        end
                    end
                    if ((elev_index >= 19) && (elev_index <= 37)) || ((elev_index >= 37) && (elev_index <= 73))
                        if ((azimuth_index >= 1) && (azimuth_index <= 8)) || ((azimuth_index >= 66) && (azimuth_index <= 73))
                            el_max_width(radius_index, elev_index, azimuth_index) = a*el_max_width(radius_index, elev_index, azimuth_index);
                            el_max_height(radius_index, elev_index, azimuth_index) = a*el_max_height(radius_index, elev_index, azimuth_index);

                        elseif ((azimuth_index >= 9) && (azimuth_index <= 18)) || ((azimuth_index >= 56) && (azimuth_index <= 65))
                            el_max_width(radius_index, elev_index, azimuth_index) = 0.7 * el_max_width(radius_index, elev_index, azimuth_index);
                            el_max_height(radius_index, elev_index, azimuth_index) = 0.7 * el_max_height(radius_index, elev_index, azimuth_index);
                        end

                    end

                    % Double check if there is any value of width and
                    % height exceeds the 100*100 elements probe
                    el_max_width(radius_index, elev_index, azimuth_index) = min(el_max_width(radius_index, elev_index, azimuth_index), 100);
                    el_max_height(radius_index, elev_index, azimuth_index) = min(el_max_height(radius_index, elev_index, azimuth_index), 100);

                    if (azimuth_index >= 1) && (azimuth_index <= 33)
                        x_c(radius_index, azimuth_index) = 49 - round(radius_factor_x_y/3) + round(azimuth_index / (3*3.5));
                    elseif (azimuth_index >= 34) && (azimuth_index <= 40)
                        x_c(radius_index, azimuth_index) = 51;
                    elseif (azimuth_index >= 41) && (azimuth_index <= 73)
                        x_c(radius_index, azimuth_index) = 100 - x_c(radius_index, corrected_azimuth_index);                        
                    end

                    if (elev_index >= 1) && (elev_index <= 33)
                        y_c(radius_index, elev_index) = 49 - round(radius_factor_x_y/3) + round(elev_index / (3*3.5));
                    elseif (elev_index >= 34) && (elev_index <= 40)
                        y_c(radius_index, elev_index) = 51;
                    elseif (elev_index >= 41) && (elev_index <= 73)
                        y_c(radius_index, elev_index) = 100 - y_c(radius_index, corrected_elev_index);                        
                    end
                end
            end
        %% Radius 1500 to 5000
        elseif (radius_index >= 1500) && (radius_index < 5000) 
            radius_factor_w_h =  100; %round(13 * radius_index / 140);
            radius_factor_x_y = round(3 * radius_index / 140);
            for elev_index = 1 : elevation_lines
                if elev_index > 37   %% The other side of phi
                    corrected_elev_index = 73 - elev_index + 1;
                else
                    corrected_elev_index = elev_index;
                end
                for azimuth_index = 1 : azimuth_lines
                    if azimuth_index > 37 %% The other side of theta
                        corrected_azimuth_index = 73 - azimuth_index + 1;
                    else
                        corrected_azimuth_index = azimuth_index;
                    end
                    if ((azimuth_index >= 1) && (azimuth_index <= 18)) || ((azimuth_index >= 56) && (azimuth_index <= 73))
                        if ((elev_index >= 1) && (elev_index <= 18)) || ((elev_index >= 56) && (elev_index <= 73))
                            if (with_square_apodization == 1)
                                el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h + 13;
                                el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h + 13;
                            else
                                el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((- corrected_azimuth_index + corrected_elev_index) / 3.5) + 13;
                                el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((corrected_azimuth_index - corrected_elev_index) / 3.5) + 13;
                            end
                        end
                    end
                    if ((azimuth_index >= 1) && (azimuth_index <= 5)) || ((azimuth_index >= 69) && (azimuth_index <= 73))
                        if ((elev_index >= 19) && (elev_index <= 37)) || ((elev_index >= 37) && (elev_index <= 55))
                            if (with_square_apodization == 1)
                                el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h + 19;
                                el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h;
                            else
                                el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((- corrected_azimuth_index - corrected_elev_index) / 3.5) + 19;
                                el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((corrected_azimuth_index + corrected_elev_index) / 3.5);
                            end
                        end
                    end
                    if ((azimuth_index >= 19) && (azimuth_index <= 37)) || ((azimuth_index >= 37) && (azimuth_index <= 55))
                       if ((elev_index >= 1) && (elev_index <= 5)) || ((elev_index >= 69) && (elev_index <= 73))
                            if (with_square_apodization == 1)
                                el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h;
                                el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h + 19;
                            else
                                el_max_width(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((corrected_azimuth_index + corrected_elev_index) / 3.5);
                                el_max_height(radius_index, elev_index, azimuth_index) = radius_factor_w_h + round((- corrected_azimuth_index - corrected_elev_index) / 3.5) + 19;
                            end
                       end
                    end
                    if ((azimuth_index >= 6) && (azimuth_index <= 37)) || ((azimuth_index >= 37) && (azimuth_index <= 68))
                        if ((elev_index >= 6) && (elev_index <= 37)) || ((elev_index >= 37) && (elev_index <= 68))
                            % when elevation index ranges from 6 to 68 along with having azimuth index ranges from 6 also to 68
                            % Extended aperture apod. (typical apodization) for the central line-of-sight
                            el_max_width(radius_index, elev_index, azimuth_index) = 2 + 2 * el_max(radius_index);
                            el_max_height(radius_index, elev_index, azimuth_index) = 2 + 2 * el_max(radius_index);
                        end
                    end
                    
%                     %%To decrease width and height at broad angles:
%                     if (azimuth_index >= 1) && (azimuth_index <= 27) || (azimuth_index >= 47) && (azimuth_index <= 73)
%                         if (elev_index >= 1) && (elev_index <= 27) || (elev_index >= 47) && (elev_index <= 73)
%                             el_max_width(radius_index, elev_index, azimuth_index) = 0.4*el_max_width(radius_index, elev_index, azimuth_index);
%                             el_max_height(radius_index, elev_index, azimuth_index) = 0.4*el_max_height(radius_index, elev_index, azimuth_index);
%                         end
%                     end


                    % Double check if there is any value of width and
                    % height exceeds the 100*100 elements probe
                    el_max_width(radius_index, elev_index, azimuth_index) = min(el_max_width(radius_index, elev_index, azimuth_index), 100);
                    el_max_height(radius_index, elev_index, azimuth_index) = min(el_max_height(radius_index, elev_index, azimuth_index), 100);


                         if ((azimuth_index >= 1) && (azimuth_index <= 8)) || ((azimuth_index >= 66) && (azimuth_index <= 73))
                            
                            el_max_width(radius_index, elev_index, azimuth_index) = 0.4*el_max_width(radius_index, elev_index, azimuth_index);
                            el_max_height(radius_index, elev_index, azimuth_index) = 0.4*el_max_height(radius_index, elev_index, azimuth_index);
                        
                        elseif ((elev_index >= 1) && (elev_index <= 8)) || ((elev_index >= 66) && (elev_index <= 73))
                            el_max_width(radius_index, elev_index, azimuth_index) = 0.4*el_max_width(radius_index, elev_index, azimuth_index);
                            el_max_height(radius_index, elev_index, azimuth_index) = 0.4*el_max_height(radius_index, elev_index, azimuth_index);
                        end
                        
                        if (radius_index < 2490)
                            if ((azimuth_index >= 9) && (azimuth_index <= 20)) || ((azimuth_index >= 54) && (azimuth_index <= 65))
                                
                                el_max_width(radius_index, elev_index, azimuth_index) = 0.6*el_max_width(radius_index, elev_index, azimuth_index);
                                el_max_height(radius_index, elev_index, azimuth_index) = 0.6*el_max_height(radius_index, elev_index, azimuth_index);
                            elseif ((elev_index >= 9) && (elev_index <= 20)) || ((elev_index >= 54) && (elev_index <= 65))
                                el_max_width(radius_index, elev_index, azimuth_index) = 0.6*el_max_width(radius_index, elev_index, azimuth_index);
                                el_max_height(radius_index, elev_index, azimuth_index) = 0.6*el_max_height(radius_index, elev_index, azimuth_index);
                              
                            end
                            
                        end 
                        
                    
                    if (azimuth_index >= 1) && (azimuth_index <= 33)
                        x_c(radius_index, azimuth_index) = 49 - round(radius_factor_x_y/3) + round(azimuth_index / (3*3.5));
                    elseif (azimuth_index >= 34) && (azimuth_index <= 40)
                        x_c(radius_index, azimuth_index) = 51;
                    elseif (azimuth_index >= 41) && (azimuth_index <= 73)
                        x_c(radius_index, azimuth_index) = 100 - x_c(radius_index, corrected_azimuth_index);                        
                    end

                    if (elev_index >= 1) && (elev_index <= 33)
                        y_c(radius_index, elev_index) = 49 - round(radius_factor_x_y/3) + round(elev_index / (3*3.5));
                    elseif (elev_index >= 34) && (elev_index <= 40)
                        y_c(radius_index, elev_index) = 51;
                    elseif (elev_index >= 41) && (elev_index <= 73)
                        y_c(radius_index, elev_index) = 100 - y_c(radius_index, corrected_elev_index);                        
                    end
                    if ((azimuth_index >= 6) && (azimuth_index <= 68)) && ((elev_index >= 6) && (elev_index <= 68))
                        x_c(radius_index, azimuth_index) = 51;
                        y_c(radius_index, elev_index) = 51;
                    end
                end
            end
        %% Radius 5000+
        else
            el_max_width(radius_index, :, :) = 100;
            el_max_height(radius_index, :, :) = 100;
            x_c(radius_index, :) = 51;
            y_c(radius_index, :) = 51;
        end
    end
    el_max_width = round(el_max_width);
    el_max_height = round(el_max_height);
    x_c = round(x_c);
    y_c = round(y_c);
end

