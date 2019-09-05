function IMat = generateIMat(i,j)
    I = zeros(8,8);
    I(i,j) = 1;
    IMat = repmat(I , 64 , 64);
end
