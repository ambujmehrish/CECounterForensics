clear 
close all
% ImageDir = '256AntiCE 4Terms (Lambda0.05)(Lambda) 6DCT_0.1\';
% ImageDir = 'Original\';
ImageDir = '256_CE_TV_Dataset\AntiCE\';
files = dir(ImageDir); 
parfor i =3:size(files,1)
    i
    IMAGE = imread(files(i).name);
    f = SRM_jfridrich(IMAGE);
    g = struct2cell(f);
    g=g';
    temp = [];
    disp('Converting Features into Vectors')
    for j = 1: 106
        temp = [temp,g{1,j}];
    end
   SRMAntiCE(i-2,:) = temp;
   disp('End of processing for image')
end
save('256_CE_TV_Dataset\SRMAntiCE_256','SRMAntiCE')