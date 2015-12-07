dirname = 'images/db1';
files = dir(fullfile(dirname, '*.jpg'));
files = {files.name}';
%total of files
total = 0;

% control the error!
rotateError = 5;
toneError = 30;
scaleError = 10;
step = 1;
angle = 5;


% results
correct = 0;
nofound = 0;
FRR = 0;
FAR = 0;

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
                ids = info(1,1);
                if(res ~= 0)
                    correct = correct + 1;
                    if(ids == number)
                      %correct
                      disp(['Match for file "' fname '": ' num2str(res)]);
                    else
                      %false positive
                      FAR = FAR + 1;
                      disp(['False positive for file "' fname '": ' num2str(res)]);
                    end
                else
                    if(ids == number)
                        FRR = FRR + 1;
                        disp(['False negative for file "' fname '": ' num2str(res)]);
                    elseif(ids == -1)
                        nofound = nofound + 1;
                        disp(['No face found file "' fname '": ' num2str(res)]);
                    else
                        disp(['No match for file "' fname '": ' num2str(res)]);
                    end
                end
                
                
                if (ids == -1)
                    nofound = nofound + 1;
                    continue
                end
            end
        end
    end
end

disp(['Results of ' num2str(total) ' images:']);
disp(['Correct: ' num2str(correct/total)]);
disp(['False Rejection Rate: ' num2str(FRR/(total-nofound-correct))]);
disp(['False Acceptance Rate: ' num2str(FAR/correct)]);
disp(['No faces found: ' num2str(nofound)]);
