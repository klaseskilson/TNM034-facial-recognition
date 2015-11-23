% Find matching faces from predefined database
function id = tnm034(img)
%
% im: Image of unknown face, RGB-image in uint8 format in the range [0,255] 
%
% id: The identity number (integer) of the identified person, 
% i.e '1', '2',...,'16'for the persons belonging to 'db1' and '0' for all other
% faces.
    
    % adjust color and colorspace
    img = colorCorrect(img);
    ycc = rgb2ycbcr(img);
    yccorig = ycc;
    ycc = chromaTransformation(ycc);
    
    % detect skin
    skinModelThreshold = 1.5;
    
    mask = skinModel(ycc, skinModelThreshold);

    % detect eyes and mouth
    eye = eyeMap(yccorig);
    mouth = mouthMap(yccorig, mask);    
    
    % apply face mask to eye map
    eye = normalize(double(eye).*double(mask(:,:,1)), 255);
    eye = uint8(eye);

    % crop image
    numEyes = 0;
    numMouths = 0;
    eyeTresh = 230;
    mouthTresh= 120;
    while((numEyes < 2 && numMouths < 1) && (eyeTresh > 0 && mouthTresh > 0))
        [le,re, m, numEyes, numMouths] = faceTriangle(faceCrop(eye,mask), faceCrop(mouth,mask), eyeTresh, mouthTresh);
        if(numMouths < 1)
          mouthTresh = mouthTresh - 10;
        elseif(numEyes < 2)
          eyeTresh = eyeTresh - 10;
        end
    end
    if(eyeTresh == 0 || mouthTresh ==0)
        id = 0;
        imshow(img);
        return
    end
    cropped = faceCrop(img,mask);
    
    % warp faces to match eachother
    pts = [le, 1;
           re, 1;
           m, 1];
    alignedFace = alignFace(cropped, pts);
    
    
    % draw triangle on face
    polygon = int32([m(1), m(2), le(1), le(2), re(1), re(2)]);
    J = insertShape(cropped, 'FilledPolygon', polygon, 'Color', 'red', 'Opacity', 0.7);
    
    % prepare for eigen faces
    croppedGray = rgb2gray(cropped);
    pcaCroppedGray = pca(croppedGray);
    
    % call global eigenDatabase
    eigenDatabase = createEigenDatabase('images/db1');
    
    % display debug images
    subplot(2,2,1) , subimage(J);
    subplot(2,2,2) , subimage(alignedFace);
    croppedWEyes = cropped;
    croppedWEyes(:,:,1) = croppedWEyes(:,:,1) + uint8(faceCrop(eye > 230,mask)*255);
    subplot(2,2,3) , subimage(croppedWEyes);
    subplot(2,2,4) , subimage(mouth > mouthTresh);
    
    id = 666;
end
