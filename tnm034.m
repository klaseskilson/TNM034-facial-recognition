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
    eye = normalize(double(eye).*double(mask(:,:,1)), 255);
    eye = uint8(eye);

    cropped = faceCrop(img,mask);
    mouth = mouthMap(yccorig, mask);
    mouth = normalize(mouth, 255);
    subplot(1,4,1) , subimage(img);
    subplot(1,4,2) , subimage(img.*uint8(mask));
    subplot(1,4,3) , subimage(cropped);
    subplot(1,4,4) , subimage(uint8((eye)+(mouth)).*uint8(mask(:,:,1)));
    
    id = 666;
end
