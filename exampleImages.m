close all
clear 
img = imread(['Database\BOSS\','9182','.pgm']);
[antiCE,antiCE20,normalCE] = generateImg(img,'4');
figure
imshow(antiCE)
figure
imshow(antiCE20,[])
figure
imshow(normalCE)