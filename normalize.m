function [ out ] = normalize(inp, top, bottom)
%NORMALIZE normalize input args
%   normalize(inp, top)
%   input  - the input value to normalize to [top..bottom]
%   top    - the wanted top value after normalization (default 1)
%   bottom - the wanted bottom value after normalization (default 0)
    % default values
    if nargin == 1
        top = 1;
        bottom = 0;
    elseif nargin == 2
        bottom = 0;
    end
    
    maxX = max(inp(:));
    minX = min(inp(:));
    
    % to [0..1]
    out = inp - minX;
    out = out / (maxX - minX);
    
    % to [bottom..top]
    out = bottom + out * (top - bottom);
end
