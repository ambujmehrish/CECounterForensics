clear 
close all
imgdir = '256_CE_Dataset\Original Images';
Img = dir(imgdir);
Img = Img(3:end,:);
parfor i = 1:size(Img,1)
    disp(['Processing Img-:',int2str(i)])
    filename = Img(i).name;
    imx = imread(filename);
    SRM(i,:) = extractSRM(imx);
    
end
save('SRM-OI','SRM')
