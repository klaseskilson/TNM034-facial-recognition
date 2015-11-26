function [ id, all] = findFaceInDB( image, v, mean, weights )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [y,x] = size(image);
    image = reshape(image, [1,y*x]);
    img = double(image)-mean;
    for j=1:16
        vec = v(:,j);
        w =  v(:,j)'*img';
        val(j) = w;
    end    

    val = repmat(val,[16,1]);
    distance = abs(sum(val-weights,2));
    [weight, idx] = sort(distance);
    
    id = idx(1);
    all =  idx;
    all(:,2) = weight;
end

