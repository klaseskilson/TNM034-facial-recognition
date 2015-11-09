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
    mask(:,:,2) = mask;
    mask(:,:,3) = mask(:,:,2);
    subplot(1,3,1) , subimage(img);
    subplot(1,3,2) , subimage(img.*uint8(mask));
    subplot(1,3,3) , subimage(ycc);
    
    id = 0;
end
