clear
dirname = 'images/db1';
files = dir(fullfile(dirname, '*.jpg'));
files = {files.name}';

for i=1:numel(files)
    clear img fname res;
    fname = fullfile(dirname, files{i});
    img = imread(fname);
    [res, info] = tnm034(imrotate(img,1));
    if(res == i)
        disp(['Match for file "' fname '": ' num2str(res)]);
    else
        disp(['No Match for "' fname '"!']);
        info'
    end
    waitforbuttonpress;
end
