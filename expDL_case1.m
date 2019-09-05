clear 
clc
n = 4000;
m = 1000;
offsets = [-1 1];
set = 1:10000;
set1 = randperm(10000,n);
tempset = setdiff(set,set1);
pos = randperm(length(tempset),m);
set2 = tempset(pos);
data = [];
label = [];
%% Unaltered
for i = 1:n
 display(num2str(i));
 img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
 img = img(121:376,121:376);
 S = graycomatrix(img,'NumLevels',256,'Offset',offsets);
 imshow(single(S))
 index = 4*i-3;
 data(:,:,index) = single(S);
 labels(1,index) = 1;
end
%% Gamma Correction
for i = 1:n
 display(num2str(i));
 img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
 img = img(121:376,121:376);
 gamma = 0.1 + (1.5-0.1)*rand(1,1);
 img_gc = uint8(255.*((double(img)./255).^(gamma)));
 S = graycomatrix(img_gc,'NumLevels',256,'Offset',offsets);
 imshow(single(S))
 index = 4*i-2;
 data(:,:,index) = single(S);
 labels(1,index) = 2;
end

  for i = 1:n
  display(num2str(i));
  img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
  img = img(121:376,121:376);
  %gamma = 0.01 + (0.99-0.01)*rand(1,1);
  img_hs = imadjust(img,stretchlim(img),[]);
  S = graycomatrix(img_hs,'NumLevels',256,'Offset',offsets);
  imshow(single(S))
  index = 4*i-1;
  data(:,:,index) = single(S);
  labels(1,index) = 2;
  end
  %% CLAHE
 for i = 1:n
  display(num2str(i));
  img = imread(['Database\BOSS\',num2str(set1(i)),'.pgm']);
  img = img(121:376,121:376);
  gamma = 0.001 + (0.02-0.001)*rand(1,1);
  img_clahe = adapthisteq(img,'ClipLimit',gamma);
  S = graycomatrix(img_clahe,'NumLevels',256,'Offset',offsets);
  imshow(single(S))
  index = 4*i;
  data(:,:,index) = single(S);
  labels(1,index) = 2;
 end
 data = reshape(data,1,size(data,1),size(data,2),size(data,3));
 images.data = data;
 images.labels = labels;
 save('Database\DL\Training\Case1\Imdb256TrainValCASE1.mat','images','-v7.3')
 clear images data labels
 for i = 1:m
 display(num2str(i));
 img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
 img = img(121:376,121:376);
 S = graycomatrix(img,'NumLevels',256,'Offset',offsets);
 imshow(single(S))
 index = 4*i-3;
 data(:,:,index) = single(S);
 labels(1,index) = 1;
end
%% Gamma Correction
for i = 1:m
 display(num2str(i));
 img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
 img = img(121:376,121:376);
 gamma = 0.1 + (1.5-0.1)*rand(1,1);
 img_gc = uint8(255.*((double(img)./255).^(gamma)));
 S = graycomatrix(img_gc,'NumLevels',256,'Offset',offsets);
 imshow(single(S))
 index = 4*i-2;
 data(:,:,index) = single(S);
 labels(1,index) = 2;
end

  for i = 1:m
  display(num2str(i));
  img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
  img = img(121:376,121:376);
  %gamma = 0.01 + (0.99-0.01)*rand(1,1);
  img_hs = imadjust(img,stretchlim(img),[]);
  S = graycomatrix(img_hs,'NumLevels',256,'Offset',offsets);
  imshow(single(S))
  index = 4*i-1;
  data(:,:,index) = single(S);
  labels(1,index) = 2;
  end
  %% CLAHE
 for i = 1:m
  display(num2str(i));
  img = imread(['Database\BOSS\',num2str(set2(i)),'.pgm']);
  img = img(121:376,121:376);
  gamma = 0.001 + (0.02-0.001)*rand(1,1);
  img_clahe = adapthisteq(img,'ClipLimit',gamma);
  S = graycomatrix(img_clahe,'NumLevels',256,'Offset',offsets);
  imshow(single(S))
  index = 4*i;
  data(:,:,index) = single(S);
  labels(1,index) = 2;
 end
 data = reshape(data,1,size(data,1),size(data,2),size(data,3));
 images.data = data;
 images.labels = labels;
 save('Database\DL\Testing\Case1\Imdb256testCASE1.mat','images','-v7.3')

 