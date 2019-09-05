clear
close all
%d = load('Distance_AntiCE_20.mat');
d = load('256_CE_Exponential_Dataset\Distance_AntiCE_Exp');
distance = double(d.distance);
UE = distance(1:500,1);
CE = distance(501:1000,1);
th = (max(distance)+1):-0.1:(min(distance)-1);
for i = 1:size(th,2)
    
[TP,TN,FP,FN,A] = computeROC(distance,th(1,i));

TPR(i,1) = TP/size(CE,1);
FPR(i,1) = FP/size(UE,1);
TNR(i,1) = TN/size(UE,1);
FNR(i,1) = FN/size(CE,1); 
Acc(i,1) = A;
end
Z_CE = trapz(FPR,TPR);
plot(FPR,TPR,'b')