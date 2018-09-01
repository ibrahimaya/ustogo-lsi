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
function [bin] = dec2bin_frac(x, integer_part_size, fractional_part_size)
    % Sanity check - commented away for speed.
    %if (abs(x) > 2 ^ (integer_part_size - 1))
    %    disp('Error!');
    %end
        
    % Positive numbers are converted right away. If the number is negative,
    % add "2 ^ integer_part_size" first to make it positive, and convert
    % that number (2's complement)
    % Example: integer_part_size = 16 with a value of -1 -> -1 + 2^16 =
    % 65535 -> 1111111111111111, as intended
    if (x > - (2 ^ -(fractional_part_size + 1)))
        % Compare against this number instead of against 0.
        % This catches very tiny negative numbers which would not survive the
        % "+ 2 ^ integer_part_size" operation without loss of precision
        % and would return erroneous strings (e.g. 10000000000000000...)
        % Example: fractional_part_size = 2 -> resolution is 0.25
        % Catch anything between -0.125 and 0 and treat is as 0
        bin = dec2bin(round(x * (2 ^ fractional_part_size)), integer_part_size + fractional_part_size);
    else
        bin = dec2bin(round(2 ^ (integer_part_size + fractional_part_size) + x * (2 ^ fractional_part_size)), integer_part_size + fractional_part_size);
    end
end
