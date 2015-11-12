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
    eye = uint8(eye);
    eye = normalize(eye,255);
    faceTriangle(eye, mouth);
    
    eye = faceCrop(eye,mask);
    cropped = faceCrop(img,mask);
    mouth = faceCrop(mouth,mask);
    subplot(1,4,1) , subimage(img);
    subplot(1,4,2) , subimage(cropped);
    subplot(1,4,3) , subimage(eye > 170);
    subplot(1,4,4) , subimage(mouth);
    
    id = 666;
end
