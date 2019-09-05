function [glcmor,h1] = SecondOrderFeatExt(input)
% %function h1 = SecondOrderFeatExt(input)
% 
% 
% 

if ndims(input)==3
    img = rgb2gray(input);
else
    img = input;
end
%Detector parameters
windowsSize=7;%median filter lenght
lungh=3;%low pass filter lenght
l=-3; u=1; %parameters for histogram bin selection
Nbin=20;% half of the number of histogram bins

%compute co-occurrency matrices for all images
 offsets = [-1 1];
 
 glcmor = graycomatrix(img,'NumLevels',256,'Offset',offsets);
 ss=sum(glcmor(:));
 glcmor=glcmor/ss;
 
 %compute column-wise standard deviation for each matrix
     varor=std(glcmor(:,2:255,1));

%compute low pass (LP) and its median filtered version (LPM)
     filtromedia=ones(1,lungh)/lungh;
     varorlp = filter(filtromedia, 1, varor);
     varorlpmed=medfilt1(varorlp,windowsSize);
%Compute and normalize signal d = LP-LPM for each signal
     sor=varorlp-varorlpmed;
     Xmin=min(sor);
     Xmax=max(sor);
     sor=(sor)/(Xmax-Xmin);
%compute bin centers 
     ls=logspace(l,u,Nbin)/Nbin;
     BIN=[-ls(end:-1:1) ls];
%compute histogram
     h1=hist(sor,BIN);
     
end

% % input = uint8(input) + 1;
% 
% %Get the GLCM of the input image
% % temp = glcm(input);
% 
% %Get standard deviation of each column
% GLCMstd = std(input);
% 
% %Apply Mean filter to the std plot
% h = fspecial('average',3);
% GLCMstdLP = imfilter(GLCMstd,h);
% 
% %Apply Median filter to the mean filtered std plot
% GLCMstdLPM = medfilt1(GLCMstdLP,7);
% 
% %Get difference and normalize
% diffvec = GLCMstdLPM - GLCMstdLP;
% normvec = diffvec./(max(diffvec) - min(diffvec));
% 
% %Get the histogram feature vector
% u = 1; l = -3; Nb = 20;
% xvalues = zeros(1,2*Nb);
% del = (u - l)/(Nb - 1);
% for i = 1 : 20
%     xvalues(1,i+20) = (10^(l+(i-1)*del))/Nb;
% end
% xvalues(1,1:20) = -xvalues(1,40:-1:21);
% 
% %Final feature vector
% histvec = hist(normvec,xvalues);
% output = histvec./sum(histvec);