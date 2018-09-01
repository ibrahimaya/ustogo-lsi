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
function [] = sc_parameters(elevation_lines, azimuth_lines, radial_lines, path, target_phantom)

% Parameters for the ScanConverterIP
fID = fopen('sc_parameters.v', 'w');
fprintf(fID, '// These parameters are used by the scan converter and by the testbench\n');
fprintf(fID, '\n');
fprintf(fID, '// These parameters are meant to be used exclusively by the testbench\n');
fprintf(fID, '`define SC_ELEVATION_LINES %s\n', num2str(elevation_lines));
fprintf(fID, '`define SC_AZIMUTH_LINES %s\n', num2str(azimuth_lines));
fprintf(fID, '`define SC_RADIAL_LINES %s\n', num2str(radial_lines));
fprintf(fID, '`define SIM_PATH "%s"\n', path);
fprintf(fID, '`define BENCHMARK "%s"\n', target_phantom);
fclose(fID);

end
