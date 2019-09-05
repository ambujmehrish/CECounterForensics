clear 
clc
close all
%  Alpha =0.2; %[0.2,1,3,5]
%  Beta =  12;% [0.5,1,12,20]
%  Gamma = 0.08;% [0.08,0.8,1,2]
%  Delta =  0.5;% [0.5,1,5,10]
n = 8000;
m = 2000;
trainmethod = 'CLAHE';
testmethod = 'Proposed';
   offsets = [-1 1];
%   set = 1:10000;
%   set1 = randperm(10000,n);
%   tempset = setdiff(set,set1);
%   pos = randperm(length(tempset),m);
%   set2 = tempset(pos);
data = [];
labels = [];
 index = 0;
% save('Database\DL\Training\Case3\Training-Set','set1')
 load('Database\DL\Training\Case3\Training-Set.mat')
% save('Database\DL\Testing\Case3\Testing-Set','set2')
 load('Database\DL\Testing\Case3\Testing-Set.mat')
%% Unaltered
if 0
for i = 1:4000
%   display(num2str(i));
%   img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
%   img = img(121:376,121:376);
%   S = graycomatrix(img,'NumLevels',256,'Offset',offsets);
 S = imread(['Database\DL\Training\Case3\Unaltered\Unaltered-',num2str(set1(i)),'.jpeg']);
%   imwrite(single(S),['Database\DL\Training\Case3\Unaltered\Unaltered-',num2str(set1(i)),'.jpeg'],'quality',100);
% %imshow(single(S))
 index = index +1;
 disp(index)
 data(:,:,index) = single(S);
 labels(1,index) = 1;
end
%% Gamma Correction
for i = 1:4000
% display(num2str(i));
 img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
 img = img(121:376,121:376);
 gamma = 0.1 + (1.5-0.1)*rand(1,1);
 img_gc = uint8(255.*((double(img)./255).^(gamma)));
 S = graycomatrix(img_gc,'NumLevels',256,'Offset',offsets);
%  %imshow(single(S))
 index = index + 1;
 disp(index)
 data(:,:,index) = single(S);
 labels(1,index) = 2;
end
%% Histogram Streching
 for i = 1:4000
 % display(num2str(i));
  img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
  img = img(121:376,121:376);
  %gamma = 0.01 + (0.99-0.01)*rand(1,1);
  img_hs = imadjust(img,stretchlim(img),[]);
  S = graycomatrix(img_hs,'NumLevels',256,'Offset',offsets);
%   %imshow(single(S))
  index = index + 1;
  disp(index)
  data(:,:,index) = single(S);
  labels(1,index) = 2;
  end


%% CLAHE
%if strcmp(trainmethod,'CLAHE')
  for i = 1:4000
%   display(num2str(i));
%  img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
%   img = img(121:376,121:376);
%   gamma = 0.001 + (0.02-0.001)*rand(1,1);
%   img_clahe = adapthisteq(img,'ClipLimit',gamma);
%   S = graycomatrix(uint8(img_clahe),'NumLevels',256,'Offset',offsets);
  S = imread(['Database\DL\Training\Case3\CLAHE\CLAHE-',num2str(set1(i)),'.jpeg']);
%   imwrite(single(S),['Database\DL\Training\Case3\CLAHE\CLAHE-',num2str(set1(i)),'.jpeg'],'quality',100);
  %%imshow(single(S))
  index = index + 1;
  disp(index)
  data(:,:,index) = single(S);
  labels(1,index) = 2;
  end
%end
%% dithering Noise
%if strcmp(trainmethod,'GD')
for i = 1:4000
%  display(num2str(i));
%  img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
%  img = img(121:376,121:376);
%  gamma = 0.001 + (0.02-0.001)*rand(1,1);
%  [antiCE,PSNR,SSIM] = Attack_CE_hiding(img,gamma,'gamma');
%  S = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
  S = imread(['Database\DL\Training\Case3\GD\GD-',num2str(set1(i)),'.jpeg']);
%   imwrite(single(S),['Database\DL\Training\Case3\GD\GD-',num2str(set1(i)),'.jpeg'],'quality',100);
 %%imshow(single(S))
 index = index + 1;
 disp(index)
 data(:,:,index) = single(S);
 labels(1,index) = 2;
end
%end
%% TV
%if strcmp(trainmethod,'TV')
  for i = 1:n/2
  display(num2str(i));
%  img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
%   img = img(121:376,121:376);
%   gamma = 0.001 + (0.02-0.001)*rand(1,1);
%   [normalCE,antiCE] = perform_CE(img,gamma);
%   S = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
  S = imread(['Database\DL\Training\Case3\TV\TV-',num2str(set1(i)),'.jpeg']);
%   imwrite(single(S),['Database\DL\Training\Case3\TV\TV-',num2str(set1(i)),'.jpeg'],'quality',100);
  %%imshow(single(S))
  index = index + 1;
  disp(index)
  data(:,:,index) = single(S);
  labels(1,index) = 2;
  end
%end
  %% Proposed
%  if strcmp(trainmethod,'Proposed')
 for i = 1:n/2
  display(num2str(i));
%  img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
%   img = img(121:376,121:376);
%   gamma = 0.001 + (0.02-0.001)*rand(1,1);
%   [normalCE,antiCE] = MRFanti_grad(img,50,gamma,'CE',Alpha,Beta,Gamma,Delta);
%   S = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
   S = imread(['Database\DL\Training\Case3\Proposed\Proposed-',num2str(set1(i)),'.jpeg']);
%    imwrite(single(S),['Database\DL\Training\Case3\Proposed\Proposed-',num2str(set1(i)),'.jpeg'],'quality',100);
  %imshow(single(S))
  index = index + 1;
  disp(index)
  data(:,:,index) = single(S);
  labels(1,index) = 2;
 end
%  end
 data = reshape(data,1,size(data,1),size(data,2),size(data,3));
 images.data = data;
 images.labels = labels;
 save('Database\DL\Training\Case3\Imdb256TrainVLCASE3.mat','images','-v7.3')
 
 clear data images labels
 data = [];
 labels = [];
 end
 %% ---------------------------------------Testing ---------------------------------%%
 %% Unaltred Testing
  index = 0;
for i = 1:1000
%  display(num2str(i));
%  img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
%  img = img(121:376,121:376);
%  S = graycomatrix(img,'NumLevels',256,'Offset',offsets);
  S = imread(['Database\DL\Testing\Case3\Unaltered\Unaltered-',num2str(set2(i)),'.jpeg']);
%  imwrite(single(S),['Database\DL\Testing\Case3\Unaltered\Unaltered-',num2str(set2(i)),'.jpeg'],'quality',100);
 %imshow(single(S))
 index = index +1;
 disp(index)
 data(:,:,index) = single(S);
 labels(1,index) = 1;
end
for i = 1:1000
%  display(num2str(i));
 img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
 img = img(121:376,121:376);
 gamma = 0.1 + (1.5-0.1)*rand(1,1);
 img_gc = uint8(255.*((double(img)./255).^(gamma)));
 S = graycomatrix(img_gc,'NumLevels',256,'Offset',offsets);
 %imshow(single(S))
 index = index + 1;
 disp(index)
 data(:,:,index) = single(S);
 labels(1,index) = 2;
end
%% Histogram Streching
 for i = 1:1000
%   display(num2str(i));
  img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
  img = img(121:376,121:376);
  %gamma = 0.01 + (0.99-0.01)*rand(1,1);
  img_hs = imadjust(img,stretchlim(img),[]);
  S = graycomatrix(img_hs,'NumLevels',256,'Offset',offsets);
  %imshow(single(S))
  index = index + 1;
  disp(index)
  data(:,:,index) = single(S);
  labels(1,index) = 2;
  end
%% CLAHE
if strcmp(testmethod,'normal')
 for i = 1:m/2
%   display(num2str(i));
% img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
%   img = img(121:376,121:376);
%   gamma = 0.001 + (0.02-0.001)*rand(1,1);
%   img_clahe = adapthisteq(img,'ClipLimit',gamma);
%   S = graycomatrix(uint8(img_clahe),'NumLevels',256,'Offset',offsets);
  S = imread(['Database\DL\Testing\Case3\CLAHE\CLAHE-',num2str(set2(i)),'.jpeg']);
%   imwrite(single(S),['Database\DL\Testing\Case3\CLAHE\CLAHE-',num2str(set1(i)),'.jpeg'],'quality',100);
  %imshow(single(S))
  index = index + 1;
  disp(index)
  data(:,:,index) = single(S);
  labels(1,index) = 2;
 end
end
%% dithering Noise Testing
if strcmp(testmethod,'GD')
for i = 1:1000
%  display(num2str(i));
% img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
%  img = img(121:376,121:376);
%  gamma = 0.001 + (0.02-0.001)*rand(1,1);
%  [antiCE,PSNR,SSIM] = Attack_CE_hiding(img,gamma,'gamma');
%  S = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
 S = imread(['Database\DL\Testing\Case3\GD\GD-',num2str(set2(i)),'.jpeg']);
%  imwrite(single(S),['Database\DL\Testing\Case3\GD\GD-',num2str(set2(i)),'.jpeg'],'quality',100);
 %imshow(single(S))
 index = index + 1;
 disp(index)
 data(:,:,index) = single(S);
 labels(1,index) = 2;
end
end
%% TV Testing
if strcmp(testmethod,'TV')
  for i = 1:1000
%   display(num2str(i));
% img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
%   img = img(121:376,121:376);
%   gamma = 0.001 + (0.02-0.001)*rand(1,1);
%   [normalCE,antiCE] = perform_CE(img,gamma);
%  S = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
  S = imread(['Database\DL\Testing\Case3\TV\TV-',num2str(set2(i)),'.jpeg']);
%  imwrite(single(S),['Database\DL\Testing\Case3\TV\TV-',num2str(set2(i)),'.jpeg'],'quality',100);
  %imshow(single(S))
  index = index + 1;
  disp(index)
  data(:,:,index) = single(S);
  labels(1,index) = 2;
  end
end
  %% Proposed Testing
  if strcmp(testmethod,'Proposed')
for i = 1:m/2
%   display(num2str(i));
%  img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
%   img = img(121:376,121:376);
%   gamma = 0.001 + (0.02-0.001)*rand(1,1);
%   [normalCE,antiCE] = MRFanti_grad(img,50,gamma,'CE',Alpha,Beta,Gamma,Delta);
%   S = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
    S = imread(['Database\DL\Testing\Case3\Proposed\Proposed-',num2str(set2(i)),'.jpeg']);
%   imwrite(single(S),['Database\DL\Testing\Case3\Proposed\Proposed-',num2str(set2(i)),'.jpeg'],'quality',100);
  %imshow(single(S))
  index = index + 1;
  disp(index)
  data(:,:,index) = single(S);
  labels(1,index) = 2;
end
  end
 data = reshape(data,1,size(data,1),size(data,2),size(data,3));
 images.data = data;
 images.labels = labels;
 save('Database\DL\Testing\Case3\Imdb256testCASE3_Proposed.mat','images','-v7.3')
%  