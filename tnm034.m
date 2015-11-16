% Find matching faces from predefined database
function id = tnm034(img)
%
% im: Image of unknown face, RGB-image in uint8 format in the range [0,255] 
%
% id: The identity number (integer) of the identified person, 
% i.e '1', '2',...,'16'for the persons belonging to 'db1' and '0' for all other
% faces.

    img = colorCorrect(img);
    ycc = rgb2ycbcr(img);
    yccorig = ycc;
    ycc = chromaTransformation(ycc);
    mask = skinModel(ycc);
    
    eye = eyeMap(yccorig);
    mouth = mouthMap(yccorig, mask);    
    
    eye = normalize(double(eye).*double(mask(:,:,1)), 255);
    eye = uint8(eye);

    [le,re, m] = faceTriangle(faceCrop(eye,mask), faceCrop(mouth,mask));
    cropped = faceCrop(img,mask);
    
    polygon = int32([m(1), m(2), le(1), le(2), re(1), re(2)]);
    J = insertShape(cropped, 'Polygon', polygon, 'Color', 'red', 'Opacity', 0.7);
    
    subplot(1,4,1) , subimage(J);
    subplot(1,4,2) , subimage(cropped);
    subplot(1,4,3) , subimage(eye > 230);
    subplot(1,4,4) , subimage(mouth > 150);
    
    id = 666;
end
