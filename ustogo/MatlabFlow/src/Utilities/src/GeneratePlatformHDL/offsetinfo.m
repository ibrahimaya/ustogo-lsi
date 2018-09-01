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
function [] = offsetinfo(starting_offset_list)

bases = size(starting_offset_list, 1);

% Parameters for the ScanConverterIP
fID = fopen('offset_info.v', 'w');
fprintf(fID, '// How many refills of data from the Microblaze, and at what offsets their base is\n');
fprintf(fID, '`define OFFSET_BASES %s\n', num2str(bases));
fprintf(fID, 'reg signed [31 : 0] non_streaming_offset_bases[`OFFSET_BASES - 1 : 0] = {');
for loop = 1 : bases
    fprintf(fID, '32''sd%s', num2str(starting_offset_list(end + 1 - loop)));
    if (loop < bases)
        fprintf(fID, ', ');
    else
        fprintf(fID, '};');
    end
end
fclose(fID);

end
