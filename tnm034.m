% Find matching faces from predefined database
function id = tnm034(img)
%
% im: Image of unknown face, RGB-image in uint8 format in the range [0,255] 
%
% id: The identity number (integer) of the identified person, 
% i.e '1', '2',...,'16'for the persons belonging to 'db1' and '0' for all other
% faces.

    ycc = rgb2ycbcr(img);
    ycc = chromaTransformation(ycc);
    mask = skinModel(ycc);
    imshow(mask)
    
    id = 0;
end
