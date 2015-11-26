clear
dirname = 'images/db1';
files = dir(fullfile(dirname, '*.jpg'));
files = {files.name}';
correct = 0;
for i=1:numel(files)
    clear img fname res;
    fname = fullfile(dirname, files{i});
    img = imread(fname);
    [res, info] = tnm034(imrotate(img,10));
    
    if(res == i)
        disp(['Match for file "' fname '": ' num2str(res)]);
        correct = correct +1;
    else
        disp(['No Match for "' fname '"!']);
        whos info
        info'
    end
%     waitforbuttonpress;
end
correct
correctness = correct/16.0