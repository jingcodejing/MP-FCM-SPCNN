clc;clear;
img1=imread('E:\����\PCNN\ͼƬ\�Ա�\2\21-shou.jpg'); %��ȡͼƬ
img2=imread('E:\����\PCNN\ͼƬ\�Ա�\2\21-pcnn.jpg');

figure('NumberTitle','off','Name','ԭʼͼ��');
subplot(1,2,1);imshow(img1);    %��ʾԭʼͼ��
subplot(1,2,2);imshow(img2);

figure('NumberTitle','off','Name','ƥ��ͼ��ߴ�');
[a1,b1]=size(img1);[a2,b2]=size(img2);

a=min(a1,a2);b=min(b1,b2);
img11=imresize(img1,[a,b/3]);   %��Ϊ����RGB3��ͨ�������Գ�3
img21=imresize(img2,[a,b/3]);
subplot(1,2,1);imshow(img11);   %��ʾƥ��ߴ�֮���ͼ��
subplot(1,2,2);imshow(img21);

figure('NumberTitle','off','Name','�Ҷȷֲ�ͼ');
[hd1,x1]=imhist(img11);
[hd2,x2]=imhist(img21);
plot(hd1,'color',[1 0 0]);hold on;
plot(hd2,'color',[0 1 0]);legend('hd1','hd2');

figure('NumberTitle','off','Name','��һ���Ҷȷֲ�ͼ�����ƶ�');
hd11=hd1/(a*b);
hd21=hd2/(a*b);
plot(hd11,'color',[1 0 0]);hold on;
plot(hd21,'color',[0 1 0]);legend('hd11','hd21');
d=0;
for i=1:256
    d=d+sqrt(hd11(i)*hd21(i));  %����Ͼ���Ĺ�ʽ
end
title(['���ƶ�Ϊ',num2str(100*d),'%']);
