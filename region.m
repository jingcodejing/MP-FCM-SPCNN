clear all;
close all;clc;
SrcImage=imread('E:\����\PCNN\ͼƬ\16.4.jpg');
imshow(SrcImage)
grabImage=rgb2gray(SrcImage);
figure,imshow(grabImage),title('grabImage');
rect=[160,293,100,100];
paddingValue=1;%��ɫ���
destImg=ImageCropPadding(SrcImage,rect,paddingValue);
figure,imshow(destImg),title('destImg');
