dirname = 'images/db1';
files = dir(fullfile(dirname, '*.jpg'));
files = {files.name}';
correct = 0;
nofound = 0;
for i=1:numel(files)
    clear img fname res;
    fname = fullfile(dirname, files{i});
    img = imread(fname);

    for k=-5:5
        [res, info] = tnm034(imrotate(img,k));  
        if(res == i)
            disp(['Match for file "' fname '": ' num2str(res)]);
            correct = correct +1;
        else
            disp(['No Match for "' fname '"! Got ' num2str(res) ', expected ' num2str(i) ]);
        end
        if(info ~=-1)
                id = info(:,1);
                w = info(:,2);
                id(1:3)'
                w(1:3)'
        else
            nofound = nofound + 1;
            i
            k
            return;
        end
        
    end
end
correct
correctness = correct/(numel(files)*10)
nofound