close all;
clc;  
clear; 
img=imread('E:\����\PCNN\ͼƬ\�Ա�\2\1.2.jpg');
a=img;
% imshow(img);
[m n]=size(img);
img=double(img);
w1=[0.3162    0.4000    0.5099    0.6324    0.7616
   0.3162    0.2000    0.1414    0.2000    0.3162    
   0.2828    0.1414         0    0.1414    0.2828    
   0.3162    0.2000    0.1414    0.2000    0.3162    
   0.4000    0.3162    0.2828    0.3162    0.4000]
%��˹�˲�
w2=fspecial('gaussian',[5,5]);    %[ 5 5 ]��ģ��ߴ磬Ĭ����[ 3 3 ]  ģ�弴���������ģ��
w=w1*w2.'
img=imfilter(img,w);
figure;
% subplot(1,2,1);imshow(a);title('ԭͼ');
% subplot(1,2,2);imshow(uint8(img));title('��˹�˲�');

imshow(uint8(img));
imwrite(uint8(img),'E:\����\PCNN\ͼƬ\�Ա�\2\1.3.jpg')

