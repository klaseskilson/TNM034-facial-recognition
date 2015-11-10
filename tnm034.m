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
    ycc = chromaTransformation(ycc);
    mask = skinModel(ycc);
    mask2 = chromasubtraction(ycc,.1); 
    eye = eyeMap(ycc);
    mouth = mouthMap(ycc);
    
    subplot(1,5,1) , subimage(img);
    subplot(1,5,2) , subimage(img.*uint8(mask2));
    subplot(1,5,3) , subimage(img.*uint8(mask));
    subplot(1,5,4) , subimage(eye.*uint8(mask(:,:,1)));
    subplot(1,5,5) , subimage(mouth.*uint8(mask(:,:,1)));

    
    id = 0;
end
