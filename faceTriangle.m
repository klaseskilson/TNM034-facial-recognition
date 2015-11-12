function [ leftEye, rightEye, mouthPos] = faceTriangle(eye, mouth)
%faceTriangle extract three points to form a triangle from eye and mouth map

leftEye = 0;
rightEye = 0;
mouthPos = 0;
whos mouth
mouth = mouth>180;
regionprops('table',mouth, 'Centroid', 'BoundingBox')
% stats = regionprops('table',mouth,'Centroid',...
% 'MajorAxisLength','MinorAxisLength');

end

% stats = regionprops('table',eye >= (max(max(eye))-20),'Centroid',...
% 'MajorAxisLength','MinorAxisLength');
% 
% 
% 
% 
% centers = stats.Centroid;
% props = stats.MinorAxisLength./stats.MajorAxisLength;
% faceTriangle = zeros(size(eye));
% len = size(centers,1)
% for c =1:len
%     center = uint8(centers(c,:))
%     prop = props(c)
%         faceTriangle(center(2),center(1)) = 1;
% end
% 
% diskSize = 8;
% kernel = strel('disk', diskSize);
% faceTriangle = imdilate(faceTriangle, kernel);
% 
% 
% 
% 
% end
% 
