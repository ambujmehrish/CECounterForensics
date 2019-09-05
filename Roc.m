clear 
close all

load('Distance_CE.mat')
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
hold on
clear FPR TPR distance Acc
load('Distance_AntiCE.mat')
th = (max(distance)+1):-0.01:(min(distance)-1);
for i = 1:size(th,2)
    
[TP,TN,FP,FN,A] = computeROC(distance,th(1,i));

TPR(i,1) = TP/size(CE,1);
FPR(i,1) = FP/size(UE,1);
TNR(i,1) = TN/size(UE,1);
FNR(i,1) = FN/size(CE,1); 
Acc(i,1) = A;
end
Z_AntiCE = trapz(FPR,TPR);
plot(FPR,TPR,'r')
hold on
clear FPR TPR distance Acc
load('Distance_AntiCE_Alpha0.mat')
th = (max(distance)+1):-0.01:(min(distance)-1);
for i = 1:size(th,2)
    
[TP,TN,FP,FN,A] = computeROC(distance,th(1,i));

TPR(i,1) = TP/size(CE,1);
FPR(i,1) = FP/size(UE,1);
TNR(i,1) = TN/size(UE,1);
FNR(i,1) = FN/size(CE,1); 
Acc(i,1) = A;
end
Z_AntiCE = trapz(FPR,TPR);
plot(FPR,TPR,'g')
hold on
clear FPR TPR distance Acc
load('Distance_AntiCE_unv.mat')
th = (max(distance)+1):-0.01:(min(distance)-1);
for i = 1:size(th,2)
    
[TP,TN,FP,FN,A] = computeROC(distance,th(1,i));

TPR(i,1) = TP/size(CE,1);
FPR(i,1) = FP/size(UE,1);
TNR(i,1) = TN/size(UE,1);
FNR(i,1) = FN/size(CE,1); 
Acc(i,1) = A;
end
plot(FPR,TPR,'m')

%Acc = (TP+TN)/(TP+TN+FP+FN);