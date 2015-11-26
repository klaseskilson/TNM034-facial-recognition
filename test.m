clear
dirname = 'images/db1';
files = dir(fullfile(dirname, '*.jpg'));
files = {files.name}';

for i=1:numel(files)
    clear img fname res;
    fname = fullfile(dirname, files{i});
    img = imread(fname);
    res = tnm034(imrotate(img,0));
    disp(['Match for file "' fname '": ' num2str(res)]);
    waitforbuttonpress;
end
