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
function [used, used_size, ref_matrix] = ComputeUsedWindows(el_max_height, el_max_width)

    ref_matrix = zeros(100, 100);
    for i = 1 : size(el_max_height, 2)
        for j = 1 : size(el_max_height, 3)
            for k = 1 : size(el_max_height, 1)
                h = el_max_height(k, i, j);
                w = el_max_width(k, i, j);
                ref_matrix(round(max(h, w)), round(min(h, w))) = 1;
            end
        end
    end

    used = size(find(ref_matrix), 1);
    
    [ind_1, ind_2] = ind2sub(size(ref_matrix), find(ref_matrix));
    
    used_size = 0;
    for counter = 1 : size(ind_1, 1)
        used_size = used_size + ind_1(counter) * ind_2(counter);
    end
    % In Mb
    used_size = used_size * 16 / 1024 / 1024; % Assuming a representation precision of 16 bits

    message = ['This apodization requires the storage of ', num2str(used), ' apodization windows for a minimum required size (compact storage) of ', num2str(used_size), 'Mb'];
    disp(message);
    
end
