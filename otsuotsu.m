I = imread('E:\����\PCNN\ͼƬ\�Ա�\2\1\00008 4074.jpg');
I = im2double(I);
T = graythresh(I); %��ȡ��ֵ
J = im2bw(I, T); %ͼ��ָ�
subplot(121),imshow(I);
subplot(122),imshow(J);
imwrite(J,'E:\����\PCNN\ͼƬ\�Ա�\2\21-otsu.jpg')
