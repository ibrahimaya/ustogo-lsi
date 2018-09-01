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
function [] = parameters(elevation_lines, azimuth_lines, radial_lines, N_elements_x, N_elements_y, lowpass_filter_depth, adc_precision, apodization_precision, lp_precision, log_samples_depth, bram_samples_per_nappe, azimuth_zones, elevation_zones, compound_count, compound_not_zone, path, target_phantom, offset_min, offset_max, rf_depth)

% Parameters for the BeamformerIP
fID = fopen('parameters.v', 'w');
fprintf(fID, '// These parameters are used by the beamformer and by the testbench\n');
fprintf(fID, '`define TRANSDUCER_ELEMENTS_X %s\n', num2str(N_elements_x));
fprintf(fID, '`define TRANSDUCER_ELEMENTS_Y %s\n', num2str(N_elements_y));
fprintf(fID, '`define FILTER_DEPTH %s\n', num2str(lowpass_filter_depth));
fprintf(fID, '`define ELEVATION_LINES %s\n', num2str(elevation_lines));
fprintf(fID, '`define AZIMUTH_LINES %s\n', num2str(azimuth_lines));
fprintf(fID, '`define RADIAL_LINES %s\n', num2str(radial_lines));
fprintf(fID, '`define ADC_PRECISION %s\n', num2str(adc_precision));
fprintf(fID, '`define APODIZATION_PRECISION %s\n', num2str(apodization_precision));
fprintf(fID, '`define LP_PRECISION %s\n', num2str(lp_precision));
fprintf(fID, '`define LOG_SAMPLES_DEPTH %s\n', num2str(log_samples_depth));
fprintf(fID, '`define BRAM_SAMPLES_PER_NAPPE %s\n', num2str(bram_samples_per_nappe));
if (elevation_lines == 1)
    fprintf(fID, '`define IMAGING2D\n');
    fprintf(fID, '`define WITH_ILAS\n');
else
    fprintf(fID, '//`define IMAGING2D\n');
    fprintf(fID, '//`define WITH_ILAS\n');
end
fprintf(fID, '\n');
fprintf(fID, '// These parameters are meant to be used exclusively by the testbench\n');
fprintf(fID, '`define SIM_PATH "%s"\n', path);
fprintf(fID, '`define COMPOUND_NOT_ZONE %s\n', num2str(compound_not_zone));
fprintf(fID, '`define AZIMUTH_ZONES %s\n', num2str(azimuth_zones));
fprintf(fID, '`define ELEVATION_ZONES %s\n', num2str(elevation_zones));
fprintf(fID, '`define COMPOUND_COUNT %s\n', num2str(compound_count));
fprintf(fID, '`define BENCHMARK "%s"\n', target_phantom);
fprintf(fID, '`define RF_DEPTH %s\n', num2str(rf_depth));
fprintf(fID, '`define ZERO_OFFSET %s\n', num2str(offset_min(1)));
fclose(fID);

end
