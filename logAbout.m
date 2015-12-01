function [ out ] = logAbout( img )
%LOGABOUT perform logabout on image img
%   Detailed explanation goes here

    img = double(img);

     % high pass filter
filt = [-1 -1 -1;
            -1  10 -1;
            -1 -1 -1];
    img = imfilter(img, filt);
    img = max(img,0);
    img = img/255;
    % log image
    a = 1;
    b = 1/255;
    c = max(max(img));
    out = a + (log(img + 1) / (b * log(c)));
    out = uint8(out);
end

