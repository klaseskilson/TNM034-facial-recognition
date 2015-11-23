function [ aligned ] = detectAndNormalize( img )
%DETECTANDNORMALIZE Detect face features and normalize and crop RGB image img

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
    while((numEyes < 2 || numMouths < 1) && (eyeTresh > 0 && mouthTresh > 0))
        [le,re, m, numEyes, numMouths] = faceTriangle(faceCrop(eye,mask), faceCrop(mouth,mask), eyeTresh, mouthTresh);
        if(numMouths < 1)
          mouthTresh = mouthTresh - 10;
        end
        if(numEyes < 2)
          eyeTresh = eyeTresh - 10;
        end
    end
    if(eyeTresh == 0 || mouthTresh ==0 || sum(le+re+m) == 0)
        id = 0;
        return
    end
    cropped = faceCrop(img,mask);
    
    % warp faces to match eachother
    pts = [le, 1;
           re, 1;
           m, 1];
    aligned = alignFace(cropped, pts);
end

