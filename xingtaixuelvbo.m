close all;
clc;  
clear; 
tic
A=imread('E:\����\PCNN\ͼƬ\�Ա�\2\1.5.jpg');   %����ͼƬ������   
% I1=rgb2gray(A); %�� RGB ͼ��ת���ɻҶ�ͼ��
thresh = graythresh(A);     %�Զ�ȷ����ֵ����ֵ ������
I2=im2bw(A); %��ͼ���ֵ��
 
figure('name','��ֵ������');
subplot(1,3,1);  
imshow(A);    %��ʾԭͼ
title('ԭͼ'); 
% subplot(1,3,2);  
% % imshow(I1);    %��ʾ�Ҷ�ͼ��
% title('�Ҷ�ͼ'); 
% subplot(1,3,3);
% imshow(I2);    %��ʾ��ֵ��ͼ��
% title('��ֵ��'); 
 
 
% imdilate()����
% SE=[0 1 0 1
%     1 1 1 1
%     0 1 0 1];
% SE=[0 1
%     0 0];
SE=[1 0 1
    0 1 0
    1 0 1];
SE4=[1 1
    1 1]

SE2=[0 1 1
    0 1 1
    0 1 0]
SE3=[1 1 1 0 0 0 0 0 0 0 0
    1 1 1 0 0 0 1 1 0 0 0
    1 1 1 0 0 1 1 1 1 0 0
    0 0 0 0 0 0 1 1 0 0 0
    0 0 0 0 0 1 1 1 1 0 0
    0 0 1 0 0 1 1 1 0 0 0
    0 1 1 1 0 1 0 0 0 0 0
    0 1 1 1 1 1 1 0 0 0 0
    0 1 1 1 1 1 0 0 1 1 1
    0 0 1 0 1 0 0 0 1 1 1
    0 0 0 0 0 0 0 0 1 1 1]
    
   
DI=imdilate(I2,SE3);%ʹ�ýṹԪ��SE��ͼ��I2����һ������
 
%imerode()��ʴ
%strel�����Ĺ��������ø�����״�ʹ�С����ṹԪ��
SE1=strel('disk',3);%�����Ǵ���һ���뾶Ϊ3��ƽ̹��Բ�̽ṹԪ��
ER=imerode(I2,SE3);

% imopen()������
OP=imopen(I2,SE1);%ֱ�ӿ�����
 
%imclose()������
CL1=imdilate(imclose(I2,SE),SE);%ֱ�ӱ�����
% CL=imclose(OP,SE1);%ֱ�ӱ�����
CL2=imdilate(imclose(I2,SE4),SE);
CL3=imdilate(imclose(I2,SE2),SE3);
CL4=(2/3)*CL1+(1/3)*CL2;
 
% figure('name','��̬ѧ�˲�');
% subplot(2,2,1);  
%  imshow(DI);    %��ʾ��ֵ��ͼ������ʹ���ͼ��
%  title('����ͼ��'); 
%  subplot(2,2,2);  
% % imwrite(DI,'E:\����\PCNN\ͼƬ\4.6.jpg'); 
% imshow(ER);    %��ʾ��ֵ��ͼ��ĸ�ʴ����ͼ��
% title('��ʴͼ��'); 
% % imwrite(ER,'D:\weizhishibie\�ຣ��\XINGTAIXUE3.png');
% subplot(2,2,3);  
% imshow(OP);    %��ʾ��ֵ��ͼ��Ŀ����㴦��ͼ��
% title('������ͼ��'); 
% subplot(2,2,4);  
imshow(CL2);    %��ʾ��ֵ��ͼ��Ŀ����㴦��ͼ��
title('������ͼ��');
imwrite(CL2,'E:\����\PCNN\ͼƬ\�Ա�\2\1.7.jpg')
 
 
 
% %imnoise()����
% I3=imnoise(A,'salt & pepper',0.1);%��������
% I4=imnoise(A,'gaussian',0.02);    %��˹����
%  
% %��ֵ�˲�ȥ��������
% I5=medfilt2(I3,[4,4]); %4��4 ��ֵ�˲�
%  
% %��˹��ͨ�˲�ȥ��˹����
% sigma=1.6;
% gausFilter=fspecial('gaussian',[3,3],sigma);
% I6=imfilter(I4,gausFilter,'replicate');
%  
% figure('name','ͼ���˲�ȥ��');
% subplot(2,2,1);
% imshow(I3);
% title('���������ܶȣ�0.1�Ľ�������');
%  
% subplot(2,2,2);
% imshow(I4);
% title('���������ܶȣ�0.02�ĸ�˹����');
%  
% subplot(2,2,3);
% imshow(I5);
% title('��ֵ�˲�-����');
%  
% subplot(2,2,4);
% imshow(I6);
% title('��˹��ͨ�˲�-��˹');
toc