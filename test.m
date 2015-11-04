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
    ycc = chromaTransformation(ycc);
    mask = skinModel(ycc);
    %figure
    %imshow(ycbcr2rgb(ycc));
    imshow(mask)
    k = waitforbuttonpress
end
