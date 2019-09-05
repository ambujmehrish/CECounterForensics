clear 
close all
load('NormalCEImageSet.mat')
load('OrignalImageSet.mat')
load('AntiCESet.mat')
load('antiCE_GLCM.mat')
load('OI_GLCM.mat')
load('CE_GLCM.mat')
load('antiCE_unv_GLCM.mat')
trs = 1000;
tes = 500;
TPR = 0 ;
TNR = 0;
flag = 1;
% for i =1 : 2000,
%     display(num2str(i));
%     img = imread(['E:\Ambuj MMSEC\ContrastEnhancedAntiforensics\256_CE_Dataset\AntiCE\anti_ACE_BOSS_MRF-',num2str(set3(i)),'.jpeg']);
%     [glc antiCE(i, :)] =  SecondOrderFeatExt(img);
% end
% 
% for i =1 : 2000,
%     display(num2str(i));
%     img = imread(['E:\Ambuj MMSEC\ContrastEnhancedAntiforensics\256_CE_Dataset\AntiCE_unv\anti_ACE_BOSS_MRF-',num2str(set3(i)),'.jpeg']);
%     [glc antiCE_unv(i, :)] =  SecondOrderFeatExt(img);
% end
% 
% for i =1 : 2000,
%     display(num2str(i));
%     img = imread(['E:\Ambuj MMSEC\ContrastEnhancedAntiforensics\256_CE_Dataset\Original Images\OriginalImg-',num2str(set1(i)),'.jpeg']);
%     [glc original(i, :)] =  SecondOrderFeatExt(img);
% end
% 
% for i =1 : 2000,
%     display(num2str(i));
%     img = imread(['E:\Ambuj MMSEC\ContrastEnhancedAntiforensics\256_CE_Dataset\CE\normal_CE_BOSS_MRF-',num2str(set2(i)),'.jpeg']);
%     [glc normalCE(i, :)] =  SecondOrderFeatExt(img);
% end
% save('antiCE_GLCM','antiCE')
% save('OI_GLCM','original')
% save('CE_GLCM','normalCE')
% save('antiCE_unv_GLCM','antiCE_unv')
display('Spliting Dataset')
UE_train = datasample(original, trs, 'Replace', false);
UE_test = datasample(setdiff(original, UE_train, 'rows'), tes, 'Replace', false);
%% Split Data -- Anti CE Proposed
 AntiCE_train = datasample(antiCE, trs, 'Replace', false);
 AntiCE_test = datasample(setdiff(antiCE, AntiCE_train, 'rows'), tes, 'Replace', false);
%% Split Data -- Anti CE [14]
 AntiCE_unv_train = datasample(antiCE_unv, trs, 'Replace', false);
 AntiCE_unv_test = datasample(setdiff(antiCE_unv, AntiCE_unv_train, 'rows'), tes, 'Replace', false);
%% Split Data -- Normal CE 
CE_train = datasample(normalCE, trs, 'Replace', false);
CE_test = datasample(setdiff(normalCE, CE_train, 'rows'), tes, 'Replace', false);

%% Training 
for i=1:10
 ens = ensemble_training(UE_train, CE_train);
%% Testing
if flag == 0
    testdata = [UE_test; CE_test];
elseif flag == 1
    testdata = [UE_test; AntiCE_test];
elseif flag ==2
    testdata = [UE_test; AntiCE_unv_test];
end

%% Computing TPR & TNR
results = ensemble_testing(testdata,ens);
TPR = TPR + length(find(results.predictions(501:1000, 1)==1))/500;
TNR = TNR + length(find(results.predictions(1:500, 1)==-1))/500;
end
TPR/10
TNR/10