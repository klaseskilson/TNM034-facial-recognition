clear all 

dirname = 'images/db1';
files = dir(fullfile(dirname, '*.jpg'));
files = {files.name}';

for i=1:1%numel(files);
    clear img fname res;
    fname = fullfile(dirname, files{i});
    img = imread(fname);
    imshow(img)
    img = rgb2ycbcr(img);
    mask = skinModel(img);
    res = tnm034(img);
    figure
    imshow(mask)
    
    
    disp(['Match for file "' fname '": ' num2str(res)])
end
