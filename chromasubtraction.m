function [ faceMask ] = chromasubtraction( YCbCrimage, threshold)
%CHROMASUBTRACTION Cb/Y - Cr/Y to extract skin color
%   Detailed explanation goes here

    Y = im2double(YCbCrimage(:,:,1));
    Cb = im2double(YCbCrimage(:,:,2));
    Cr = im2double(YCbCrimage(:,:,3));
     
    faceMask = (Cr./ Y - Cb ./Y) > threshold;
    faceMask(:,:,2) = faceMask;
    faceMask(:,:,3) = faceMask(:,:,2);

end

