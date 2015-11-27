function [ transformedImage ] = alignFace( image, pts, height, width )
%alignFace alignfaces to match template image
% Good values

% 92%
% matching = [ width*0.25,  height*0.3, 1;
%              width*0.75, height*0.3, 1;
%              width*0.5, height*0.8, 1;];

% 92%
% matching = [ width*0.2,  height*0.2, 1;
%              width*0.7, height*0.2, 1;
%              width*0.5, height*0.8, 1;];

if nargin < 3
        height = 160;
        width = height*0.66;
    end

    matching = [ width*0.2,  height*0.2, 1;
                 width*0.7, height*0.2, 1;
                 width*0.5, height*0.8, 1;];

    Rcb = imref2d([height,uint32(width)]);
    transform = mldivide(pts,matching);
    transform(:,3) = [0; 0; 1];
    transform = affine2d(transform);
    transformedImage = imwarp(image,transform, 'OutputView', Rcb, 'SmoothEdges', true);
end

