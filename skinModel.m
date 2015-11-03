%%%%%%%%%%%%%%%%%%

function faceMask  = skinModel(transformedImage)
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

facemask = zeros(imgY, imgX);

for x=1:imgX
    for y=1:imgY
        value = [ transformedImage(y,x,2) - cx;
                  transformedImage(y,x,2) - cy ];
        pos = trans*value;
        faceMask(y,x) = ( (pos(1) - ecx)^2 / a2 + (pos(2) - ecy)^2 / b2 == 1);
    end
end
