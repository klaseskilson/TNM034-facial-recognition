function [ id ] = createEigenDatabase( dirname )
%CREATEEIGENDATABASE create eigen database from images in folder
%   to clear the database and allow for re-creation, run 
%   `clear global eigenDatabase eigenDatabaseDirname`
    
    %default database folder
    if nargin == 0  
        dirname = 'images/db1'
    end
    
    % number of eigenvectors to use
    k = 16;
    
    disp(['Creating eigen database for dir "' dirname '"...'])
    tic
    
    files = dir(fullfile(dirname, '*.jpg'));
    files = {files.name}';
    for i=1:numel(files)
        fname = fullfile(dirname, files{i});
        img = imread(fname);
        %find face and align them
        allImages(:,:,i) = detectAndNormalize(img);
    end
    totimages = numel(files);
    [X,Y] = size(allImages(:,:,1));
    d = X*Y;
    %create a 16 by d vector of all images
    allImages = reshape(allImages, [d, totimages]);
    %run PCA and get eigen vector, values and mean image
    [allEigenVectors, allEigenValues, meanImage] = pca(allImages, k);
    disp('... done!')
    toc
    
    eigenVectors = allEigenVectors;
    %create database of weights to eigenvectors
    database = zeros(16,k);
    for i=1:16
        img = allImages(:,i)';
        img = double(img)-meanImage;
        for j=1:k
            w =  img*eigenVectors(:,j);
            database(i,j) = w;
        end
    end 
    
    %set variable names to store that will later be used in tnm034.m
    databaseEigenVectors = eigenVectors;
    databaseMeanImage = meanImage;
    faceWeights = database;
    save('database.mat', 'databaseEigenVectors' ,'databaseMeanImage','faceWeights')
end
