%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I ԭʼͼ�� img1ԭʼͼ�� img2ԭʼͼ���һ���Ժ��ͼ�� Idiffusion ���ͼ��
     
clc ;clear all;close all;
tic;
img=imread('E:\����\PCNN\ͼƬ\�Ա�\2\2-yuan.jpg');
figure,imshow(img);
ISSIM=im2double(img);
for j=17;
for k=1:3;
I=img(:,:,k);
[m,n]=size(I);

img1=im2double(I);
I1=double(img1);
I1=(I1-min(min(I1)))./(max(max(I1))-min(min(I1)));
minI1=min(min(I1));
maxI1=max(max(I1));
I2=(I1+1/255)/(maxI1+1/255);
minI2=min(min(I2));
t=11;                                   
th1=(1/(1-t))*log(min(min(I2)));        
th2=exp(-th1);                           
ve=(((1-exp(-th1*3)))./(1-th2))*th2;     
B=th2^2/4;
W=[0 1 0;
   1 0 1;
   0 1 0];
%^^^^^^^^^^^^^^^^^^
M=W;     Y=zeros(m,n);     F=Y;      L=Y;       U=Y;      E=Y;
%^^^^^^^^^^^^^^^^^^
%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                                                     % (����������Ԥ������������λ�ã�
Yzong=0;
Ienhance=zeros(m,n);
for i=1:t
   K=conv2(Y,M,'same');
   F=I2;
   if (i==2)
       for i1=1:m
           for j1=1:n
               if (i1==1 || i1==m || j1==1 || j1==n)
                   U(i1,j1)=U(i1,j1)*th2+F(i1,j1).*(1+1.33*B*K(i1,j1));
                   if(i1==1 && j1==1 || i1==1 && j1==n || i1==m && j1==1 || i1==m && j1==n)
                       U(i1,j1)=U(i1,j1)*th2+F(i1,j1).*(1+2*B*K(i1,j1));
                   end
               else
                   U(i1,j1)=U(i1,j1)*th2+F(i1,j1).*(1+B*K(i1,j1));  
               end
           end
       end
   else
        U=U*th2+F.*(1+B*K);
   end
   Y=double(U>E);
   E=th2*E+ve*Y*((th2^(-t)/(1-th2))^(sqrt(log2(i))));    % (���Ĵ�����Ԥ������������λ�ã�
   UUU{1,i}=U;
   EEE{1,i}=E;         
   YYY{1,i}=Y;
   Ienhance=Y*(i-1)+Ienhance;
end
   Ienhan=t-Ienhance;                                                       % (���Ĵ�����Ԥ������������λ�ã�
   Ienhan=(Ienhan-(min(min(Ienhan))))./((max(max(Ienhan)))-(min(min(Ienhan))));
   Izong=I1+0.5*Ienhan;                                                       % �ؼ��㷨1
   Izong=(Izong-(min(min(Izong))))./((max(max(Izong)))-(min(min(Izong))));        % ������ͼ����ǿ�����һ��
   Ienzong{1,k}=Izong;
end
   toc;
   timezong(15)=toc;
   Ienzong=cat(3,Ienzong{1,1},Ienzong{1,2},Ienzong{1,3});
   Izongzeng=Ienzong;
end
figure,imshow(Izongzeng,[]);
%figure,imshow(ISSIM,[]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imm=Izongzeng;
% imm=ISSIM;
Ymulzong=[];                                              % ��Ԫ��������
Iquan1=[];                                                % ����ͼ���ԭʼ��ֵ
Iquansim1=[];                                             % ����ͼ��Ļ�����ֵ
Valuesep11=[];                                            % ������ֵ��ԭʼ��ֵ�Ķ�Ӧ�������л�����ֵ���������ʾ��ԭʼ��ֵ���������Ӧ�ľ���ֵ��ʾ��
Iimm=imm(:,:,3);                           %���ؼ��㣩
[m,n]=size(Iimm);
I1=double(Iimm);
I1=(I1-min(min(I1)))./(max(max(I1))-min(min(I1)));    % �������ⷽ����ͼ����й�һ��
minI1=min(min(I1));
maxI1=max(max(I1));
I2=(I1+1/255)/(maxI1+1/255);
minI2=min(min(I2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FCMSPCNN��������
t=11;                                   %(�ĸĸģ� % �趨����th2��alpha��(��һ������Ԥ������������λ�ã�
th1=(1/(1-t))*log(min(min(I2)));        % �趨����th2��alpha��(�ڶ�������Ԥ������������λ�ã�
th2=exp(-th1);                           
ve=(((1-exp(-th1*3)))./(1-th2))*th2;    % �趨����th2��alpha��(����������Ԥ������������λ�ã�
B=th2^2/4;
W=[0 1 0;
   1 0 1;
   0 1 0];
%^^^^^^^^^^^^^^^^^^
M=W;     Y=zeros(m,n);     F=Y;      L=Y;       U=Y;      E=Y;                                                                   
Yzong=0;
Ymul=zeros(m,n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FCMSPCNNģ��ʵ��
for i=1:t
   K=conv2(Y,M,'same');
   F=I2;
   if (i==2)
       for i1=1:m
           for j1=1:n
               if (i1==1 || i1==m || j1==1 || j1==n)
                   U(i1,j1)=U(i1,j1)*th2+F(i1,j1).*(1+1.33*B*K(i1,j1));
                   if(i1==1 && j1==1 || i1==1 && j1==n || i1==m && j1==1 || i1==m && j1==n)       % �ڶ��ε�������Wijkl�����÷���
                       U(i1,j1)=U(i1,j1)*th2+F(i1,j1).*(1+2*B*K(i1,j1));
                   end
               else
                   U(i1,j1)=U(i1,j1)*th2+F(i1,j1).*(1+B*K(i1,j1));  
               end
           end
       end
   else
        U=U*th2+F.*(1+B*K);
   end
   Y=double(U>E);
   E=th2*E+ve*Y*((th2^(-t)/(1-th2))^(sqrt(log2(i))));    % (���Ĵ�����Ԥ������������λ�ã�
   UUU{1,i}=U;                                           % �����ڲ�����������Ϣ
   EEE{1,i}=E;                                           % ���涯̬��ֵ��������Ϣ
   YYY{1,i}=Y;                                           % ����ÿ�ε�����Ԫ����������Ϣ
 
   %if(i>1)
   %Yzong=Yzong+sum(sum(YYY{1,i}));
   %Yfire(j,k)=Yzong;                                     % ��¼��Ԫ��ÿ��ͨ���ڵĵ������
end
  figure,imshow(YYY{1,11},[]);  
  imwrite(Izongzeng,'E:\����\PCNN\ͼƬ\�Ա�\2\1.1.jpg');
  
