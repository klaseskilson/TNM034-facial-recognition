% Principal component analysis
function [Eigenvector, eigenValues, meanImage] = pca(Img)
%   img - the image to analyse

    x = double(Img);
    meanImage = mean(x');
    x=bsxfun(@minus, x', mean(x'))'; 
    [E, D ,X ] = svd(x);
    eigenValues = diag(D).^2;
    eigenValues = eigenValues(1:16);
%   FIXME: should be based on nnumber of eig-vectors we want
    Eigenvector = E(:,1:16);
end