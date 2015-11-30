function [ out ] = logAbout( img )
%LOGABOUT perform logabout on image img
%   Detailed explanation goes here
    
    img = double(img);
    % high pass filter
    filt = [-1 -1 -1;
            -1 9  -1;
            -1 -1 -1];
    img = imfilter(img, filt);
    img = normalize(img, 255);
    
    % log image
    a = 1;
    b = 1;
    c = 2;
    
    out = a + (log(img + 1) / (b * log(c)));
    out = normalize(out, 255);
   
end

