function sr = extractSRM(img)
temp = struct2cell(SRM_jfridrich(img));X(1,:) = temp';
temp = [];
    for j = 1: 106
        temp = [temp,X{1,j}];
    end
    sr = temp;
   
end