function [ leftEye, rightEye, mouthPos] = faceTriangle(eye, mouth)
%faceTriangle extract three points to form a triangle from eye and mouth map

mouth = mouth>120;
eye = eye > 230;
diskSize = 8;
kernel = strel('disk', diskSize);
eye = imdilate(eye, kernel);
stats = regionprops('table',mouth, 'Centroid', 'BoundingBox');
mouthsDetected = size(stats.BoundingBox, 1);
j = 1;
for i=1:mouthsDetected
  % if the region is twice as wide than its height, its a potential mouth
  if(stats.BoundingBox(i,3)/stats.BoundingBox(i,4) > 1.5)
      potentialMouths(j, :) = stats.Centroid(i,:);
      j = j+1;
  end
end

stats = regionprops('table',eye,'Centroid',...
 'MajorAxisLength','MinorAxisLength');

eyesDetected = size(stats.Centroid,1);
mouthCount = size(potentialMouths, 1);
%potential combinations counter
pc = 1;
for i=1:eyesDetected
    for j=i+1:eyesDetected
        for k=1:mouthCount
            % potential mouth
            pm = potentialMouths(k, :);
            % potential left eye, PLE, potential right eye PRE
            firstEye = stats.Centroid(i,:);
            secondEye = stats.Centroid(j,:);
            if(firstEye(1) < secondEye(1))
              ple = firstEye;
              pre = secondEye;
            else
              ple = secondEye;
              pre = firstEye;
            end
            if ple(2) > pm(2) | pre(2) > pm(2)
                'eye below mouth'
                continue
            end
            %First score: lower difference in Y is good
            eyeYDiff = 1-(1/(1+abs(pre(2)-ple(2))));
            
            %Second score: lower difference in eye to mouth is good
            preDist = pdist(cat(1,pre, pm), 'euclidean');
            pleDist = pdist(cat(1,ple, pm), 'euclidean');
            
            eyeMouthDiff= 1-1/(1+abs(preDist-pleDist));
            
            potentialComb(pc, :) = cat(2, ple,pre,pm, eyeYDiff+eyeMouthDiff);
            pc = pc + 1; 
        end
    end
end
sortedComb = sortrows(potentialComb,7);

leftEye = sortedComb(1,1:2);
rightEye = sortedComb(1,3:4);
mouthPos = sortedComb(1,5:6);


end
 
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
