function [ id, all] = findFaceInDB( image, v, mean, weights )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    image = reshape(image, [1,128*84]);
    img = double(image)-mean;
    for j=1:40
        w =  img*v(:,j);
        val(j) = w;
    end    
    
    
    val = repmat(val,[16,1]);
    distance = sqrt(sum(weights-val,2).^2);
    
    [weight, idx] = sort(distance);
    
    id = idx(1);
    all =  idx;
    all(:,2) = weight;
end

