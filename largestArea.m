function [ out ] = largestArea( in )
%remove all smaller areas in a image and only keep the largest one
CC = bwconncomp(in);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
out = zeros(size(in));
out(CC.PixelIdxList{idx}) = in(CC.PixelIdxList{idx});
end

