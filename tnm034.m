% Find matching faces from predefined database
function id = tnm034(img)
%
% im: Image of unknown face, RGB-image in uint8 format in the range [0,255] 
%
% id: The identity number (integer) of the identified person, 
% i.e '1', '2',...,'16'for the persons belonging to 'db1' and '0' for all other
% faces.
 
    alignedFace = detectAndNormalize(img);
    
    
    % prepare for eigen faces
    alignedGray = rgb2gray(alignedFace);
    pcaImg = pca(alignedGray, 43);
    
    % call global eigenDatabase
    eigenDatabase = createEigenDatabase('images/db1');
    
    for i=1:size(eigenDatabase, 3)
        eigenIm = eigenDatabase(:, :, i) - pcaImg;
        eigenRes(i) = abs(sum(eigenIm(:)));
    end
    
    [eigenRes, idx] = sort(eigenRes)
    % retuuurn found id!
    id = idx(1);
    
    % draw triangle on face
%     polygon = int32([m(1), m(2), le(1), le(2), re(1), re(2)]);
%     J = insertShape(cropped, 'FilledPolygon', polygon, 'Color', 'red', 'Opacity', 0.7);
    
    
    % display debug images
    subplot(2,2,1) , subimage(img);
    subplot(2,2,2) , subimage(alignedFace);
%     subplot(2,2,4) , subimage(eye);
%     suxsbplot(2,2,4) , subimage(mouth);
end
