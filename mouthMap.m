function [mouthMap] = mouthMap(img)
   
    Cb = img(:,:,2);
    Cr = img(:,:,3);
    CrSquared = Cr.^2;
    CrCb = Cr./Cb;

    sumCrSquared = (1/sum(size(img)))*sum(sum(CrSquared));
    sumCrCb= (1/sum(size(img)))*sum(sum(CrCb));
    eta = 0.95 * sumCrSquared/sumCrCb;
    mouthMap = CrSquared.*((CrSquared-(eta.*CrCb)).^2);
    %diskSize = 2;
    %kernel = strel('disk', diskSize);
    %mouthMap = imdilate(mouthMap, kernel);
end