% driver script for psnr values
%%
clear

%---- Anti - Processed Images --------
allFiles = dir('E:\SaurabhAndProtichi MMSEC\NLFE images BOSS mod param\256_CE_Dataset\Testing\*.tiff'); %change folder
baseFileNames = {allFiles.name};
numberOfFiles = length(baseFileNames);

for i = 1:numberOfFiles
    
   filename = allFiles(i).name;
   fullname = strcat('E:\SaurabhAndProtichi MMSEC\NLFE images BOSS mod param\256_CE_Dataset\Testing\',filename); %change folder
   anti{i}=imread(fullname);
   
end


%---- Original Images --------
allFiles = dir('E:\SaurabhAndProtichi MMSEC\NLFE images BOSS mod param\256_CE_Dataset\256Original Images\*.tiff'); % change folder
baseFileNames = {allFiles.name};

for i = 1:numberOfFiles
    
   filename = allFiles(i).name;
   fullname = strcat('E:\SaurabhAndProtichi MMSEC\NLFE images BOSS mod param\256_CE_Dataset\256Original Images\',filename); % change folder
   original{i}=imread(fullname);
   
end


%---- Calculate PSNR --------
for i= 1:numberOfFiles
   psnrVal{i} = psnr(anti{i}, original{i});
end

sum=0;
for i=1:numberOfFiles
    sum = sum + psnrVal{i};
end

numberOfFiles
sum
sum/numberOfFiles