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
function [] = mat2vhdl(array, name, length, frac, type)
% This function creates a .vhd file that declares a constant array of
% unsigned fixed-point and initializes this array with the
% values stored in a Matlab vector.
% INPUT: array: a column vector that holds the initial values.
% INPUT: name: the name of the constant array in vhdl code.
% INPUT: length: the length of the data in bits.
% INPUT: frac: the length of the fractional part in bits.
% INPUT: type: the type of the data.

filename=strcat(name,'_constants.vhd');
fID=fopen(filename, 'w');
fprintf(fID, '');
fprintf(fID, 'library IEEE;\n');
fprintf(fID, 'use IEEE.NUMERIC_STD.ALL;\n');
fprintf(fID, 'use IEEE.STD_LOGIC_1164.ALL;\n\n');
fprintf(fID, '--Constants expressed in %d.%d signed FP representation\n', length - frac, frac);
fprintf(fID, 'package %s_constants is\n',name);
fprintf(fID, 'type %s_array is array(0 to %d) of %s(%d downto 0);\n',name,size(array,1)-1,type,length-1);
fprintf(fID, 'constant %s:%s_array:=(\n',name,name);
for i = 1:size(array,1)-1
    bin = dec2bin_frac(array(i,1), length - frac, frac);
    fprintf(fID, '"%s",\n', bin);
end
i=size(array,1);
bin = dec2bin_frac(array(i,1), length - frac, frac);
fprintf(fID, '"%s");\n', bin);
fprintf(fID, 'end %s_constants;\n',name);
fclose(fID);

end
