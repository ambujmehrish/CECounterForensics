clear 
clc
tPSNR= 0;
SSIM = 0;
fld = 'E:\Ambuj MMSEC\ContrastEnhancedAntiforensics\256_CE_Dataset\AntiCE';
load('gamma.mat')
images = dir(fld);
images = images(3:end,:);
for i =1 : size(images,1)
    display(num2str(i));
    [~,name,~] = fileparts(images(i).name);
     x = strsplit(name,'-');
     x = x{2};
     Imx = imread(['E:\Ambuj MMSEC\ContrastEnhancedAntiforensics\Database\BOSS\',x,'.pgm']);
     Imx = Imx(121:376,121:376);
     CEImx = adapthisteq(Imx,'ClipLimit',gamma(i,1));
     imwrite(CEImx,['256_CE_Dataset\CE\normal_CE_BOSS_MRF-',x,'.jpeg'],'quality',100);
     Imx = imread(['256_CE_Dataset\CE\normal_CE_BOSS_MRF-',x,'.jpeg']);
     anticeImx = imread([fld,'/',images(i).name]);
     p = psnr(anticeImx,CEImx);
     s = ssim(anticeImx,CEImx);
    tPSNR = tPSNR + p ;
    SSIM = SSIM + s;
end
aPSNR = tPSNR/2000
avgSSIM = SSIM/2000