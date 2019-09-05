clear 
close all
% ImageDir = '256AntiCE 4Terms (Lambda0.05)(Lambda) 6DCT_0.1\';
% ImageDir = 'Original\';
ImageDir = '256_CE_TV_Dataset\AntiCE\';
files = dir(ImageDir); 
parfor i =3:size(files,1)
    i
    IMAGE = imread([ImageDir,files(i).name]);
    f = spam686_jfridrich(IMAGE,3);
    temp = f'
    SPAM_AntiCE(i-2,:) = temp;
   disp('End of processing for image')
end
save('256_CE_TV_Dataset\SPAM_AntiCE_256','SPAM_AntiCE')