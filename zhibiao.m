% ��������
I1=imread('E:\weizhishibie\�ຣ��\z+pcnn.png');
%for j=1:16
tic;
% str1=[Ifile1,num2str(k(j)),'.png'];
%imm=imread(I1); 
imm=I1;
Ymulzong=[];                                              % ��Ԫ��������
Iquan1=[];                                                % ����ͼ���ԭʼ��ֵ
Iquansim1=[];                                             % ����ͼ��Ļ�����ֵ
Valuesep11=[];                                            % ������ֵ��ԭʼ��ֵ�Ķ�Ӧ�������л�����ֵ���������ʾ��ԭʼ��ֵ���������Ӧ�ľ���ֵ��ʾ��
Iimm=imm(:,:,1);                           %���ؼ��㣩
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
t=11;
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

SE=strel('disk',1);      %gai
YYY{1,2}=imopen(YYY{1,2},SE);
YYY{1,2}=imfill(YYY{1,2},'holes');
Ifile2='E:\weizhishibie\�ຣ��\z+xb+lvbo+pc.png';
str2=[Ifile2,'.png'];
imwrite(YYY{1,2},str2);
str3=[Ifile2,'.tif'];
I=imm(:,:,1);
imwrite(imm,str3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ȷ���߽����״
F=I;
YYYedge=bwboundaries(YYY{1,2});
xYYY=YYYedge{1,1}(:,1);
yYYY=YYYedge{1,1}(:,2);
figure,imshow(I,[]);
for i=1:length(xYYY)
hold on;
plot(yYYY(i),xYYY(i),'r.');                                        % ��ԭʼͼ����ۺ�����
%drawnow;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����Աȶ�
objectvalue=0;
objectnumber=0;
objectnum=0;
backgroundvalue=0;
backgroundnumber=0;
for k1=1:m
    for l1=1:n
        if(YYY{1,2}(k1,l1)==1)
            objectvalue=objectvalue+I1(k1,l1);
            objectnumber=objectnumber+1;
            objectnum(objectnumber)=I1(k1,l1);
        else    
            backgroundvalue=backgroundvalue+I1(k1,l1);
            backgroundnumber=backgroundnumber+1;
        end    
    end
end    
objectmean=objectvalue/objectnumber;
backgroundmean=backgroundvalue/backgroundnumber;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���������
UM=0;
k=1;
for i1=1:m
    for j1=1:n
        if(YYY{1,2}(i1,j1)==1)
            UM=(I1(i1,j1)-objectmean)^2+UM;
        else
            UM=(I1(i1,j1)-backgroundmean)^2+UM;
        end
    end   
end
UMzong(k)=1-(UM/(m*n));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ŀ�������ֵ
Omean(k)=objectmean;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ŀ�����򷽲�
Ostd2(k)=std2(objectnum);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �����ֶ��ָ����������ͼ�������ָ�꣨overlap sen)
imgImanual=zeros(m,n);
imgintersect=zeros(m,n);
str1=[Ifile1,num2str(r(k)),'.png'];
Imanual=imread(str1);
Imanual=Imanual(:,:,1);
for i=1:m
    for j=1:n
        if(Imanual(i,j)==204)
            imgImanual(i,j)=1;
        end
    end
end    
imgImanual=imfill(imgImanual,'holes');
imgImanual=bwlabel(imgImanual,8);
stats=regionprops(imgImanual,'all');
Imanualarea=[stats.Area];                                                  % ���ҽʦ�ֻ��ʯ�Ľ��
indexImanualarea=find(Imanualarea==max(Imanualarea));
imgImanual=ismember(imgImanual,indexImanualarea);
IPAPCNN=YYY{1,2};
for i=1:m
    for j=1:n
        if(imgImanual(i,j)==1 && IPAPCNN(i,j)==1)
            imgintersect(i,j)=1;                           % ���������
        end
    end
end    
  Overlaparea(k)=sum(sum(imgintersect))/sum(sum(IPAPCNN));
  Searea(k)=sum(sum(imgintersect))/sum(sum(imgImanual));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

UMzong(k)
Omean(k)
Ostd2(k)
Overlaparea(k)
Searea(k)
UMzong1=sum(UMzong)/k;
Omeanzong=sum(Omean)/k;
Ostd2zong=sum(Ostd2)/k;
Overlapareazong=sum(Overlaparea)/k;
Seareazong=sum(Searea)/k;
UMzong1
Omeanzong
Ostd2zong
Overlapareazong
Seareazong

  figure,imshow(YYY{1,11},[]);                            %(�ĸĸģ�
%   imwrite(YYY{1,11},'D:/weizhishibie/img/01/tiqu.jpg');
%Idanchu=YYY{1,2};
%Istr=[Ifile2,num2str(j),'.jpg'];           % �����ͼ�񴢴浽�ļ�ָ����λ��
%imwrite(Idanchu,Istr);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%[Icurow Icucol]=find(Idanchu5==1);
%Icudanu=min(Icurow);                                                       % �õ��ַָ����������ϱ����صĺ�����
%Icudand=max(Icurow);                                                       % �õ��ַָ����������±����صĺ�����
%Icudanl=min(Icucol);                                                       % �õ��ַָ���������������صĺ�����
%Icudanr=max(Icucol);                                                       % �õ��ַָ����������ұ����صĺ�����
%Icudanx=max(1,Icudanu-round(m/5));                                        % �õ�����ͼ�����ϱߵ�����
%Icudany=max(1,Icudanl-round(n/5));                                        % �õ�����ͼ������ߵ�����
%xw=Icudand-Icudanx+min(round(m/5),(m-Icudand));                           % �õ�����ͼ��Ŀ�
%yl=Icudanr-Icudany+min(round(n/5),(n-Icudanr));                           % �õ�����ͼ��ĳ� 

%end


