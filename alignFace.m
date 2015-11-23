function [ transformedImage ] = alignFace( image, pts )
%alignFace alignfaces to match template image

height = 256;
width = height*0.66;


matching = [ width*0.25,  height*0.4, 1;
             width*0.75, height*0.4, 1;
             width*0.5, height*0.8, 1;];

Rcb = imref2d([height,uint32(width)])
transform = mldivide(pts,matching);
transform(:,3) = [0; 0; 1];
transform = affine2d(transform);
transformedImage = imwarp(image,transform, 'OutputView', Rcb);



end

