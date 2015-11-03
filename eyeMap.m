%Assuming that img is an image which has been converted to YCBCR-colors
function [eyeMap] = eyeMap(img)
    Y = img(:,:,1);
    Cb = img(:,:,2);
    Cr = img(:,:,3);

    %According to formula 1 in "Face Detection in Color Images"
    eyeMapC =  ((Cb.^2+((255-Cr).^2)) + (Cb./Cr));
    
    %Requires Image Processing Toolbox.
    %Creates a Morphological structuring element, namely a disk which
    %we can use for erision/dilation. 4 is the radius.
    SE = strl('disk', 4);
    NOMINATOR = imdilate(Y, SE);
    DENOMINATOR = imerode(Y, SE);
    eyeMapL = NOMINATOR./(DENOMINATOR+1);
    
    %Return value
    eyeMap = eyeMapC.*eyeMapL;
    
end