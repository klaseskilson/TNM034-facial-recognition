% Find matching faces from predefined database
function id = tnm034(img)
load database
% im: Image of unknown face, RGB-image in uint8 format in the range [0,255] 
%
% id: The identity number (integer) of the identified person, 
% i.e '1', '2',...,'16'for the persons belonging to 'db1' and '0' for all other
% faces.
 
    alignedFace = detectAndNormalize(img);
    faceSize = sum(sum(size(alignedFace)));
    % only continue if we find a face
    if(faceSize > 10)    
        % prepare for eigen faces
        alignedGray = rgb2gray(alignedFace);
        % call global eigenDatabase
        id = findFaceInDB(alignedGray, databaseEigenVectors, databaseMeanImage, faceWeights);
    else
        id = -1;
    end
end
