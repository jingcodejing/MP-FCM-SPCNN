% A=imread('E:\����\PCNN\ͼƬ\4.1.jpg');
% A=rgb2gray(A)
% [C,S]=wavedec2(A,2,'db1')
% D=uint8(appcoef2(C,S,'db1',1));%��ȡ��Ƶ����
% H=uint8(detcoef2('h',C,S,1));
% figure,imshow(D),title('��Ƶ����');
% figure,imshow(H),title('��Ƶ����');
% X=wrcoef2('all',C,S,'db1')
% figure,imshow(X),title('�ع�');
A=imread('E:\����\PCNN\ͼƬ\4.2.jpg')
w1=[0.4000    0.3162   0.2828    0.3162    0.400
   0.3162    0.2000    0.1414    0.2000    0.3162    
   0.2828    0.1414         0    0.1414    0.2828    
   0.3162    0.2000    0.1414    0.2000    0.3162    
   0.4000    0.3162    0.2828    0.3162    0.4000]
%��˹�˲�
w2=fspecial('gaussian',[5,5]);    %[ 5 5 ]��ģ��ߴ磬Ĭ����[ 3 3 ]  ģ�弴���������ģ��
w=w1.'*w2;%����Ȩ�ط���
D=imfilter(A,w);
figure,imshow(D);
% imwrite(D,'E:\����\PCNN\ͼƬ\D.jpg')
% imwrite(D,'E:\����\PCNN\ͼƬ\xtxb.jpg')
% a=uint8(wrcoef2('all',C,H,'db1',0));
% figure,imshow(a),title('0���ع�');
% a1=uint8(wrcoef2('all',C,S,'db1',1));
% figure,imshow(a1),title('1���ع�');
% a2=uint8(wrcoef2('all',C,S,'db1',2));
% figure,imshow(a2),title('2���ع�');
