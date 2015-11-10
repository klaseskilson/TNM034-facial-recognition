function [ out ] = normalize(inp, top)
%NORMALIZE normalize input args
%   normalize(inp, top)
%   input - the input value to normalize
%   top   - the wanted top value after normalization (default 1)
    if nargin == 1
        top = 1;
    end
    out = top * inp / max(inp(:));
end
