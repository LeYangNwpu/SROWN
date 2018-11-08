%��Ϊ���й�������У���Сֵ�?7�����ֵ�?

clear
clc

opMax = 15;
opMinAbs = 15;

opflowRp = '/disk2/donzhang/dataset/DAVIS/imageFlowOri/blackswan/';
resImgRp = '/disk2/yangle/dataset/triDataset/opflowImg/blackswan/';
matSet = dir([opflowRp, '*.mat']);

for imat = 1:length(matSet)
    disp(imat);
    matName = matSet(imat).name;
    aload = load([opflowRp, matName]);
    matSave = aload.matSave;
    
    for iLayer = 1:2
        vc = matSave(:,:,iLayer);
        maxValue = max(max(vc));
        if maxValue > opMax
            maxValue = opMax;
            vc(vc > opMax) = opMax;
        end
        absMinValue = abs(min(min(vc)));
        if absMinValue > opMinAbs
            absMinValue = opMinAbs;
            vc(vc<(-1*opMinAbs)) = -1*opMinAbs;
        end
        vc = vc + absMinValue;
        vc = vc / (maxValue + absMinValue);  
        vc = uint8(255 * vc);

        maxValueImg = round(maxValue * 255/opMax);
        minValueImg = round(absMinValue * 255/abs(opMinAbs));

        vc(1,1) = maxValueImg;
        vc(448, 448) = minValueImg;
        if iLayer == 1
            addImgName = '_x';
        else
            addImgName = '_y';
        end
        imgName = [matName(1:end-4), addImgName, '.png'];
        imwrite(vc, [resImgRp, imgName], 'png');

    end    
    
end

