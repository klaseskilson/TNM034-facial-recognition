% Find matching faces from predefined database
function [id, result] = tnm034(img)
load database
% im: Image of unknown face, RGB-image in uint8 format in the range [0,255] 
%
% id: The identity number (integer) of the identified person, 
% i.e '1', '2',...,'16'for the persons belonging to 'db1' and '0' for all other
% faces.
 
    alignedFace = detectAndNormalize(img);
    faceSize = sum(sum(size(alignedFace)));
    numberOfVectors = 16;
    threshold = 300;
    % only continue if we find a face
    if(faceSize > 10)
        % call global eigenDatabase
        [id, result] = findFaceInDB(alignedFace, databaseEigenVectors, databaseMeanImage, faceWeights, numberOfVectors);
        w = result(1,2);
        if(w > threshold)
          id = 0;
        end
    else
        result = -1;
        id = 0; %FIXME: can we keep this as -1 for no face?
    end
    
end
