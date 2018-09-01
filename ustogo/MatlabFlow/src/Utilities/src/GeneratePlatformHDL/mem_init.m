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
function [] = mem_init(array, filename, pad, integer_part_size, fractional_part_size)
    fID = fopen(filename, 'w');
    
    % Preallocate enough space for 2 ^ pad lines, each (integer_part_size +
    % fractional_part_size + 1) chars long (newline at the end)
    line_length = integer_part_size + fractional_part_size + 1;
    newline = char(10);
    lines = char(zeros(1, line_length * (2 ^ pad)));
    
    for i = 1 : size(array, 1)
        lines(1, (i - 1) * line_length + 1 : i * line_length) = char([dec2bin_frac(array(i, 1), integer_part_size, fractional_part_size), newline]);
    end

    % If the file needs to have extra empty rows (as indicated by "pad":
    % for example, pad == 13 -> 8192 rows) then add them
    for i = size(array, 1) + 1 : 2 ^ pad
        lines(1, (i - 1) * line_length + 1 : i * line_length) = char([dec2bin_frac(0, integer_part_size, fractional_part_size), newline]);
    end

    fprintf(fID, '%s', lines);

    fclose(fID);
end
