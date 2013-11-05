%load metadata
disp('loading csv files');
fid = fopen('data/paris_period.csv');
imgs = textscan(fid, ['%s %f'], 'HeaderLines',1,'Delimiter',',','CollectOutput',1);
imgs = struct('path', imgs{1}, 'label' , num2cell(imgs{2}));
fclose(fid);


% collecting image size (may varying)
% (+ checking implicitly the availability of images)
disp('collecting the size of images...');

invalid = [];
for i = 1: numel(imgs)
   if mod(i,500) == 0 
     fprintf('\ncollecting image size of %dth image',i); 
   end
   try 
    disp(imgs(i).path);
    I = imread(imgs(i).path);
    imgs(i).imsize = size(I);
   catch
    invalid = [invalid i];
    fprintf('\n\n\nERROR for image %s', imgs(i).path);
   end
   
end
imgs(invalid) = [];
disp(size(imgs));
save('data/paris_data.mat','imgs');