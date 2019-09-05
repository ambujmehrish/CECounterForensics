clear 
close all
load('256_CE_Uniform_Dataset\AntiCESet.mat')
load('256_CE_Uniform_Dataset\gamma.mat')
parfor i = 1:size(set3,2)
    display(num2str(i));
    img = imread(['Database\BOSS\',num2str(set3(i)),'.pgm']);
    img = img(121:376,121:376); %% for 256x256
   % imshow(img)
    normalCE = adapthisteq(img,'ClipLimit',gamma(i,1));
    imwrite(uint8(normalCE),['256_CE_Uniform_Dataset\CE[20]\normal_CE_BOSS_MRF_[20]-',num2str(set3(i)),'.jpeg'],'quality',90);
    normalCE = double(imread(['256_CE_Uniform_Dataset\CE[20]\normal_CE_BOSS_MRF_[20]-',num2str(set3(i)),'.jpeg']));
    [antiCE,PSNR,SSIM] = Attack_CE_hiding(img,gamma(i,1),'gamma');
    imwrite(uint8(antiCE),['256_CE_Uniform_Dataset\[20]\anti_ACE_BOSS_[20]-',num2str(set3(i)),'.jpeg'],'quality',90);
    antiCE = double(imread(['256_CE_Uniform_Dataset\[20]\anti_ACE_BOSS_[20]-',num2str(set3(i)),'.jpeg']));
    vif(i,1)= vifvec(normalCE,antiCE);
   % [mssim(i,1), ssim_map{i,1}] = ssim(normalCE,antiCE);
%     norm_antiPSNR(i,:) = PSNR;
%     norm_antissim(i,:) = SSIM;
%    [norm_anti_p_hvs_m(i,:), norm_anti_p_hvs(i,:)] = psnrhvsm(normalCE, antiCE, 8);
%     [norm_anti_FSIM(i,:), norm_anti_FSIMc(i,:)] = FeatureSIM(normalCE, antiCE);
%       [index(i,:), MAP{i,1}]  = MAD_index( normalCE, antiCE);
end
% save('256_CE_Uniform_Dataset\norm_antiPSNR_[20]','norm_antiPSNR')
% save('256_CE_Uniform_Dataset\norm_antissim_[20]','norm_antissim')
% save('256_CE_Uniform_Dataset\norm_anti_p_hvs_m_[20]','norm_anti_p_hvs_m')
% save('256_CE_Uniform_Dataset\norm_anti_p_hvs_[20]','norm_anti_p_hvs')
% save('256_CE_Uniform_Dataset\norm_anti_FSIM_[20]','norm_anti_FSIM')
% save('256_CE_Uniform_Dataset\norm_anti_FSIMc_[20]','norm_anti_FSIMc')
%  save('256_CE_Uniform_Dataset\MAD_index_[20]','index')
%  save('256_CE_Uniform_Dataset\MAD_map_[20]','MAP')
%  save('256_CE_Uniform_Dataset\mssim_[20]','mssim')
%  save('256_CE_Uniform_Dataset\ssim_map_[20]','ssim_map')
save('256_CE_Uniform_Dataset\vif_[20]','vif')