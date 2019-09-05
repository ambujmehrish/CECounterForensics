clear all
x = 0;
y = 1;
ImageFld = '256_CE_Uniform_Dataset\AntiCE';

% S = table([{0;1;2;1;1;1},{1;0;0;1;2;3}]);
Images = dir([ImageFld,'\*.jpeg']);
% for k = 1:size(S,1)
%     a = cell2mat(table2array(S(k,1)));
for i = 1:100
    disp(['Processing Image:-',num2str(i)])
    img = imread(Images(i).name);
%      f = extractFreq(img,a(1),a(2));
     f = extractFreq(img,x,y);
     if i ==1
         F = f;
     else
         F = [F,f];
     end
end
%      if k ==1
%          features = f;
%      else
%          features = [features,F];
%      end
% end
histfitlaplace(F,'b')