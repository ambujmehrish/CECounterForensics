 clear all
 close all
img = imread(['Database\BOSS\',num2str(524),'.pgm']);
img = img(121:376,121:376); %% for 256x256
[normalCE,antiCETV] = perform_CE(img,0.8);
[antiCEGD,PSNR,SSIM] = Attack_CE_hiding(img,0.8,'gamma');
hist_original = hist(img(:),0:1:255);
hist_normalCE = hist(normalCE(:),0:1:255);
hist_antiCEGD = hist(antiCEGD(:),0:1:255);
hist_antiCETV = hist(antiCETV(:),0:1:255);
figure();set(gcf,'OuterPosition',[0 400 1000 400]);
subplot(1,4,1); imshow(uint8(img));title('Original Image');
subplot(1,4,2); imshow(uint8(normalCE));title('Conventional CE');
subplot(1,4,3); imshow(uint8(antiCEGD));title('AntiCE-GD Image');
subplot(1,4,4); imshow(uint8(antiCETV));title('AntiCE-TV Image');
figure();set(gcf,'OuterPosition',[0 0 1000 400])
subplot(1,4,1); bar(hist_original);
subplot(1,4,2); bar(hist_normalCE);
subplot(1,4,3); bar(hist_antiCEGD);
subplot(1,4,4); bar(hist_antiCETV);