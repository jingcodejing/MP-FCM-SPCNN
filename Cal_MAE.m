% ����һ��ͼ���AE
function mae = Cal_MAE(SEG, GT)
    if size(SEG, 1) ~= size(SEG, 1) || size(SEG, 2) ~= size(GT, 2)
        error("seg map and ground truth have different size!\n");
    end
    if ~islogical(GT)
        GT = GT(:,:,1) > 128;
    end
    
    SEG = im2double(SEG(:,:,1));
    fgPixels = SEG(GT);
    % TP + FP
    fprintf("fgPixels len: %d\n", length(fgPixels))
    % TP
    fprintf("fgPixels num: %d\n", sum(fgPixels))
    % ��ָ�Ϊǰ�������ظ�����FP��
    fgErrSum = length(fgPixels) - sum(fgPixels);
    % ��ָ�Ϊ���������ظ�����FN��
    bgErrSum = sum(SEG(~GT));
    % MAE = ��ָ�������� / ��ǩ��������
    mae = (fgErrSum + bgErrSum) / numel(GT);
    fprintf("MAE = %f\n", mae);
end
