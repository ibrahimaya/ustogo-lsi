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
function [ ] = vhdl_types_package(no_elements_x, no_elements_y, no_elev, no_lines, no_depth, excitation_peak_time)
%UNT?TLED Summary of this function goes here
%   Detailed explanation goes here
fID=fopen('types_pkg.vhd', 'w');

fprintf(fID, 'library IEEE;\n');
fprintf(fID, 'use IEEE.NUMERIC_STD.ALL;\n');

fprintf(fID, 'package types_pkg is\n');
fprintf(fID, '    constant    LATENCY :   integer :=  %i;\n', 13 + no_elements_y * no_elements_x);
fprintf(fID, '    constant    NO_PHI :   integer :=  %i;\n', no_elev);
fprintf(fID, '    constant    NO_THETA :   integer :=  %i;\n', no_lines);
fprintf(fID, '    constant    NO_DEPTH :   integer :=  %i;\n', no_depth);
fprintf(fID, '    constant    excitation_peak_time :   unsigned :=  "%s";\n', dec2bin_frac(excitation_peak_time, 18));
fprintf(fID, '    type    ref_delay_row   is  array(0 to %i) of unsigned(17 downto 0);\n', no_elements_x - 1);
fprintf(fID, '    type    ref_delay_matrix is  array(0 to %i) of ref_delay_row;\n', no_elements_y - 1);
fprintf(fID, '    type    delay_row   is  array(0 to %i) of unsigned(13 downto 0);\n', no_elements_x - 1);
fprintf(fID, '    type    delay_matrix   is  array(0 to %i) of delay_row;\n', no_elements_y - 1);
fprintf(fID, 'end types_pkg;\n');

fclose(fID);
end

%THIS FUNCTION ALWAYS TAKES POSITIVE VALUES
function [bin] = dec2bin_frac(x,length)
word_size=length/18;
int_part = floor(x);
frac_part = x - int_part;
bin = strcat(dec2bin(int_part,14*word_size),dec2bin(floor(frac_part*2^(4*word_size)),4*word_size));
end
