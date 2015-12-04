dirname = 'images/db1';
files = dir(fullfile(dirname, '*.jpg'));
files = {files.name}';
correct = 0;
nofound = 0;
total = 0;

% control the error!
rotateError = 5;
toneError = 30;
scaleError = 10;

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

                if(res == number)
                    disp(['Match for file "' fname '": ' num2str(res)]);
                    correct = correct +1;
                else
                    disp(['No Match for "' fname '"! Got ' num2str(res) ', expected ' num2str(number) ]);
                end
                if(res ~=-1)
                    id = info(:,1);
                    w = info(:,2);
                    id(1:3)'
                    w(1:3)'
                else
                    nofound = nofound + 1;
                end

            end
            
        end
    end
end
correct
correctness = correct/total
nofound
