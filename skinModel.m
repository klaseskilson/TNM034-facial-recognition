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

faceMask(:,:,2) = faceMask;
faceMask(:,:,3) = faceMask(:,:,2);