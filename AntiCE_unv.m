clear 
close all
load('256_CE_Uniform_Dataset\AntiCESet.mat')
load('256_CE_Uniform_Dataset\gamma.mat')
imgFiles_antiCE = dir('256_CE_Uniform_Dataset\AntiCE_unv\');
imgFiles_antiCE = imgFiles_antiCE(3:end);
imgFiles_CE = dir('256_CE_Uniform_Dataset\CE_unv\');
imgFiles_CE = imgFiles_CE(3:end);
parfor i = 1:size(set3,2)
    display(num2str(i));
    [~,y,~] = fileparts(imgFiles_antiCE(i).name);
    n = strsplit(y,'-');
    %img = imread(['Database\BOSS\',n{1,2},'.pgm']);
    %img = img(121:376,121:376); %% for 256x256
   % imshow(img)
    normalCE = double(imread(['256_CE_Uniform_Dataset\CE_unv\',imgFiles_CE(i).name]));
    antiCE = double(imread(['256_CE_Uniform_Dataset\AntiCE_unv\',imgFiles_antiCE(i).name]));
    %[antiCE,PSNR,SSIM] = Attack_CE_hiding(img,gamma(i,1),'gamma');
    %imwrite(uint8(antiCE),['256_CE_Uniform_Dataset\[20]\anti_ACE_BOSS_[20]-',num2str(set3(i)),'.jpeg'],'quality',100);
    %norm_antiPSNR(i,:) = PSNR;
    %norm_antissim(i,:) = SSIM;
%    [norm_anti_p_hvs_m(i,:), norm_anti_p_hvs(i,:)] = psnrhvsm(normalCE, antiCE, 8);
%     [norm_anti_FSIM(i,:), norm_anti_FSIMc(i,:)] = FeatureSIM(normalCE, antiCE);
     % [index(i,:), MAP{i,1}]  = MAD_index( normalCE, antiCE);
%      [mssim(i,1), ssim_map{i,1}] = ssim(normalCE,antiCE);
       vif(i,1)= vifvec(normalCE,antiCE);
end
% save('256_CE_Uniform_Dataset\norm_antiPSNR_unv','norm_antiPSNR')
% save('256_CE_Uniform_Dataset\norm_antissim_unv','norm_antissim')
% save('256_CE_Uniform_Dataset\norm_anti_p_hvs_m_unv','norm_anti_p_hvs_m')
% save('256_CE_Uniform_Dataset\norm_anti_p_hvs_unv','norm_anti_p_hvs')
% save('256_CE_Uniform_Dataset\norm_anti_FSIM_unv','norm_anti_FSIM')
% save('256_CE_Uniform_Dataset\norm_anti_FSIMc_unv','norm_anti_FSIMc')
%save('256_CE_Uniform_Dataset\MAD_index_unv','index')
% save('256_CE_Uniform_Dataset\MAD_index_unv','index')
% save('256_CE_Uniform_Dataset\MAD_map_unv','MAP')
%  save('256_CE_Uniform_Dataset\mssim_unv','mssim')
%  save('256_CE_Uniform_Dataset\ssim_map_unv','ssim_map')
save('256_CE_Uniform_Dataset\vif_unv','vif')