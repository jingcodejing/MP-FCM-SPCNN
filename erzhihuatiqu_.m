% ��������
clc;clear;close all;
f1 =1;
f2 =1;
t = -0.28;                                   %(�ĸĸģ� % �趨����th2��alpha��(��һ������Ԥ������������λ�ã�
file1 = 'JPEGImages - ����';
% file2 = '000';
x1 = 1; x2 =416;%��
y1 = 1; y2 = 416; %��
for fi=f1:f2
    file3 = num2str(fi,'%03d');
    filename1 = ['E:\ʵ��\data\',file3,'.png'];
    filename2 = ['E:\workspace\python\conv_lstm\data\input\img\11\',file3,'.png'];  
 
    img = imread(filename1);
    img = img(x1:x2,y1:y2,1:3);
    thresh1=graythresh(img(:,:,3));   %thresh1=0.5216
    thresh1 = thresh1-t;
    tu2 = im2bw(img(:,:,2),thresh1);
    img_invert = imcomplement(tu2);
    imshow(img_invert);
    %imwrite(img_invert, filename2);
end