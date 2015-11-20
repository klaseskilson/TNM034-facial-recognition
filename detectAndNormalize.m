function [ cropped ] = detectAndNormalize( img )
%DETECTANDNORMALIZE Detect face features and normalize and crop RGB image img

    % adjust color and colorspace
    img = colorCorrect(img);
    ycc = rgb2ycbcr(img);
    yccorig = ycc;
    ycc = chromaTransformation(ycc);
    
    % detect skin
    skinModelThreshold = 1.5;
    mask = skinModel(ycc, skinModelThreshold);

    % detect eyes and mouth
    eye = eyeMap(yccorig);
    mouth = mouthMap(yccorig, mask);    
    
    % apply face mask to eye map
    eye = normalize(double(eye).*double(mask(:,:,1)), 255);
    eye = uint8(eye);

    % crop image
    [le,re, m] = faceTriangle(faceCrop(eye,mask), faceCrop(mouth,mask));
    cropped = faceCrop(img,mask);
end

