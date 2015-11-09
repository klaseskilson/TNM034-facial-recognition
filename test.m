clear all;

dirname = 'images/db1';
files = dir(fullfile(dirname, '*.jpg'));
files = {files.name}';

for i=1:numel(files)
    clear img fname res;
    fname = fullfile(dirname, files{i});
    img = imread(fname);
    img = colorCorrect(img);
    ycc = rgb2ycbcr(img);
    ycc = chromaTransformation(ycc);
    mask = skinModel(ycc);
    subplot(1,2,1), subimage(img)
    subplot(1,2,2), subimage(mask)
    waitforbuttonpress
end
