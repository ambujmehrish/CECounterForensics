function [authacc,forgeacc,avgacc] = rbfsvm_cv(TPMsingle,TPMdouble,c,g)
% linearsvm_cv(TPMsingle,TPMdouble)
%ensemble cross validate


traindata1=[TPMsingle(1:2:end-1,:);TPMdouble(1:2:end-1,:)];
trainlabel(1:size(TPMsingle,1)/2,1)=1;trainlabel(size(TPMsingle,1)/2+1:size(TPMsingle,1),1)=-1;
testdata1=[TPMsingle(2:2:end,:);TPMdouble(2:2:end,:)];
svm=svmtrain(trainlabel,traindata1,['-t 2 -h 0 -c ' num2str(c) ' -g ' num2str(g)]);
[zz1,acc1,zzzz1]=svmpredict(trainlabel,testdata1,svm);
authacc1=length(find(zz1(1:size(TPMsingle,1)/2,1)==1))/(size(TPMsingle,1)/2);
forgeacc1=length(find(zz1(size(TPMsingle,1)/2+1:size(TPMsingle,1),1)==-1))/(size(TPMsingle,1)/2);


traindata2=[TPMsingle(1:2:end-1,:);TPMdouble(2:2:end,:)];
testdata2=[TPMsingle(2:2:end,:);TPMdouble(1:2:end-1,:)];
svm=svmtrain(trainlabel,traindata2,['-t 2 -h 0 -c ' num2str(c) ' -g ' num2str(g)]);
[zz2,acc2,zzzz2]=svmpredict(trainlabel,testdata2,svm);
authacc2=length(find(zz2(1:size(TPMsingle,1)/2,1)==1))/(size(TPMsingle,1)/2);
forgeacc2=length(find(zz2(size(TPMsingle,1)/2+1:size(TPMsingle,1),1)==-1))/(size(TPMsingle,1)/2);

traindata3=[TPMsingle(2:2:end,:);TPMdouble(1:2:end-1,:)];
testdata3=[TPMsingle(1:2:end-1,:);TPMdouble(2:2:end,:)];
svm=svmtrain(trainlabel,traindata3,['-t 2 -h 0 -c ' num2str(c) ' -g ' num2str(g)]);
[zz3,acc3,zzzz3]=svmpredict(trainlabel,testdata3,svm);
authacc3=length(find(zz3(1:size(TPMsingle,1)/2,1)==1))/(size(TPMsingle,1)/2);
forgeacc3=length(find(zz3(size(TPMsingle,1)/2+1:size(TPMsingle,1),1)==-1))/(size(TPMsingle,1)/2);

traindata7=[TPMsingle(2:2:end,:);TPMdouble(2:2:end,:)];
testdata7=[TPMsingle(1:2:end-1,:);TPMdouble(1:2:end-1,:)];
svm=svmtrain(trainlabel,traindata7,['-t 2 -h 0 -c ' num2str(c) ' -g ' num2str(g)]);
[zz7,acc7,zzzz7]=svmpredict(trainlabel,testdata7,svm);
authacc7=length(find(zz7(1:size(TPMsingle,1)/2,1)==1))/(size(TPMsingle,1)/2);
forgeacc7=length(find(zz7(size(TPMsingle,1)/2+1:size(TPMsingle,1),1)==-1))/(size(TPMsingle,1)/2);

authacc = (authacc1+authacc2+authacc3+authacc7)/4;
forgeacc = (forgeacc1+forgeacc2+forgeacc3+forgeacc7)/4;
avgacc = (acc1(1,1)+acc2(1,1)+acc3(1,1)+acc7(1,1))/4;

end