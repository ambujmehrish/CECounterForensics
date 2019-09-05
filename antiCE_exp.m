%Script to perform Anti forensic CE experiments on 10000 BOSS images or 500
%UCID images for various 'gamma' values
close all
clear all
%% Generate Set Index
Alpha =0.2; %[0.2,1,3,5]
Beta =  12;% [0.5,1,12,20]
Gamma = 0;% [0.08,0.8,1,2]
Delta =  0.5;% [0.5,1,5,10]
set = 1:10000;
set1 = randperm(10000,2000);
tempset = setdiff(set,set1);
pos = randperm(length(tempset),2000);
set2 = tempset(pos);
tempset = setdiff(tempset,set2);
pos = randperm(length(tempset),2000);
set3 = tempset(pos);
%normalCE = zeros(256,256,2000); %% for 256x256
normalCE = zeros(512,512,2000);
antiCE = normalCE;
% glcmUE = glcmCE;
% gamma = 100.*ones(500,1); %Histogram stretching
antiPSNR = zeros(2000,1);
filtarray = zeros(2000,1);
for i = 1 : 2000
    filtarray(i,1) = ceil(3*rand(1));
end
%% Define CE parameters
gamma_array = [0.001,0.002,0.003,0.004,0.005,0.006,0.007,0.008,0.009,0.01,0.02,0.03];  %for CE
%gamma_array = [0.1,0.3,0.4,0.6,0.8,1.1,1.5,1.8,2];                               %for NLFE
%gamma_array = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13];      %for LFE
%gamma = zeros(2000,1);
%load('OrignalImageSet.mat')
if 1
for i = 1 : 2000
    gamma(i,1) = gamma_array(randperm(9,1));            %CE
end
save('256_CE_Delta_Dataset\gamma','gamma')
end
%load('256_CE_Delta_Dataset\gamma.mat')
%% Original Images
if 1
parfor i = 1:size(set1,2)
    display(num2str(i));
    img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
    img = img(121:376,121:376); %% for 256x256
    imwrite(img,['256_CE_Delta_Dataset\Original Images\OriginalImg-',num2str(set1(i)),'.jpeg'],'quality',100);     
end
 save('256_CE_Delta_Dataset\OrignalImageSet','set1')
end
%load('256_CE_Delta_Dataset\NormalCEImageSet.mat')
%% Normal CE 
parfor i = 1:size(set2,2)
    display(num2str(i));
    img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
    img = img(121:376,121:376); %% for 256x256
    normalCE = adapthisteq(img,'ClipLimit',gamma(i,1));
  % normalCE =  uint8(255.*((double(img)./255).^(gamma(i,1))));
    imwrite(normalCE,['256_CE_Delta_Dataset\CE\normal_CE_BOSS_MRF-',num2str(set2(i)),'.jpeg'],'quality',90);    
end
save('256_CE_TV_Dataset\NormalCEImageSet','set2')
%% Proposed Antiforensics
if 1
parfor i = 1:size(set3,2)
    display(num2str(i));
    img = imread(['Database\BOSS\',num2str(set3(i)),'.pgm']);
    img = img(121:376,121:376); %% for 256x256
    [normalCE,antiCE] = MRFanti_grad(img,50,gamma(i,1),'CE',Alpha,Beta,Gamma,Delta);
   % [normalCE,antiCE] = perform_CE(img,gamma(i,1));
     imwrite(normalCE,['256_CE_Delta_Dataset\CE\normal_CE_BOSS_MRF-',num2str(set3(i)),'.jpeg'],'quality',100);
     imwrite(antiCE,['256_CE_Delta_Dataset\AntiCE\anti_ACE_BOSS_MRF-',num2str(set3(i)),'.jpeg'],'quality',100);
     normalCE = double(imread(['256_CE_Delta_Dataset\CE\normal_CE_BOSS_MRF-',num2str(set3(i)),'.jpeg']));
     antiCE = double(imread(['256_CE_Delta_Dataset\AntiCE\anti_ACE_BOSS_MRF-',num2str(set3(i)),'.jpeg']));
     antiCE = imread(['256_CE_Delta_Dataset\AntiCE\anti_ACE_BOSS_MRF-',num2str(set3(i)),'.jpeg'])
     imwrite(normalCE,['256_CE_Delta_Dataset\CE\normal_CE_BOSS_MRF-',num2str(set3(i)),'.jpeg'],'quality',100);
     normalCE = double(imread(['256_CE_Delta_Dataset\CE\normal_CE_BOSS_MRF-',num2str(set3(i)),'.jpeg']))
     imwrite(img,['256_CE_Delta_Dataset\Original Images\OriginalImg-',num2str(set3(i)),'.jpeg'],'quality',100);
     img = double(imread(['256_CE_Delta_Dataset\Original Images\OriginalImg-',num2str(set3(i)),'.jpeg']))
     SSIM(i,:) = ssim(normalCE,antiCE);
     norm_antiPSNR(i,:) = psnr(normalCE,antiCE);
     org_antiPSNR(i,:) = psnr(img,antiCE);
     org_normPSNR(i,:) = psnr(img,normalCE);
     [norm_anti_p_hvs_m(i,:), norm_anti_p_hvs(i,:)] = psnrhvsm(normalCE, antiCE, 8);
     [norm_anti_FSIM(i,:), norm_anti_FSIMc(i,:)] = FeatureSIM(normalCE, antiCE);
    % [index(i,:), MAP{i,1}]  = MAD_index(normalCE, antiCE);
     [mssim(i,1), ssim_map{i,1}] = ssim(normalCE,antiCE);
     vif(i,1)= vifvec(normalCE,antiCE);
     
    % f_Ori = extractFreq(img, 2,1);
    % f_norm = extractFreq(normalCE,2,1);
     %f_anti = extractFreq(antiCE,2,1);
     %h_Ori = hist(f_Ori,15);
     %h_norm = hist(f_norm,15);
     %h_anti = hist(f_anti,15);
     %d_Ori_norm(i,:)=chi_square_statistics(h_Ori,h_norm)
     %d_Ori_anti(i,:)=chi_square_statistics(h_Ori,h_anti)
     %d_anti_norm(i,:)=chi_square_statistics(h_anti,h_norm)
end
save('256_CE_Delta_Dataset\AntiCESet','set3')
save('256_CE_Delta_Dataset\norm_antiPSNR','norm_antiPSNR')
save('256_CE_Delta_Dataset\norm_anti_p_hvs_m','norm_anti_p_hvs_m')
save('256_CE_Delta_Dataset\norm_anti_p_hvs','norm_anti_p_hvs')
save('256_CE_Delta_Dataset\norm_anti_FSIM','norm_anti_FSIM')
save('256_CE_Delta_Dataset\norm_anti_FSIMc','norm_anti_FSIMc')
%save('256_CE_Delta_Dataset\MAD_index','index')
%save('256_CE_Delta_Dataset\MAD_MAP','MAP')
save('256_CE_Delta_Dataset\mssim','mssim')
save('256_CE_Delta_Dataset\ssim_map','ssim_map')
save('256_CE_Delta_Dataset\vif','vif')
save('256_CE_Delta_Dataset\norm_antiSSIM','SSIM')
%save('256_CE_Uniform_Dataset\d_Ori_norm','d_Ori_norm')
%save('256_CE_Uniform_Dataset\d_Ori_anti','d_Ori_anti')
%save('256_CE_Uniform_Dataset\d_anti_norm','d_anti_norm')
end
% %% UniversalHistogramAntiForensics 
% 
% for i = 1:size(set3,2)
%     display(num2str(i));
%     img = imread(['Database/BOSS Image database (10000 uncompressed images)/',num2str(set3(i)),'.pgm']);
%    % img = img(121:376,121:376); %% for 256x256
%     normalCE = adapthisteq(img,'ClipLimit',gamma(i,1));
%     antiCE = histogram_universal_antiforensics(normalCE,4);      
% %     imwrite(normalCE,['512_CE_Dataset\CE_unv\normal_CE_BOSS_MRF-',num2str(set3(i)),'.jpeg'],'quality',100);
% %     imwrite(antiCE,['512_CE_Dataset\AntiCE_unv\anti_ACE_BOSS_MRF-',num2str(set3(i)),'.jpeg'],'quality',100);
%     norm_antiPSNR_unv(i,:) = psnr(normalCE,antiCE);
%     org_antiPSNR_unv(i,:) = psnr(img,antiCE);
%     org_normPSNR_unv(i,:) = psnr(img,normalCE);    
% end
% save('norm_antiPSNR_unv','norm_antiPSNR_unv')
% save('org_antiPSNR_unv','org_antiPSNR_unv')
% save('org_normPSNR_unv','org_normPSNR_unv')
