function [maxacc,cc,gg] = grid_svm (posclass,negclass)
%function [maxacc,c,gamma] = grid_svm (posclass,negclass);

%This function performs grid search over the specified limits of C and
%Gamma for RBF kernel SVM while performing "N" fold cross validation for
%each "c" and "g". The final "cc" and "gg" are those that gave the maximum
%accuracy "maxacc" for the "N" fold cross validation. This function uses
%LIBSVMs svmtrain and svmpredict functions and assumes those functions are
%in the workspace.

maxacc = 0; %Initialize maxacc
c = 0.1; %cost starting value
N = 5; %no of folds
percent = 0.5; %percentage of training samples from overall data

while c<10
    g=0.01;
    while g<2
        [authacc,forgeacc,avgacc] = rbfsvm_cv_var(posclass,negclass,c,g,percent,N);
        if avgacc>maxacc
            maxacc=avgacc;
            authacc1=authacc;forgeacc1=forgeacc;
            cc=c;
            gg=g;
        end
        g=g+g;
    end
    c=c+1;
end

disp(maxacc);disp(authacc1);disp(forgeacc1);
cc
gg
% disp ('maximum accuracy acheived is: ',maxacc);
% disp ('optimum c and gamma are: ',cc,gg);
end

function [authacc,forgeacc,avgacc] = rbfsvm_cv_var(posclass,negclass,c,g,percent,N)
% [authacc,forgeacc,avgacc] = rbfsvm_cv_var(TPMsingle,TPMdouble,c,g,percent)

%Perform N fold cross validation for "percent" % training and rest testing
%by randomly selecting "percent%" of data from two classes for training and
%rest for testing. This gives the average accuracy for the "N" folds of
%training and testing for the specific "c" and "gamma".

authacc = zeros(N,1);
forgeacc = zeros(N,1);

for i = 1 : N

    randarr = randperm(size(posclass,1),size(posclass,1));

    traindata = [posclass(randarr(1:ceil(percent*length(randarr))),:);negclass(randarr(1:ceil(percent*length(randarr))),:)];
    trainlabel(1:size(traindata,1)/2,1)=1;trainlabel(size(traindata,1)/2+1:size(traindata,1),1)=-1;

    testdata = [posclass(randarr(ceil(percent*length(randarr))+1:end),:);negclass(randarr(ceil(percent*length(randarr))+1:end),:)];
    testlabel(1:size(testdata,1)/2,1)=1;testlabel(size(testdata,1)/2+1:size(testdata,1),1)=-1;

    svm=svmtrain(trainlabel,traindata,['-t 2 -h 0 -c ' num2str(c) ' -g ' num2str(g)]);

    [zz1,~,~]=svmpredict(testlabel,testdata,svm);

    authacc(i,1)=length(find(zz1(1:size(testdata,1)/2,1)==1))/(size(testdata,1)/2);
    forgeacc(i,1)=length(find(zz1(size(testdata,1)/2+1:size(testdata,1),1)==-1))/(size(testdata,1)/2);

end

authacc = (sum(authacc)/5)*100;
forgeacc = (sum(forgeacc)/5)*100;
avgacc = (authacc+forgeacc)/2;
    
end