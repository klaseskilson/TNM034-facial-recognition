% Create face mask from YCC image
function [faceMask] = skinModel(transformedImage)
% facemask is the elliptical model for skin tones
% transformedImage is the chroma transformed image

theta = 2.53;
cx = 109.38;
cy = 152.02;
ecx = 1.6;
ecy = 2.41;

a = 25.39;
a2 = a*a;
b = 14.03;
b2 = b*b;

imgSize = size(transformedImage);
imgX = imgSize(1);
imgY = imgSize(2);
%equation 10
trans  = [ cos(theta) sin(theta);
          -sin(theta) cos(theta) ];
facemask = zeros(imgX,imgY);

for x=1:imgX
    for y=1:imgY
        value = [ double(transformedImage(x,y,2)) - cx;
                  double(transformedImage(x,y,3)) - cy ];
        pos = trans*value;
        %should be <= 1 here but its to narrow for good result
        faceMask(x,y) = ( ((pos(1) - ecx)^2 / a2 + (pos(2) - ecy)^2 / b2) <= 2);
    end
end

% morphological operations, double closing and one opening
diskSize = 10;
kernel = strel('disk', diskSize);
faceMask = imerode(imdilate(faceMask, kernel), kernel);
diskSize = 20;
kernel = strel('disk', diskSize);
faceMask = imerode(imdilate(faceMask, kernel), kernel);
diskSize = 4;
kernel = strel('disk', diskSize);
faceMask = imdilate(imerode(faceMask, kernel), kernel);
% fill in blanks of the objects
faceMask = imfill(faceMask,'holes');

% assume largest area is face and use only that using matlab magic
CC = bwconncomp(faceMask);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
out = zeros(size(faceMask));
out(CC.PixelIdxList{idx}) = faceMask(CC.PixelIdxList{idx});

faceMask = out;

faceMask(:,:,2) = faceMask;
faceMask(:,:,3) = faceMask(:,:,2);
