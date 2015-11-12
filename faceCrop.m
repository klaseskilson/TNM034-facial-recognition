function [ cropped ] = faceCrop( image,mask )
% crop image to face mask
    vertical = any(mask(:,:,1), 2);
    horizontal = any(mask(:,:,1), 1);
    ymin = find(vertical, 1, 'first') % Y1
    ymax = find(vertical, 1, 'last') % Y2
    xmin = find(horizontal, 1, 'first') % X1
    xmax = find(horizontal, 1, 'last') % X2
    
    width = xmax-xmin;
    height = ymax-ymin;
    
    cropped = imcrop(image,[xmin ymin width height]);
end

