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
    mask = skinModel(ycc);
    
    % detect eyes and mouth
    eye = eyeMap(yccorig);
    mouth = mouthMap(yccorig, mask);    
    
    % apply face mask to eye map
    eye = normalize(double(eye).*double(mask(:,:,1)), 255);
    eye = uint8(eye);

    % crop image
    [le,re, m] = faceTriangle(faceCrop(eye,mask), faceCrop(mouth,mask));
    cropped = faceCrop(img,mask);
    
    % draw triangle on face
    polygon = int32([m(1), m(2), le(1), le(2), re(1), re(2)]);
    J = insertShape(cropped, 'Polygon', polygon, 'Color', 'red', 'Opacity', 0.7);
    
    % prepare for eigen faces
    croppedGray = rgb2gray(cropped);
    pcaCroppedGray = pca(croppedGray);
    
    % call global eigenDatabase
    eigenDatabase = createEigenDatabase('images/db1');
    
    % display debug images
    subplot(2,2,1) , subimage(J);
    subplot(2,2,2) , subimage(img .* uint8(mask));
    subplot(2,2,3) , subimage(eye > 230);
    subplot(2,2,4) , subimage(mouth > 150);
    
    id = 666;
end
