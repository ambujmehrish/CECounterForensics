function plotMAP(MAP)
for i = 1:size(MAP,1)
    M =  MAP{i,1};
    x = M.LO;
    y = M.HI;
    subplot(1,2,1)
    imshow(x,[])
    subplot(1,2,2)
    imshow(y,[])
end