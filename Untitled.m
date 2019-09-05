clear 
close all
% ImageDir = '256AntiCE 4Terms (Lambda0.05)(Lambda) 6DCT_0.1\';
% ImageDir = 'Original\';
ImageDir = '512_CE_Dataset\CE\';
files = dir(ImageDir); 
parfor i =3:size(files,1)
    i
    IMAGE = imread([files(i).folder,'\',files(i).name]);
    f = spam686_jfridrich(IMAGE,3);
    F = ccpev548([files(i).folder,'\',files(i).name],100)
    temp
    SPAM_CCPEV_CE(i-2,:) = temp;
   disp('End of processing for image')
end
save('SPAM_CCPEV_CE','SPAM_CCPEV_CE')