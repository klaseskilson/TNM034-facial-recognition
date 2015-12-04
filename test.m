dirname = 'images/db1';
files = dir(fullfile(dirname, '*.jpg'));
files = {files.name}';
correct = 0;
nofound = 0;
falseNegative = 0;
falsePositive = 0;
angle = 5;
threshold = 200;
for i=1:numel(files)
    clear img fname res;
    fname = fullfile(dirname, files{i});
    img = imread(fname);
    number = str2num(fname(end-5:end-4));
    for k=-angle:angle
        % destroy the image!
        modifiedImage = imrotate(img, k);
        %modifiedImage = img * (1 - k * 0.01);

        [res, info] = tnm034(modifiedImage);
        w = info(1,2);
        id = info(1,1);
        if(w > threshold)
            'Over treshold!'
            if(res == number)
                falseNegative = falseNegative + 1;
            end
        elseif(res == number)
            disp(['Match for file "' fname '": ' num2str(res)]);
            correct = correct +1;
        else
            falsePositive = falsePositive + 1;
            disp(['No Match for "' fname '"! Got ' num2str(res) ', expected ' num2str(number) ]);
        end
%         if(res ~=-1)
%             id = info(:,1);
%             w = info(:,2);
%             id(1:3)'
%             w(1:3)'
%         else
%             nofound = nofound + 1;
%         end
    end
end
correct
correctness = correct/(numel(files)*(1+angle*2))
falseNegative
falsePositive
