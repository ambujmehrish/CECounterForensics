function DMat = generateDMat()
    DMat = zeros(512,512);
    d = dctmtx(8);
    for i = 1 : 8 : 512
        DMat(i:i+7 , i : i+7) = d;
    end
end