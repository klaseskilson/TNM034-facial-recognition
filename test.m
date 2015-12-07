dirname = 'images/db1';
files = dir(fullfile(dirname, '*.jpg'));
files = {files.name}';
correct = 0;
nofound = 0;

% control the error!
rotateError = 5;
toneError = 30;
scaleError = 10;

falseNegative = 0;
falsePositive = 0;
threshold = 300;

for i=1:numel(files)
    clear img fname res;
    fname = fullfile(dirname, files{i});
    img = imread(fname);
    number = str2num(fname(end-5:end-4));
    for j=-rotateError:5:rotateError
        % destroy the image!
        % rotate image
        rotatedImage = imrotate(img, j);
        for k=-toneError:30:toneError
            % adjust tone value
            toneAdjustedImage = rotatedImage * (1 - k * 0.01);
            for l=-scaleError:10:scaleError
                % scale image
                modifiedImage = imresize(toneAdjustedImage, 1 - l * 0.01);
                
                total = total + 1;
                
                [res, info] = tnm034(modifiedImage);
                if (res == -1)
                    nofound = nofound + 1;
                    continue
                end
                
                w = info(1,2);
                id = info(1,1);
                if(w > threshold)
                    disp('Over treshold!')
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
            end 
        end
    end
end
correct
correctness = correct/total
falseNegative
falsePositive
nofound