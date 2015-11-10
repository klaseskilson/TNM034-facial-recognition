% Mouth map YCC img
function [mouthMap] = mouthMap(img, faceMask)
   
    Cb = im2double(img(:,:,2));
    Cr = im2double(img(:,:,3));
    mask = double(faceMask(:,:,1));
    CrSquared = Cr.^2;
    CrCb = (Cr./Cb);

    CrSquared = normalize(CrSquared, 255);
    CrCb = normalize(CrCb, 255);
    
    eta = 0.95 * mean(mean(CrSquared))/mean(mean(CrCb));
    
    mouthMap = CrSquared.*((CrSquared -(eta.*CrCb)).^2);
    mouthMap = uint8(255*mouthMap/max(max(mouthMap)));

    diskSize = 10;
    kernel = strel('disk', diskSize);
    mouthMap = imerode(imdilate(mouthMap, kernel), kernel);

end