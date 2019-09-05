function output = normalize01(input,low,high)
%function output = normalize(input,min,max)

%This function normalizes the values of given matrix from min to max.
input = double(input);
switch ndims(input)
    
    case 1
        
        output = (high-low).*((input - min(input))./(max(input) - min(input)))+low;
        
    case 2
        
        output = (high-low).*((input-min(min(input)))./(max(max(input))-min(min(input))))+low;
        
    case 3
        
        for i = 1 : size(input,3)
            output(:,:,i) = (high-low).*(((input(:,:,i)-min(min(input(:,:,i))))./(max(max(input(:,:,i)))-min(min(input(:,:,i))))))+low;
        end
        
    otherwise
        
        error('dimension of input should be lesser than or equal to 3');
end







end