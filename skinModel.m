% Create face mask from YCC image
function [faceMask] = skinModel(transformedImage, threshold)
% facemask is the elliptical model for skin tones
% transformedImage is the chroma transformed image
% threshold value sets how strict the skin model should be to values
% in the image

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

imgCb(:,:) = double(transformedImage(:,:,2)) - cx;
imgCr(:,:) = double(transformedImage(:,:,3)) - cy;

posX = imgCb*cos(theta)+imgCr*sin(theta);
posY = imgCb*-sin(theta)+imgCr*cos(theta);

faceMask = ( ((posX - ecx).^2 ./ a2 + (posY - ecy).^2 ./ b2) <= threshold);


% morphological operations, closing, open, closing
diskSize = 20;
kernel = strel('disk', diskSize);
faceMask = imclose(faceMask, kernel);
diskSize = 4;
kernel = strel('disk', diskSize);
faceMask = imopen(faceMask, kernel);
diskSize = 25;
kernel = strel('disk', diskSize);
faceMask = imclose(faceMask, kernel);
% fill in blanks of the objects
faceMask = imfill(faceMask,'holes');

% assume largest area is face and use only that using matlab magic
if (sum(sum(faceMask)) == 0)
    faceMask = skinModel(transformedImage, threshold+.2);
    return
else
    faceMask = largestArea(faceMask);
    faceMask(:,:,2) = faceMask;
    faceMask(:,:,3) = faceMask(:,:,2);
end
