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
function [hdl_frame] = Compare2DImage(nappe_path, target_phantom, image, bf_im)

launch_folder = pwd;
cd(nappe_path);

% For a common case, tries to help the user by automatically inferring this
% input parameter. Just pass target_phantom = '' and it should still work.
if (strcmp(target_phantom, ''))
    dirnames = strsplit(nappe_path, '/'); %TODO won't work with \ slashes
    target_phantom = string(dirnames(end - 2));
end

for nappe_index = 1 : image.radial_lines
    filename = strcat(target_phantom, '_nappe_', num2str(nappe_index), '.txt');
    fID = fopen(filename, 'r');
    hdl_nappe_array = cell2mat(textscan(fID, '%f', -1))';
    hdl_frame(nappe_index, :) = hdl_nappe_array;
    fclose(fID);
end

figure('units', 'normalized', 'position', [0.1 0.2 0.8 0.6])
% TODO harmonize colorbar
subplot(1, 2, 1), imagesc(hdl_frame), title('HDL image'), colorbar, axis square;
subplot(1, 2, 2), imagesc(bf_im), title('Matlab image'), colorbar, axis square;

cd(launch_folder);

end
