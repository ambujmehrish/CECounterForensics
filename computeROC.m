function [TP,TN,FP,FN,Acc] = computeROC(distance,th)

N = distance(1:500,1);
P = distance(501:1000,1);

TP = size(find(P>th),1);
FP = size(find(N>th),1);
TN = size(find(N<th),1);
FN = size(find(P<th),1); 

Acc = (TP+TN)/(TP+TN+FN+FP);

end