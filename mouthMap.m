function [mouthMap] = mouthMap(img)
    %Mouthmap implemented as in: http://www.idosi.org/wasj/wasj13(4)/30.pdf
    r = img(:,:,1);
    g = img(:,:,2);
    
    r = r/255;
    g = g/255;
    mouthMap = (r./(r+g)).^2
    
    %Cr = img(:,:,3);
    %Cb = img(:,:,2);
    %NOMINATOR = ((Cr.^2)./size(img));
    %DENOMINATOR = 0;
    %eta = 0.95 * (NOMINATOR./DENOMINATOR);
    %mouthMap = 0;
end