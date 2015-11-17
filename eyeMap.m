%Assuming that img is an image which has been converted to YCBCR-colors
function [eyeMap] = eyeMap(img)
   
    Y = im2double(img(:,:,1));
    Cb = im2double(img(:,:,2));
    Cr = im2double(img(:,:,3));
 

    Cbsqr = normalize(Cb.^2, 255);
    CbNegsqr = normalize(255-(Cr.^2), 255);
    % CbNegsqr = 255*CbNegsqr/max(max(CbNegsqr));
    CbCr = normalize(Cb./Cr, 255);
    % CbCr = 255*CbCr/max(max(CbCr));
    
    %According to formula 1 in "Face Detection in Color Images"
    eyeMapC =  (1/3) * (Cbsqr+CbNegsqr +CbCr);
    
    %Requires Image Processing Toolbox.
    %Creates a Morphological structuring element, namely a disk which
    %we can use for erision/dilation. 4 is the radius.diskSize = 10;
    diskSize = 8;
    kernel = strel('disk', diskSize);
    NOMINATOR = imdilate(Y, kernel);
    DENOMINATOR = imerode(Y, kernel);
    eyeMapL = NOMINATOR./(DENOMINATOR+1);
    
    %Return value
    eyeMap = eyeMapL.*eyeMapC;
    
end