function [ id ] = createEigenDatabase( dirname )
%CREATEEIGENDATABASE create eigen database from images in folder
%   to clear the database and allow for re-creation, run 
%   `clear global eigenDatabase eigenDatabaseDirname`
    
    if nargin == 0  
        dirname = 'images/db1'
    end
    k = 16
    % check if we have a database and that the database is built from the
    % same directory as we want to build it from this timeaseDirname databaseMean
    disp(['Creating eigen database for dir "' dirname '"...'])
    tic
    files = dir(fullfile(dirname, '*.jpg'));
    files = {files.name}';
    for i=1:numel(files)
        fname = fullfile(dirname, files{i});
        img = imread(fname);
        cropped = detectAndNormalize(img);
        croppedGray = rgb2gray(cropped);
        allImages(:,:,i) = croppedGray;
    end
    totimages = numel(files);
    [X,Y] = size(allImages(:,:,1));
    d = X*Y;
    allImages = reshape(allImages, [d, totimages]);
    [allEigenVectors, allEigenValues, meanImage] = pca(allImages);
    disp('... done!')
    toc
    
    % store dirname and return database
    eigenVectors = allEigenVectors;
    database = zeros(16,k);
    for i=1:16
        img = allImages(:,i)';
        img = double(img)-meanImage;
        for j=1:k
            w =  img*eigenVectors(:,j);
            database(i,j) = w;
        end
    end 
    databaseEigenVectors = eigenVectors;
    databaseMeanImage = meanImage;
    faceWeights = database;
    save('database.mat', 'databaseEigenVectors' ,'databaseMeanImage','faceWeights')
end
