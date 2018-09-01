% function [out]=LogComp(in,top_hinge,max_pix,dyn_range);
% Log Compression function 
% (c) 2015 Marcel Arditi

function [out]=LogComp(in,top_hinge,max_pix,dyn_range);
out=max(0,max_pix*(1+(20/dyn_range*log10(max(1e-30,in/top_hinge)))));
out=min(out,max_pix);
end
