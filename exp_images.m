clear 
clc
Alpha =0.2; %[0.2,1,3,5]
Beta =  12;% [0.5,1,12,20]
Gamma = 0.08;% [0.08,0.8,1,2]
Delta =  0.5;% [0.5,1,5,10]
n = 4000;
offsets = [-1 1];
img = imread(['Database\BOSS\',num2str(n),'.pgm']);
img = img(121:376,121:376);
%% Unaltered
 S_unaltered = graycomatrix(img,'NumLevels',256,'Offset',offsets);
 figure
 imshow(single(S_unaltered))
%% Gamma Correction
 gamma = 0.1 + (1.5-0.1)*rand(1,1);
 img_gc = uint8(255.*((double(img)./255).^(gamma)));
 S_gamma = graycomatrix(img_gc,'NumLevels',256,'Offset',offsets);
 figure
 imshow(single(S_gamma))

%% Histogram Streching
  img_hs = imadjust(img,stretchlim(img),[0.1 0.6]);
  S_hs = graycomatrix(img_hs,'NumLevels',256,'Offset',offsets);
  figure
  imshow(single(S_hs))
  %% CLAHE
  gamma = 0.001 + (0.02-0.001)*rand(1,1);
  img_clahe = adapthisteq(img,'ClipLimit',gamma);
  S_clahe = graycomatrix(img_clahe,'NumLevels',256,'Offset',offsets);
  figure
  imshow(single(S_clahe))
  %% GD
  gamma = 0.001 + (0.02-0.001)*rand(1,1);
  [antiCE,PSNR,SSIM] = Attack_CE_hiding(img,gamma,'gamma');
   S_gd = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
   figure
   imshow(S_gd)
  %% TV
  gamma = 0.001 + (0.02-0.001)*rand(1,1);
   [normalCE,antiCE] = perform_CE(img,gamma);
   S_tv = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
   figure
   imshow(S_tv)
  %% Proposed
  gamma = 0.001 + (0.02-0.001)*rand(1,1);
  [normalCE,antiCE] = MRFanti_grad(img,50,gamma,'CE',Alpha,Beta,Gamma,Delta);
  S_proposed = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
  figure
  imshow(single(S_proposed))
  

 