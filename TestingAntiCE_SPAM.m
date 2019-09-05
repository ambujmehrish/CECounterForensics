
disp('featAntiCE');
clear 
disp('loading .mat file');
addpath('E:\Hareesh MMSEC\3. AllEnhancementAntiForensics')
load('256_CE_Exponential_Dataset\SPAM_AntiCE_256.mat')
load('256_CE_[20]_Dataset\SPAM_AntiCE_20_256.mat')
load('256_CE_Exponential_Dataset\SPAM_CE_256.mat')
load('256_CE_Exponential_Dataset\SPAM_OI_256.mat')
load('256_CE_unv_Dataset\SPAM_AntiCE_unv_256.mat')
disp('ensemble training');
TPR = 0 ;
TNR = 0;
itr = 10;
trs = 1500; % Training Samples 25%, 50% , 75%
tes = 500; % Testing Samples Fixed
%% Flag 0 --> Normal CE 1--> AntiCE Proposed 2 --> AntiCE [18] 3 --> AntiCE [20]
flag = 0; 
distance = single(zeros(tes*2,1));
%% 10 fold Validation
for i= 1:itr
%% Split Data -- Original Images
UE_train = datasample(SPAM_OI, trs, 'Replace', false);
UE_test = datasample(setdiff(SPAM_OI, UE_train, 'rows'), tes, 'Replace', false);
%% Split Data -- Anti CE Proposed
 AntiCE_train = datasample(SPAM_AntiCE, trs, 'Replace', false);
 AntiCE_test = datasample(setdiff(SPAM_AntiCE, AntiCE_train, 'rows'), tes, 'Replace', false);
%% Split Data -- Anti CE [18]
 AntiCE_unv_train = datasample(SPAM_AntiCE_unv, trs, 'Replace', false);
 AntiCE_unv_test = datasample(setdiff(SPAM_AntiCE_unv, AntiCE_unv_train, 'rows'), tes, 'Replace', false);
 %% Split Data --- AntiCE [20]
 AntiCE_20_train = datasample(SPAM_AntiCE_20, trs, 'Replace', false);
 AntiCE_20_test = datasample(setdiff(SPAM_AntiCE_20, AntiCE_20_train, 'rows'), tes, 'Replace', false);
%% Split Data -- Normal CE 
CE_train = datasample(SPAM_CE, trs, 'Replace', false);
CE_test = datasample(setdiff(SPAM_CE, CE_train, 'rows'), tes, 'Replace', false);
%% Training 
 ens = ensemble_training(UE_train, CE_train);
%% Testing
if flag == 0
    testdata = [UE_test; CE_test];
elseif flag == 1
    testdata = [UE_test; AntiCE_test];
elseif flag ==2
    testdata = [UE_test; AntiCE_unv_test];
elseif flag ==3
    testdata = [UE_test; AntiCE_20_test];
end

%% Computing TPR & TNR
results = ensemble_testing(testdata,ens);
% distance = results.votes;
distance = results.votes;
UE = distance(1:500,1);
CE = distance(501:1000,1);
th = 200:-0.1:-200;
for t = 1:size(th,2)
    
[TP,TN,FP,FN,A] = computeROC(distance,th(1,t));
TPR(t,i) = TP/size(CE,1);
FPR(t,i) = FP/size(UE,1);
TNR(t,i) = TN/size(UE,1);
FNR(t,i) = FN/size(CE,1); 
Acc(t,i) = A;
end
%TPR = TPR + length(find(results.predictions(501:1000, 1)==1))/500;
% TNR = TNR + length(find(results.predictions(1:500, 1)==-1))/500;
%length(find(results.predictions(3751:5000, 1)==1))/1250
% disp('2DCT 50%original 50%AntiCE');
end
avg_TPR = sum(TPR,2)/itr;
avg_TNR = sum(TNR,2)/itr;
avg_FNR = sum(FNR,2)/itr;
avg_FPR = sum(FPR,2)/itr;
avg_Acc = sum(Acc,2)/itr;
% TPR/itr
% TNR/itr
% save('Distance_SPAM_AntiCE_20','distance')