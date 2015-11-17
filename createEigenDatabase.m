function [ database ] = createEigenDatabase( dirname )
%CREATEEIGENDATABASE create eigen database from images in folder
%   Detailed explanation goes here
    if nargin == 0  
        dirname = 'images/db1'
    end
    
    files = dir(fullfile(dirname, '*.jpg'));
    files = {files.name}';

    for i=1:numel(files)
        fname = fullfile(dirname, files{i});
        img = imread(fname);
        cropped = detectAndNormalize(img);
        croppedGray = rgb2gray(cropped);
        pcaImg = pca(croppedGray);
        database{i} = pcaImg;
    end
end
