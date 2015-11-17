% Principal component analysis
function [eigenVector, meanImg] = pca(Img)
%   img - the image to analyse

    [w, h] = size(Img);
    meanImg = mean(Img(:));
    %Repmat function returns a repeated copy of the array.
    Xm = double(Img) - repmat(meanImg, w, h);

    if(w > h)
        S = Xm'*Xm;
        %Retrieve Eigen Values
        [eigenVector, D] = eig(S);
    else
        S = Xm*Xm';
        [eigenVector, D] = eig(S);
        eigenVector = Xm'*eigenVector;
        D = normalize(D, 255);
    end

    %Sort Eigenvalues
    [D, i] = sort(diag(D), 'descend');
    eigenVector = eigenVector(:,i);
end