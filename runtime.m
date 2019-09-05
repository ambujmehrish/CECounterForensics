clear all
close all

img = imread('E:\Ambuj MMSEC\ContrastEnhancedAntiforensics\Database\BOSS Image database (10000 uncompressed images)\985.pgm');
img = img(121:376,121:376); %% for 256x256
tic
[normalCE,antiCE] = MRFanti_grad(img,50,0.004,'CE');
toc
