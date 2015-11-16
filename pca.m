function [eigenVector, meanImg] = pca(Img)
    
    [w, h] = size(Img)
    meanImg = mean(Img);
    %Repmat function returns a repeated copy of the array.
    Xm = double(Img)-repmat(meanImg, rows(Img), 1);
    
    if(w > h)
        C = Xm'-Xm;
        %Retrieve Eigen Values
        [eigenVector, D] = eig(C);
        %Sort Eigenvalues
        [D, i] = sort(Diag(D), 'descend');
        eigenVector = eigenVector(:,i);
    else
        C = Xm*Xm';
        [eigenVector, D] = eig(C);
        eigenVector = Xm'*eigenVector;
        D = normaliz(D, 255);
        [D, i] = sort(Diag(D), 'descend');
        eigenVector = eigenVector(:,i);
    end
end
        

    
    
end