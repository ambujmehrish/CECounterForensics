clear all
clc
%dataFolder = '.\512_CE_Dataset\512Original Images';
dataFolder = '.\512_CE_Dataset\512NormalCE ProcessedImages';
%dataFolder = '.\512_CE_Dataset\512AntiCE ProcessedImages';
m = 2;
n = 1;
dataFiles = dir(dataFolder);
cd(dataFolder)
D = generateDMat();
DT = D.';
IMat = generateIMat(m,n);
index = 1;
for i =3:1003
    i
    img = double(imread(dataFiles(i).name));
    imgDCT = D*img*DT;
    DCT = IMat.*imgDCT;
    L = DCT(DCT~=0);
    if index == 1
        H = L;
        index = 0;
    else
        H = [H;L];
    end
end

hist(H,1000)







