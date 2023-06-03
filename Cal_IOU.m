% ����IOU
function iou = Cal_IOU(SEG, GT)
    [rows, cols] = size(SEG);
    
    % ͳ�Ʊ�ǩGT���ָ���SEG������ֵΪ1�����ظ���
    % ��ʼ��
    label_area = 0; % ��ǩͼ���������������ظ�����
    seg_area = 0;   % �ָ��������
    intersection_area = 0; % �ཻ�������
    combine_area = 0;      % ���������������

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
    % fprintf("intersection_area = %f\n",intersection_area);
    % fprintf("label_area = %f\n",label_area);
    % fprintf("seg_area = %f\n",seg_area);
    
    combine_area = combine_area + label_area + seg_area - intersection_area;
    % fprintf("combine_area = %f\n",combine_area);
    
    % ����iou
    iou = double(intersection_area) / double(combine_area);
    fprintf('IOU = %f\n', iou);
    % figure(1)
    % subplot(1,2,1)
    % imshow(SEG);title('SEG')
    % subplot(1,2,2)
    % imshow(GT);title('GT')
end

