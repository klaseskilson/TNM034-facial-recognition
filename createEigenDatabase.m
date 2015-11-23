function [ database ] = createEigenDatabase( dirname )
%CREATEEIGENDATABASE create eigen database from images in folder
%   to clear the database and allow for re-creation, run 
%   `clear global eigenDatabase eigenDatabaseDirname`
    
    if nargin == 0  
        dirname = 'images/db1'
    end

    % check if we have a database and that the database is built from the
    % same directory as we want to build it from this time
    global eigenDatabase eigenDatabaseDirname
    if (isempty(eigenDatabase) == 1) & (isempty(eigenDatabaseDirname) == 1 | eigenDatabaseDirname ~= dirname)
        disp(['Creating eigen database for dir "' dirname '"...'])
        tic
        files = dir(fullfile(dirname, '*.jpg'));
        files = {files.name}';

        for i=1:numel(files)
            fname = fullfile(dirname, files{i});
            img = imread(fname);
            cropped = detectAndNormalize(img);
            croppedGray = rgb2gray(cropped);
            % save pca response
            eigenDatabase{i} = pca(croppedGray);
        end
        disp('... done!')
        toc
    end
    
    % store dirname and return database
    eigenDatabaseDirname = dirname;
    database = eigenDatabase;
end
