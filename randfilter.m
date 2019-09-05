function output = randfilter(input,randcount)
%function output = randfilter (input,randcount)
%This function applies any of the 13 filters defined below based on the
%value in 'randcount' variable to the image 'input'.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Code written by, @ Hareesh Ravi (Research Associate at IIITD)    %%%%  
%%%%  (haree.24@gmail.com)                                             %%%% 
%%%%  code can be used and modified for research purposes.             %%%% 
%%%%  Kindly let me know of mistakes by mail                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

count = randcount;
input = double(input);
switch count
    
     case 1
        if ndims(input)==3
            output(:,:,1) = medfilt2(input(:,:,1),[3 3]);output(:,:,2) = medfilt2(input(:,:,2),[3 3]);output(:,:,3) = medfilt2(input(:,:,3),[3 3]);
        elseif ismatrix(input)
            output = medfilt2(input);
        end
    case 2
        if ndims(input)==3
            output(:,:,1) = medfilt2(input(:,:,1),[5 5]);output(:,:,2) = medfilt2(input(:,:,2),[5 5]);output(:,:,3) = medfilt2(input(:,:,3),[5 5]);
        elseif ismatrix(input)
            output = medfilt2(input);
        end
    case 3
        if ndims(input)==3
            output(:,:,1) = medfilt2(input(:,:,1),[7 7]);output(:,:,2) = medfilt2(input(:,:,2),[7 7]);output(:,:,3) = medfilt2(input(:,:,3),[7 7]);
        elseif ismatrix(input)
            output = medfilt2(input);
        end
    case 4
        h = fspecial('laplacian',0.2);output = input - imfilter(input,h,'replicate');
    case 5
        h = fspecial('laplacian',0.4);output = input - imfilter(input,h,'replicate');
    case 6
        h = fspecial('Unsharp',0.3);output = imfilter(input,h,'replicate');
    case 7
        h = fspecial('Unsharp',0.1);output = imfilter(input,h,'replicate');
    case 8
        h = fspecial('average',[3 3]);output = imfilter(input,h,'replicate');
    case 9
        h = fspecial('average',[5 5]);output = imfilter(input,h,'replicate');
    case 10
        h = fspecial('gaussian',[5 5],1);output = imfilter(input,h,'replicate');
    case 11
        h = fspecial('gaussian',[3 3],1);output = imfilter(input,h,'replicate');
    case 12
        h = fspecial('gaussian',[5 5],0.5);output = imfilter(input,h,'replicate');
    case 13
        h = fspecial('gaussian',[3 3],0.5);output = imfilter(input,h,'replicate');
    
end

output = uint8(output);

end