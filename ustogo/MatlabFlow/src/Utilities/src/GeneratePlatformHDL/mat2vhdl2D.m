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
function [] = mat2vhdl2D(array, name)
% This function creates a .vhd file that declares a constant array of 
% unsigned fixed-point of 18 bit (14.4) and initializes this array with the
% values stored in a Matlab vector.
% INPUT: array: a column vector that holds the initial values.
% INPUT: name: the name of the constant array in vhdl code.

filename=strcat(name,'_constants.vhd');
fID=fopen(filename, 'w');
fprintf(fID, '');
fprintf(fID, 'library IEEE;\n');
fprintf(fID, 'use IEEE.NUMERIC_STD.ALL;\n\n');
fprintf(fID, '--Constants expressed in 14.4 signed FP representation\n');
fprintf(fID, 'package %s_constants is\n',name);
fprintf(fID, 'type %s_array_1 is array(0 to %d) of signed(17 downto 0);\n',name,size(array,2)-1);
fprintf(fID, 'type %s_array_2 is array(0 to %d) of %s_array_1;\n',name,size(array,1)-1,name);
fprintf(fID, 'constant %s:%s_array_2:=(\n',name,name);
for i = 1:size(array,1)-1
    fprintf(fID, '%d => (\n', i-1);
    for j=1:size(array,2)-1        
        bin = dec2bin_frac(array(i,j), 14, 4);
        fprintf(fID, '"%s",\n', bin);
    end
    j=size(array,2);
    bin = dec2bin_frac(array(i,j), 14, 4);
    fprintf(fID, '"%s"),\n', bin);
end
i=size(array,1);
fprintf(fID, '%d => (\n', i-1);
for j=1:size(array,2)-1        
    bin = dec2bin_frac(array(i,j), 14, 4);
    fprintf(fID, '"%s",\n', bin);
end
j=size(array,2);
bin = dec2bin_frac(array(i,j), 14, 4);
fprintf(fID, '"%s")\n', bin);

fprintf(fID, ');\n');

fprintf(fID, 'end %s_constants;\n',name);
fclose(fID);

end
