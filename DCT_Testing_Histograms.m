function  v  =  DCT_Testing_Histograms()

%--------Comment lines below to remove matrices----------------------------
%D- Matrices
D = generateDMat2();
%DT = D.';
DT = D';
%I - Matrices
I1 = generateIMat(1,2);
I2 = generateIMat(2,1);
I3 = generateIMat(3,1);
I4 = generateIMat(2,2);
I5 = generateIMat(1,3);
I6 = generateIMat(1,4);

%---- Anti - Processed Images --------
allFiles = dir('E:\SaurabhAndProtichi MMSEC\NLFE images BOSS mod param\256_CE_Dataset\256NormalCE ProcessedImages\*.tiff'); %change folder
baseFileNames = {allFiles.name};
numberOfFiles = length(baseFileNames);


%numberOfFiles = 5;         %Uncomment to set no of files

%v = zeros(1024, 1);
counter = 0;

%for i = 1:numberOfFiles
    for i = 1:100
   filename = allFiles(i).name;
   fullname = strcat('E:\SaurabhAndProtichi MMSEC\NLFE images BOSS mod param\256_CE_Dataset\256NormalCE ProcessedImages\',filename); %change folder
   antiImg = imread(fullname);
   
   dctm = DCT( antiImg, D , DT , I4);
   
   for j = 2:8:256
       for i = 2:8:256
        counter = counter + 1;
        v(counter) = dctm(j,i);
        %v{counter}
       end
   end
    %i
    %counter
end

%disp(counter);

%{
%---- Original Images --------
allFiles = dir('E:\SaurabhAndProtichi MMSEC\NLFE images BOSS mod param\256_CE_Dataset\256Original Images\*.tiff'); % change folder
baseFileNames = {allFiles.name};

for i = 1:numberOfFiles
    
   filename = allFiles(i).name;
   fullname = strcat('E:\SaurabhAndProtichi MMSEC\NLFE images BOSS mod param\256_CE_Dataset\256Original Images\',filename); % change folder
   original{i}=imread(fullname);
   
end
%}

%---- Calculate PSNR --------
end


%--------------Code to generate DCT 256x256 diagonal-d matrix--------------
function DMat = generateDMat()
    DMat = zeros(256,256);
    d = dctmtx(8);
    for i = 1 : 8 : 256
        DMat(i:i+7 , i : i+7) = d;
    end
end

function DMat = generateDMat2()
    DMat = zeros(256,256);
    d = dctmtx(8);
    n = 32;
    Ac = repmat({d}, n, 1);
    DMat = blkdiag(Ac{:});
end

%-----------Function to Generate I Matrix 256x256--------------------------
function IMat = generateIMat(i,j)
    I = zeros(8,8);
    I(i,j) = 1;
    IMat = repmat(I , 32 , 32);
end

function dct = DCT( Img, D , DT , I1)
    %lambda = 1.00;
    lambda = 0.05;
    DCT = double(D)*double(Img)*double(DT);
    DCT = I1.*DCT;
   
    %-----Convert DCT matrix back to Pixels---------
    %DCT = DT*DCT*D;
    
    dct = lambda.*DCT;
    %size(dct)
end
