clear 
clc
close all
% Alpha =0.2; %[0.2,1,3,5]
% Beta =  12;% [0.5,1,12,20]
% Gamma = 0.08;% [0.08,0.8,1,2]
% Delta =  0.5;% [0.5,1,5,10]
n = 4000;
m = 1000;
% offsets = [-1 1];
% set = 1:10000;
% set1 = randperm(10000,n);
% tempset = setdiff(set,set1);
% pos = randperm(length(tempset),m);
% set2 = tempset(pos);
data = [];
labels = [];
%% Unaltered
index = 0;
%save('Database\DL\Training\Case2\Training-Set','set1')
load('Database\DL\Training\Case2\Training-Set.mat')
%save('Database\DL\Testing\Case2\Testing-Set','set2')
load('Database\DL\Testing\Case2\Testing-Set.mat')
for i = 1:n
%  display(num2str(i));
%  img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
%  img = img(121:376,121:376);
%  S = graycomatrix(img,'NumLevels',256,'Offset',offsets);
 S = imread(['Database\DL\Training\Case2\Unaltered\Unaltered-',num2str(set1(i)),'.jpeg']);
%  imwrite(single(S),['Database\DL\Training\Case2\Unaltered\Unaltered-',num2str(set1(i)),'.jpeg'],'quality',100);
 imshow(single(S))
 index = index +1;
 disp(index)
 data(:,:,index) = single(S);
 labels(1,index) = 1;
end
%% dithering Noise
for i = 1:n
%  display(num2str(i));
%  img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
%  img = img(121:376,121:376);
%  gamma = 0.001 + (0.02-0.001)*rand(1,1);
%  [antiCE,PSNR,SSIM] = Attack_CE_hiding(img,gamma,'gamma');
%  S = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
  S = imread(['Database\DL\Training\Case2\GD\GD-',num2str(set1(i)),'.jpeg']);
%  imwrite(single(S),['Database\DL\Training\Case2\GD\GD-',num2str(set1(i)),'.jpeg'],'quality',100);
 imshow(single(S))
 index = index + 1;
 disp(index)
 data(:,:,index) = single(S);
 labels(1,index) = 2;
end
%% TV
  for i = 1:n
%   display(num2str(i));
%   img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
%   img = img(121:376,121:376);
%   gamma = 0.001 + (0.02-0.001)*rand(1,1);
%   [normalCE,antiCE] = perform_CE(img,gamma);
  %S = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
  S = imread(['Database\DL\Training\Case2\TV\TV-',num2str(set1(i)),'.jpeg']);
  %imwrite(single(S),['Database\DL\Training\Case2\TV\TV-',num2str(set1(i)),'.jpeg'],'quality',100);
  imshow(single(S))
  index = index + 1;
  disp(index)
  data(:,:,index) = single(S);
  labels(1,index) = 2;
  end
  %% Proposed
 for i = 1:n
%   display(num2str(i));
%   img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
%   img = img(121:376,121:376);
%   gamma = 0.001 + (0.02-0.001)*rand(1,1);
%   [normalCE,antiCE] = MRFanti_grad(img,50,gamma,'CE',Alpha,Beta,Gamma,Delta);
%   S = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
   S = imread(['Database\DL\Training\Case2\Proposed\Proposed-',num2str(set1(i)),'.jpeg']);
%   imwrite(single(S),['Database\DL\Training\Case2\Proposed\Proposed-',num2str(set1(i)),'.jpeg'],'quality',100);
  imshow(single(S))
  index = index + 1;
  disp(index)
  data(:,:,index) = single(S);
  labels(1,index) = 2;
 end
 data = reshape(data,1,size(data,1),size(data,2),size(data,3));
 images.data = data;
 images.labels = labels;
 save('Database\DL\Training\Case2\Imdb256TrainVLCASE2.mat','images','-v7.3')
 
 clear data images labels
 data = [];
 labels = [];
 %% Unaltred Testing
 index = 0;
for i = 1:m
%  display(num2str(i));
%  img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
%  img = img(121:376,121:376);
%  S = graycomatrix(img,'NumLevels',256,'Offset',offsets);
  S = imread(['Database\DL\Testing\Case2\Unaltered\Unaltered-',num2str(set2(i)),'.jpeg']);
 imwrite(single(S),['Database\DL\Testing\Case2\Unaltered\Unaltered-',num2str(set2(i)),'.jpeg'],'quality',100);
 imshow(single(S))
 index = index +1;
 disp(index)
 data(:,:,index) = single(S);
 labels(1,index) = 1;
end
%% dithering Noise Testing
for i = 1:m
%  display(num2str(i));
%  img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
%  img = img(121:376,121:376);
%  gamma = 0.001 + (0.02-0.001)*rand(1,1);
%  [antiCE,PSNR,SSIM] = Attack_CE_hiding(img,gamma,'gamma');
%  S = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
 S = imread(['Database\DL\Testing\Case2\GD\GD-',num2str(set2(i)),'.jpeg']);
%  imwrite(single(S),['Database\DL\Testing\Case2\GD\GD-',num2str(set2(i)),'.jpeg'],'quality',100);
 imshow(single(S))
 index = index + 1;
 disp(index)
 data(:,:,index) = single(S);
 labels(1,index) = 2;
end
%% TV Testing
  for i = 1:m
%   display(num2str(i));
%   img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
%   img = img(121:376,121:376);
%   gamma = 0.001 + (0.02-0.001)*rand(1,1);
%   [normalCE,antiCE] = perform_CE(img,gamma);
 % S = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
  S = imread(['Database\DL\Testing\Case2\TV\TV-',num2str(set2(i)),'.jpeg']);
 % imwrite(single(S),['Database\DL\Testing\Case2\TV\TV-',num2str(set2(i)),'.jpeg'],'quality',100);
  imshow(single(S))
  index = index + 1;
  disp(index)
  data(:,:,index) = single(S);
  labels(1,index) = 2;
  end
  %% Proposed Testing
for i = 1:m
%   display(num2str(i));
%   img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
%   img = img(121:376,121:376);
%   gamma = 0.001 + (0.02-0.001)*rand(1,1);
%   [normalCE,antiCE] = MRFanti_grad(img,50,gamma,'CE',Alpha,Beta,Gamma,Delta);
%   S = graycomatrix(uint8(antiCE),'NumLevels',256,'Offset',offsets);
    S = imread(['Database\DL\Testing\Case2\Proposed\Proposed-',num2str(set2(i)),'.jpeg']);
 % imwrite(single(S),['Database\DL\Testing\Case2\Proposed\Proposed-',num2str(set2(i)),'.jpeg'],'quality',100);
  imshow(single(S))
  index = index + 1;
  disp(index)
  data(:,:,index) = single(S);
  labels(1,index) = 2;
 end
 data = reshape(data,1,size(data,1),size(data,2),size(data,3));
 images.data = data;
 images.labels = labels;
 save('Database\DL\Testing\Case2\Imdb256testCASE2.mat','images','-v7.3')
%  