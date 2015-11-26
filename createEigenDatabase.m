function [ eigenVectors, meanImage, database] = createEigenDatabase( dirname, numberOfEigenFaces )
%CREATEEIGENDATABASE create eigen database from images in folder
%   to clear the database and allow for re-creation, run 
%   `clear global eigenDatabase eigenDatabaseDirname`
    
    if nargin == 0  
        dirname = 'images/db1'
    end

    % check if we have a database and that the database is built from the
    % same directory as we want to build it from this timeaseDirname databaseMean
    disp(['Creating eigen database for dir "' dirname '"...'])
    tic
    files = dir(fullfile(dirname, '*.jpg'));
    files = {files.name}';

    % pre-allocate memory for all pca imgs
    eigenVectors = zeros(128*84, 40);

    for i=1:numel(files)
        fname = fullfile(dirname, files{i});
        img = imread(fname);
        cropped = detectAndNormalize(img);
        croppedGray = rgb2gray(cropped);
        allImages(:,:,i) = croppedGray;
    end
    totimages = numel(files);
    d = 128*84;
    allImages = reshape(allImages, [d, totimages]);
    [allEigenVectors, allEigenValues, meanImage] = pca(allImages);

    disp('... done!')
    toc
    
    % store dirname and return database
    eigenVectors = allEigenVectors;
    database = zeros(16,40);
    for i=1:16
        img = allImages(:,i)';
        img = double(img)-meanImage;
        for j=1:40
            w =  img*eigenVectors(:,j);
            database(i,j) = w;
        end
    end 
end
