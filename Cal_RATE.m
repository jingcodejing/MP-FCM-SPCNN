% ����TPR,FPR,TNP
function rate = Cal_RATE(SEG, GT)
    [rows, cols] = size(SEG);
    total_area = rows * cols;
    
    % ͳ�Ʊ�ǩGT���ָ���SEG������ֵΪ1�����ظ���
    % ��ʼ��
    label_area = 0; % ��ǩͼ������
    seg_area = 0;   % �ָ��������
    intersection_area = 0; % �ཻ�������

    % ��������ֵ����
    for i = 1: rows
        for j = 1: cols
            % ������Ϊǰ��
            if GT(i, j)==1 && SEG(i, j)==1
                intersection_area = intersection_area + 1;
                label_area = label_area + 1;
                seg_area = seg_area + 1;
            % ��ָ�Ϊ������false negtive��
            elseif GT(i, j)==1 && SEG(i, j)~=1
                label_area = label_area + 1;
            % ��ָ�Ϊǰ����false positive��
            elseif GT(i, j)~=1 && SEG(i, j)==1
                seg_area = seg_area + 1;
            end
        end
    end
    
    % true positive rate
    tpr = double(intersection_area) / double(label_area);
    fprintf("TPR = %f\n", tpr);
    % false positive rate
    fpr = double(seg_area - intersection_area) / double(total_area - label_area);
    fprintf("FPR = %f\n", fpr);
    % true negtive rate
    tnr = 1 - fpr;
    fprintf("TNR = %f\n", tnr);
    
    rate = [tpr, fpr, tnr];
    
end