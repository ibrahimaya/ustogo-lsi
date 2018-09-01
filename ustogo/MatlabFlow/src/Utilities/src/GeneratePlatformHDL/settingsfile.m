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
function [] = settingsfile(elevation_lines, azimuth_lines, radial_lines, N_elements_x, N_elements_y, probe, xz_sector, yz_sector, image_lower_limit_m, offset_min, offset_max, rf_depth, bram_samples_per_nappe)

% Parameters for the GUI
fID = fopen('settings.txt', 'w');
fprintf(fID, 'F0=%s\n', num2str(probe.f0 / 1000000, '%.2f'));       % In MHz, fractional
fprintf(fID, 'FS=%s\n', num2str(probe.fs / 1000000, '%.2f'));       % In MHz, fractional
fprintf(fID, 'C=%s\n', num2str(probe.c));                           % In m/s, integer
fprintf(fID, 'THETA=%s\n', num2str(round(rad2deg(xz_sector))));     % In deg, integer
fprintf(fID, 'PHI=%s\n', num2str(round(rad2deg(yz_sector))));       % In deg, integer
fprintf(fID, 'R=%s\n', num2str(image_lower_limit_m * 100, '%.2f')); % In cm, fractional
fprintf(fID, 'NX=%s\n', num2str(N_elements_x));
fprintf(fID, 'NY=%s\n', num2str(N_elements_y));
fprintf(fID, 'RADLIN=%s\n', num2str(radial_lines));                 % In focal points, integer
fprintf(fID, 'AZILIN=%s\n', num2str(azimuth_lines));                % In focal points, integer
fprintf(fID, 'ELELIN=%s\n', num2str(elevation_lines));              % In focal points, integer
fprintf(fID, 'RFD=%s\n', num2str(rf_depth));                        % In samples, integer
fprintf(fID, 'ZOFF=%s\n', num2str(offset_min(1)));                  % In samples, integer
fprintf(fID, 'SAMPLES=%s\n', num2str(bram_samples_per_nappe));      % In samples, integer
fclose(fID);

end
