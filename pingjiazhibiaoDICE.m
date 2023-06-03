
clc;clear;
img1=imread('E:\����\PCNN\ͼƬ\�Ա�\2\18-pcnn.jpg'); %��ȡ�ָ�ͼ��
img2=imread('E:\����\PCNN\ͼƬ\�Ա�\2\18-shou.jpg');  %�ֶ��ָ���ͼ��
img1=double(img1);
img2=double(img2);
%A = imread('hands1.jpg');%��ȡRGBͼ��
BW1 = rgb2gray(img1);%�ҶȻ�
BW2 = rgb2gray(img2);
% ����ͼ��
% SEG = imread("SEG_GMR.png");
% GT = imread("label.png");
SEG = BW1;
GT = BW2
% binarize(0~255 to 0~1)
SEG = imbinarize(SEG, 0.3);
GT = imbinarize(GT, 0.1);
% % % % % % % % % % % % % % % % % % % IOU
iou = Cal_IOU(SEG, GT);
% % % % % % % % % % % % % % % % % % % %  TPR��FPR��TNR
rate = Cal_RATE(SEG, GT);
% % % % % % % % % % % % % % % % % % % % Precision , Recall , F1
precision = Precision(SEG, GT);
recall = Recall(SEG, GT);
f1 = F1(SEG, GT);
fprintf("precision = %f\n", precision);
fprintf("recall = %f\n", recall);
fprintf("f1 = %f\n", f1)
% % % % % % % % % % % % % % % % % % % % % % % % % % % MAE
mae = Cal_MAE(SEG, GT);
% % % % % % % % % % % % % % % % % % % % % % % % % % DICE
dr = Dice_Ratio(SEG, GT);
% % % % % % % % % % % % % % % % % % % % % % % % % % % Hausdorff distance
hd = Hausdorff_Dist(SEG, GT);
%  %% % %%% %%%%  %%% %                      Perpen Distance 
apd = Avg_PerpenDist(SEG, GT);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%c ConformityCoefficien
confm_index = ConformityCoefficient(SEG, GT);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%voe
voe = calVOE(SEG, GT);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%RVD
rvd = calRVD(SEG, GT);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Specificity
% spec = getSpecificity(SEG, GT);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Sensitivity
sen = getSensitivity(SEG, GT);









