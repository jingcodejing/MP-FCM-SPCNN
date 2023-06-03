clc;clear;
img1=imread('E:\����\PCNN\ͼƬ\�Ա�\2\18-pcnn.jpg');
img2=imread('E:\����\PCNN\ͼƬ\�Ա�\2\18-shou.jpg');

figure('NumberTitle','off','Name','ԭʼͼ��');
subplot(1,2,1);imshow(img1);
subplot(1,2,2);imshow(img2);

figure('NumberTitle','off','Name','256���Ҷ�ͼ��');
img11=rgb2gray(img1);
img21=rgb2gray(img2);
subplot(1,2,1);imshow(img11);
subplot(1,2,2);imshow(img21);

figure('NumberTitle','off','Name','����32*32ͼ��');
img12=imresize(img11,[32,32]);
img22=imresize(img21,[32,32]);
subplot(1,2,1);imshow(img12);
subplot(1,2,2);imshow(img22);

imgdct1=dct2(img12);    %�����άdct
imgdct2=dct2(img22);
imgdct11=imgdct1(1:8,1:8);  %��ȡ���Ͻ�8*8
imgdct21=imgdct2(1:8,1:8);
mean1=sum(imgdct11(:))/64;  %�����ֵ
mean2=sum(imgdct21(:))/64;
imghash1=zeros(8,8);
imghash2=zeros(8,8);
for i=1:8   %��������hashָ��
    for j=1:8
        if(imgdct11(i,j)>=mean1)
            imghash1(i,j)=1;end
        if(imgdct21(i,j)>=mean2)
            imghash2(i,j)=1;end
    end
end
cyjz=xor(imghash1,imghash2);    %�����
hanming=sum(cyjz(:));   %��������
similarity=(64-hanming)/64;
figure('NumberTitle','off','Name','phashָ��ͼ');
subplot(1,2,1);imshow(imghash1);
subplot(1,2,2);imshow(imghash2);
title(['��ǰ�����ƶ�Ϊ',num2str(100*similarity),'%']);