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
function [] = c2_names(no_elev)
fID=fopen('c2_filenames.vhd', 'w');
fprintf(fID, '');
fprintf(fID, 'library IEEE;\n');
fprintf(fID, 'use WORK.types_pkg.all;\n');
fprintf(fID, 'package c2_filenames is\n');
fprintf(fID, 'type c2_str_array is array(0 to %s) of string(1 to 17);\n', num2str(no_elev - 1));
fprintf(fID, 'constant c2_filename:c2_str_array:=(\n');
for i = 1:no_elev-1
    if i<10
        fprintf(fID, '"mem_init_000%s.txt",\n', num2str(i));
    elseif i<100
        fprintf(fID, '"mem_init_00%s.txt",\n', num2str(i));
    else
        fprintf(fID, '"mem_init_0%s.txt",\n', num2str(i));
    end
end
if no_elev<10
    fprintf(fID, '"mem_init_000%s.txt");\n', num2str(no_elev));
elseif no_elev<100
    fprintf(fID, '"mem_init_00%s.txt");\n', num2str(no_elev));
else
    fprintf(fID, '"mem_init_0%s.txt");\n', num2str(no_elev));
end
fprintf(fID, 'end c2_filenames;\n');
fclose(fID);
end

