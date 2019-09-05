function [normalCE,antiCE] = MRFanti_grad(xblock,maxiter,gamma,type,Alpha,Beta,Gamma,Delta)
%function [normalCE,antiCE] = MRFanti_grad(xblock,maxiter,gamma,type)

%This function performs gradient descent for the gradient calculated from
%HMRF prior and
% Please cite the following paper if the code is used in the following way,
%

%Input - 
% xblock - Noisy block vector (block^2 X 1) - (0 to 255 range gray scale block)
% maxiter - is the Huber function weight included as part of our application
% (default is 1)
% gamma - inverse of the noise covariance matrix.
% type - number of iterations of gradient descent for every block
% (default - 50)

%Output -
% normalCE - Optimized denoised block after grad descent size (block X block)
% antiCE - is the gradient descent error just to see if error is decreasing
%         with increasing number of iterations for every block

%This code might not be optimized and completely free of errors.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Code written by, @ Hareesh Ravi (Research Associate at IIITD)    %%%%  
%%%%  (haree.24@gmail.com)                                             %%%% 
%%%%  code can be used and modified for research purposes.             %%%% 
%%%%  Kindly let me know of mistakes by mail                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

zqUE = xblock;
UE = xblock;

if strcmp(type,'NLFE')==1
    if gamma>0.9 && gamma<4
        zqCE = randfilter(zqUE,gamma);
    else
        error('wrong gamma value for NLFE choice - use integer between 1 and 3')
    end
elseif strcmp(type,'LFE')==1
    if gamma>3 && gamma<14
        zqCE = randfilter(zqUE,gamma);
    else
        error('wrong gamma value for LFE choice - use integer between 4 and 13')
    end
elseif strcmp(type,'CE')==1
    if gamma == 100
        zqCE = uint8(imadjust(xblock));
    else
         %zqCE = uint8(255.*((double(xblock)./255).^(gamma))); %% for 256/256
        %zqCE = adapthisteq(xblock,'ClipLimit',gamma,'Distribution','rayleigh');
        zqCE = adapthisteq(xblock,'ClipLimit',gamma);
        %zqCE = uint8(511.*((double(xblock)./511).^(gamma)));
    end
else
    error('wrong enhancement type')
end

normalCE = zqCE;

%Initializing everything
z = double(zqUE(:));
zqUE = double(zqUE);
zqCE = double(zqCE);
xblock = padarray(double(xblock),[1 1],'replicate');

UE = double(UE);
UE= padarray(double(UE),[1 1],'replicate'); %%changed

% termination tolerance
tol = 1e-3;

% maximum number of allowed iterations
% maxiter = 50;

% Initial step size for gradient descent
alpha = 0.1;
%Initial data vector
x = z;

%Initializing error vector
err=zeros(1,maxiter);
niter=1;

%Initializing weights
%w1 = 0.2;    %alpha
w1 = Alpha;
%w2 = 12;   % beta
w2 = Beta;
%l= .5; 
%w2 = 2.4;    % 2 * beta
%w2 = 0.6;    % 0.5 * beta


%--------------Code to generate DCT 256x256 diagonal-d matrix--------------
function DMat = generateDMat()
     DMat = zeros(256,256);
%     DMat = zeros(512,512);
    d = dctmtx(8);
   for i = 1 : 8 : 256
%     for i = 1 : 8 : 512
        DMat(i:i+7 , i : i+7) = d;
    end
end

%-----------Function to Generate I Matrix 256x256--------------------------
function IMat = generateIMat(i,j)
    I = zeros(8,8);
    I(i,j) = 1;
   IMat = repmat(I , 32 , 32);
%      IMat = repmat(I , 64 , 64);
end

%--------Comment lines below to remove matrices----------------------------
%D- Matrices
D = generateDMat();
DT = D.';

%I - Matrices
I1 = generateIMat(1,2);
I2 = generateIMat(2,1);
I3 = generateIMat(3,1);
I4 = generateIMat(2,2);
I5 = generateIMat(1,3);
I6 = generateIMat(1,1);

IC = I1 + I2 + I3 + I4 + I5 + I6 ;
%---------------------------------------------------

while (niter <= maxiter)
    
    %niter
    % calculate gradient:
    g  = grad(xblock,zqUE,zqCE, UE , w1,w2,Gamma );
    %Size : xblock - 258x258 , zqUE - 256x256 , zqCE - 256x256 , UE - 258x258
    
    % -------------- Adding 6 DCT Componets to gradient -----------------
    %DCTComp = DCT(zqUE, xblock, D , DT , I1);
    %size(g)
    %size(DCTComp)
    
    %Individual DCT components
    g  = g + Delta*DCT(zqUE, xblock, D , DT , I1);
    g  = g + Delta*DCT(zqUE, xblock, D , DT , I2);
    g  = g + Delta*DCT(zqUE, xblock, D , DT , I3);
    g  = g + Delta*DCT(zqUE, xblock, D , DT , I4);
    g  = g + Delta*DCT(zqUE, xblock, D , DT , I5);
    g  = g + Delta*DCT(zqUE, xblock, D , DT , I6);
    
    %g  = g + DCT(zqUE, xblock, D , DT , IC);    % Combined I-Mat
    %--------------------------------------------------------------------
    
    temp = z;
    % Gradient ddescent step
    z = z - alpha*g;
    
    %calculate error for tolerance measure
    err(1,niter) = mean(abs((abs(z) - abs(temp))));
    
    %upgrade alpha at every step
    alpha = alpha-(alpha*0.05);
    
    
    %xnew = z;
    
    %error if value is Inf
    if ~isfinite(z)
        display(['Number of iterations: ' num2str(niter),'aplha is:'  num2str(alpha)])
        error('x is inf or NaN')
    end
    
    x = z;
    
    %Update xblock with new values to calculate gradient again
    [M,N] = size(xblock);
    xblockinter = reshape(z,M-2,N-2);
    %       xblock = padarray(xblockinter,[1 1]);
    xblock(2:end-1,2:end-1) = xblockinter;
    
    %Padding using replicate
    xblock(1,2:end-1) = xblock(2,2:end-1);
    xblock(end,2:end-1) = xblock(end,2:end-1);
    xblock(:,1) = xblock(:,2);
    xblock(:,end) = xblock(:,end-1);
    
    
    %come out of the loop if tol level reached
    if err(1,niter)<=tol
        break;
    end
    
    %disp(niter);
    %Increment iteration counter
    niter = niter + 1;
end

% disp(niter-1);
%Final optimized/denoised image
[M,N] = size(xblock);
antiCE = uint8(reshape(x,M-2,N-2));

end



%--------------------Gradient Calculating Function-------------------------
function g  = grad(xblock, zqUE, zqCE, UE, w1, w2,Gamma)
%function g  = grad(xblock,z,zq,kezinv,weight)

%This function implements the HMRF model & quantization noise model as 
%described in the same paper to a block and determines the gradient to be 
%used for the descent algorithm. 

% Input -
% xblock,z - block and vector of the block updated at every iteration
% zq - vector of noisy block
% kezinv - noise covariance matrix
% weight - introduced to govern the degree of denoising at the block
% boundaries

% Output -
% g - gradient calculated based on HMRF model and Quantization noise model.

%Lambda governs the degree of smoothing
%lambda = 0.08;
lambda = Gamma;
% lambda = 0.08;

%Threshold to define huber function as set in the paper
T = 10;

%Initializations
[M,N] = size(xblock);
xblock = double(xblock);
pho = zeros(3,3);%r=0;
phoo = zeros(5,5);
r = zeros(M-2,N-2);
tempx = xblock(2:M-1,2:N-1);

%First 2 Terms
s = w1.*(tempx(:) - zqUE(:)) + w2.*(tempx(:) - zqCE(:));        %Term 1 & 2

%HMRF as in the paper : Calculating term 4
% for l = 2:M-1
%     for k = 2:N-1
%         currentpx = xblock(l,k);
%         
%         for i = 1:3
%             for j=1:3
%                 u = currentpx - UE(l+i-2,k+j-2) ;  % changed from xblock(l+i-2,k+j-2)to UE(l+i-2,k+j-2)
%                 if(abs(u)<=T)
%                     pho(i,j) = 2*u;              
%                 elseif((u)>T)
%                     pho(i,j) = 2*T;
%                 elseif((u)<-T)
%                     pho(i,j) = -2*T;
%                 end
%             end
%         end
%         
%         phoo(2:4,2:4) = pho;
%         for i = 2:size(phoo,1)-1
%             for j = 2:size(phoo,2)-1
%                 pho(i-1,j-1) = sum(sum(phoo(i,j) - phoo(i-1:i+1,j-1:j+1)));
%             end
%         end
%         
%         r(l-1,k-1) = sum(sum(pho));
%     end
% end
% %gradient as computed in the paper
% g = (lambda).*r(:)+ s;            %Term 4 + (Term 1 & 2) %% changed lambda to lambda/2
% 
g = s;
% ----------------------Commenting out 3rd Term for DCT-----------------------------
pho = zeros(3,3);%r=0;
phoo = zeros(5,5);
r = zeros(M-2,N-2);

%HMRF as in the paper : Calculating Term 3
for l = 2:M-1
    for k = 2:N-1
        currentpx = xblock(l,k);
        
        for i = 1:3
            for j=1:3
                u = currentpx - xblock(l+i-2,k+j-2);   
                if(abs(u)<=T)
                    pho(i,j) = 2*u;              
                elseif((u)>T)
                    pho(i,j) = 2*T;
                elseif((u)<-T)
                    pho(i,j) = -2*T;
                end
            end
        end
        
        phoo(2:4,2:4) = pho;
        for i = 2:size(phoo,1)-1
            for j = 2:size(phoo,2)-1
                pho(i-1,j-1) = sum(sum(phoo(i,j) - phoo(i-1:i+1,j-1:j+1)));
            end
        end
        
        r(l-1,k-1) = sum(sum(pho));
    end
end
%s = w1.*(tempx(:) - zqUE(:)) + w2.*(tempx(:) - zqCE(:));     %Already added before 
%gradient as computed in the paper
g = g + lambda.*r(:);              %Adding Term 3 to (Term 1,2,4) %%Lambda = 0.05


end


% -------------------- DCT Component : Calculates Gradient ----------------
function dct = DCT( orgImg, antiCEImg, D , DT , I1)
    [M,N] = size(antiCEImg);
    tempx = antiCEImg(2:M-1,2:N-1);
    ImgDiff = tempx - orgImg;
    %imshow(ImgDiff);
    ImgDiff = ImgDiff.';
    
    DCT = D*ImgDiff*DT;
    DCT = I1.*DCT;
    DCT = DCT*(I1'.*(D*DT));
    
    %-----Convert DCT matrix back to Pixels---------
    %DCT = DT*DCT*D;
    
    dct = DCT(:);
end
