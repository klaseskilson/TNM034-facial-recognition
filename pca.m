% Principal component analysis
function [Eigenvector, meanImg] = pca(Img, k)
%   img - the image to analyse
%   k   - number of components to return

    if nargin < 2 
        k = 10
    end

    [w, h] = size(Img);
    meanImg = meanImage('images/db1');
    % Repmat function returns a repeated copy of the matrix
    Xm = double(Img) - meanImg;

    if(w > h)
        S = Xm'*Xm;
        %Retrieve Eigen Values
        [Eigenvector, D] = eig(S);
    else
        S = Xm*Xm';
        [Eigenvector, D] = eig(S);
        Eigenvector = Xm'*Eigenvector;
        for i = 1:w
            Eigenvector(:,i) = Eigenvector(:,i)/norm(Eigenvector(:,i));
        end
        % D = normalize(D, 255);
    end

    % sort Eigenvalues and eigen vectors
    [D, i] = sort(diag(D), 'descend');
    Eigenvector = Eigenvector(:, i);
    Eigenvector = Eigenvector(:, 1:k);
end