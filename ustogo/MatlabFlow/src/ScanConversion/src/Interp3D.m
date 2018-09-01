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
%% Interpolation function for 3D volumetric images, allowing for scan
%% conversion of the input data. Mostly equivalent to Matlab's interp3().
%
% Inputs: input_image - Starting image, defined on a fully populated grid
%                       of points in the input coordinates.
%         Xq, Yq, Zq - Matrices describing the geometric transformation
%                      from input to output image; the matrices must have
%                      the same dimensions, and define the dimension of the
%                      output image too. Each matrix's location describes
%                      an output image point, and its value defines the
%                      corresponding coordinates in the input image.
%         extrapval - Value given to output image points that lie outside
%                     the input volume.
%
% Outputs: output_image - Transformed image.

function [output_image] = Interp3D(input_image, Xq, Yq, Zq, extrapval)

    [old_x, old_y, old_z] = size(input_image);
    [new_x, new_y, new_z] = size(Xq);
    [a, b, c] = size(Yq);
    [d, e, f] = size(Zq);
    if (new_x ~= a || new_x ~= d || new_y ~= b || new_y ~= e || new_z ~= c || new_z ~= f)
        error('The X, Y, Z matrices must all have the same dimensions.')
    end
    output_image = zeros(new_x, new_y, new_z);
    
    for new_z_index = 1 : new_z
        for new_y_index = 1 : new_y
            for new_x_index = 1 : new_x
                old_x_location = Xq(new_x_index, new_y_index, new_z_index);
                old_y_location = Yq(new_x_index, new_y_index, new_z_index);
                old_z_location = Zq(new_x_index, new_y_index, new_z_index);
                
                if (old_x_location >= old_x || old_y_location >= old_y || old_z_location >= old_z || old_x_location < 1 || old_y_location < 1 || old_z_location < 1)
                    output_image(new_x_index, new_y_index, new_z_index) = extrapval;
                else
                    old_x_index = floor(old_x_location);
                    old_y_index = floor(old_y_location);
                    old_z_index = floor(old_z_location);
                    
                    % Get the eight nearest points to (x, y, z) with wrap-around
                    c000 = input_image(old_x_index, old_y_index, old_z_index);
                    c100 = input_image(old_x_index + 1, old_y_index, old_z_index);
                    c010 = input_image(old_x_index, old_y_index + 1, old_z_index);
                    c110 = input_image(old_x_index + 1, old_y_index + 1, old_z_index);
                    
                    c001 = input_image(old_x_index, old_y_index, old_z_index + 1);
                    c101 = input_image(old_x_index + 1, old_y_index, old_z_index + 1);
                    c011 = input_image(old_x_index, old_y_index + 1, old_z_index + 1);
                    c111 = input_image(old_x_index + 1, old_y_index + 1, old_z_index + 1);
                    
                    % Interpolate over them
                    interpval = trilinearInterpolation(c000, c100, c010, c110, c001, ...
                        c101, c011, c111, old_x_location - old_x_index, old_y_location - old_y_index, old_z_location - old_z_index);
                    
                    output_image(new_x_index, new_y_index, new_z_index) = interpval;
                end
            end
        end
    end
end

% Interpolates start & end values to find the value of a point at start+distance.
% (The distance of the points that start & end values correspond is always 1.
% Thus that division is omitted from the calculation.)
function [interp] = linearInterpolation(start, finish, distance)
	interp = start + (finish - start) * distance;
end

% Interpolate the values of four points, using the bilinear interpolation, to find the value of
% the point that is at (tx,tv) from the top-left point (which has value c00)
function [interp] = bilinearInterpolation(c00, c10, c01, c11, tx, ty)
	interp = linearInterpolation(linearInterpolation(c00, c10, tx), ...
			 linearInterpolation(c01, c11, tx), ty);
end

% Interpolate the values of four points, using the bilinear interpolation, to find the value of
% the point that is at (tx,tv,tz) from the top-left point (which has value c000). The points are
% described as cXYZ with each of X,Y,Z value of 1 means that we have moved down that axis.
% e.g ( c001 is the top-left-far and c111 is the top-right-far one).
function [interp] = trilinearInterpolation(c000, c100, c010, c110, c001, c101, c011, c111, tx, ty, tz)
    interp = linearInterpolation( ...
                linearInterpolation( ...
					linearInterpolation(c000, c100, tx), ...
					linearInterpolation(c010, c110, tx), ...
					ty), ...
					linearInterpolation( ...
							linearInterpolation(c001, c101, tx), ...
							linearInterpolation(c011, c111, tx), ...
							ty), ...
							tz);
end
