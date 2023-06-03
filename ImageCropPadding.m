function destImg=ImageCropPadding(gray_img,rect,paddingValue)
% ImageCropPadding��������˵����
% �ú�����ʵ�ָ���rect(x,y,w,h)����ָ���ĻҶ�ͼ�������г���ͼ��߽磬����paddingValue��ֵ���
% ���������gray_img����������Ҷ�ͼ����ʱ��֧��RGBͼ��
%              rect��ָ����������������Matlab��imcrop�����÷�
%      paddingValue�����ֵ��1-255��
%% For Example:
%  SrcImage=imread('images/liuyifei.jpg');
%  grabImage=rgb2gray(SrcImage);
%  figure,imshow(grabImage),title('grabImage');
%  rect=[-50,-50,500,500];
%  paddingValue=1;
%  destImg=ImageCropPadding(SrcImage,rect,paddingValue);
%  figure,imshow(destImg),title('destImg');
%%
x=rect(1);
y=rect(2);
w=rect(3);
h=rect(4);
destImg = im2uint8(zeros(h, w)+paddingValue/255); 
crop_x1 = max(1, x);
crop_y1 = max(1, y);
[rows,cols]=size(gray_img);
crop_x2 = min(cols, x + w); 
crop_y2 = min(rows, y + h);
roi_img = gray_img(crop_y1:crop_y2,crop_x1:crop_x2);
x1 = crop_x1 - x+1;
y1 = crop_y1 - y+1;
x2 = crop_x2 - x+1;
y2 = crop_y2 - y+1;
% I(y1:y2, x1:x2 ) = I(y1:y2 , x1:x2) + roi_img;
destImg(y1:y2, x1:x2 ) =  roi_img;
end