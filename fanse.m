clear all;
close all;
clc;  
clear; 
I = imread('E:\����\PCNN\ͼƬ\�Ա�\1\3-grow.jpg');
figure, imshow(I);
I_reverse = imcomplement(I);
figure, imshow(I_reverse);
imwrite(I_reverse,'E:\����\PCNN\ͼƬ\�Ա�\1\3-grow.jpg')