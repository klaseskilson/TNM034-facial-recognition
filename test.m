clear dirname files;

dirname = 'images/db1';
files = dir(fullfile(dirname, '*.jpg'));
files = {files.name}';

for i=1:numel(files)
    clear img fname res;
    fname = fullfile(dirname, files{i});
    img = imread(fname);
    res = tnm034(img);
    
    disp(['Match for file "' fname '": ' num2str(res)]);
    k = waitforbuttonpress;
end
