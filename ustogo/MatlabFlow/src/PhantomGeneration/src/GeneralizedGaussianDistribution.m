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
function y = GeneralizedGaussianDistribution(x,param)

    flag = 0;
    if ~exist('x','var')
        N_elements = 192;
        x = linspace(1,N_elements,N_elements);
        flag = 1;
    else
        if (length(x) == 1)
            N_elements = x;
            x = linspace(1,N_elements,N_elements);
            
        end
    end
    if ~exist('param','var')
        param.alpha = 90;
        param.beta = 40; % 2  %40       
    end
    if ~isfield('param','mu')
        N_elements = length(x);
        param.mu = x(round(N_elements/2)); 
    end
    
    y = (param.beta/(2*param.alpha*gamma(1/param.beta))) * ...
        exp( -power(abs(x-param.mu)/param.alpha,param.beta) );
    y = y - min(y);
    y = y / max(y);
    
    if flag
       figure; plot(x,y,'-k','linewidth',2); 
    end
    
end
