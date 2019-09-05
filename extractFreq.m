function f = extractFreq(img,x,y)
dct = @(block_proc)dct2(block_proc.data);
IMG = blockproc(img,[8,8],dct);
[M,N] = size(img);
m = M/8;
n = N/8;
inx = 0;
for i = 1:m
    for j = 1:n
        inx = inx+1;
        f(inx) = IMG((x+8*i-7),(y+8*j-7));
    end
end 
end