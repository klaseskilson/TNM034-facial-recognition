function [meanImg] = meanImage(dirname)
%MEANIMAGE Find the mean image from folder
%   to clear the database and allow for re-creation, run 
%   `clear global storedMeanImage meanDirname`
    
    global storedMeanImage meanDirname
    if (isempty(storedMeanImage) == 1) & (isempty(meanDirname) == 1 | meanDirname ~= dirname)
        disp(['Finding mean image for "' dirname '"...'])
        tic
        files = dir(fullfile(dirname, '*.jpg'));
        files = {files.name}';
        
        % preallocate memory for images
        imgs = zeros(256, 169, numel(files));
        
        for i=1:numel(files)
            fname = fullfile(dirname, files{i});
            img = imread(fname);
            img = detectAndNormalize(img);
            imgs(:,:,i) = rgb2gray(img);
        end
        
        storedMeanImage = mean(imgs, 3);
        
        toc
    end
    
    meanDirname = dirname;
    meanImg = storedMeanImage;
end

