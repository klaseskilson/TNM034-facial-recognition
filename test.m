clear all 

dirname = 'images/db1';
files = dir(fullfile(dirname, '*.jpg'));
files = {files.name}';

testnum = 3;

%for i=testnum:testnum%numel(files);
for i=1:numel(files)
    clear img fname res;
    fname = fullfile(dirname, files{i});
    img = imread(fname);
    %imshow(img)
    ycc = rgb2ycbcr(img);
    mask1 = skinModel(ycc);
    ycc = chromaTransformation(ycc);
    mask2 = skinModel(ycc);
    subplot(1,2,1), subimage(mask1)
    subplot(1,2,2), subimage(mask2)
    waitforbuttonpress
end
