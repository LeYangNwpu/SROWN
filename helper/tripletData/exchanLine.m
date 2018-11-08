clear
clc

% oriTriPath = 'oriTriImgList.tri';
% resTriPath = 'triImgList.tri';
% oriTxtPath = 'oriOpflowImgList.txt';
% resTxtPath = 'opflowImgList.txt';

oriTriPath = '/disk2/yangle/dataset/triDataset/oriTriImgList.tri';
resTriPath = '/disk2/yangle/dataset/triDataset/triImgList.tri';
oriTxtPath = '/disk2/yangle/dataset/triDataset/oriOpflowImgList.txt';
resTxtPathX = '/disk2/yangle/dataset/triDataset/opflowImgList_x.txt';
resTxtPathY = '/disk2/yangle/dataset/triDataset/opflowImgList_y.txt';

oriTriFid = fopen(oriTriPath, 'r');
resTriFid = fopen(resTriPath, 'w+');
frewind(oriTriFid); 
frewind(resTriFid); 
oriTxtFid = fopen(oriTxtPath, 'r');
resTxtFidX = fopen(resTxtPathX, 'w+');
resTxtFidY = fopen(resTxtPathY, 'w+');
frewind(oriTxtFid);
frewind(resTxtFidX);
frewind(resTxtFidY);

curTriString = fread(oriTriFid,'*char');
curTriString = curTriString';
placeTriInf = strfind(curTriString, '.png');
curTxtString = fread(oriTxtFid, '*char');
curTxtString = curTxtString';
placeTxtInf = strfind(curTxtString, '.png');
lengthTxtInf = placeTxtInf;
lengthTxtInf(1) = placeTxtInf(2) - placeTxtInf(1);
lengthTxtInf(2:length(lengthTxtInf)) = lengthTxtInf(2:length(lengthTxtInf)) - placeTxtInf(1:length(placeTxtInf)-1);


outputNum = 1;
while placeTriInf
    disp(outputNum);
    lineNum = length(placeTriInf)/3;
    order=randi([1,lineNum]);
    
    %generate txt list
    strLength = lengthTxtInf(order);
    
    txtBeginPlace = placeTxtInf(order) - strLength + 8;
    txtEndPlace = placeTxtInf(order) + 5;
    txtCpString = curTxtString(txtBeginPlace:txtEndPlace);
    for iTxt = 1:2
        if iTxt == 1
            txtCpString = [txtCpString(1:end-6), '_x', '.png 0'];
            resTxtFid = resTxtFidX;
            fprintf('%s\r', txtCpString);
            fprintf(resTxtFid, '%s\r\n', txtCpString);
        else
            txtCpString = [txtCpString(1:end-8), '_y', '.png 0'];
            resTxtFid = resTxtFidY;
            fprintf('%s\r', txtCpString);
            fprintf(resTxtFid, '%s\r\n', txtCpString);
        end
    end
    
    placeTxtInf(order) = [];
    lengthTxtInf(order) = [];
        
    
    place1 = placeTriInf(order*3 - 2);
    place2 = placeTriInf(order*3 - 1);
    place3 = placeTriInf(order*3);
    
    inter1_2 = place2 - place1;
    beginPlace = place1 - (inter1_2-1) + 4;
    endPlace = place3 + 5;
    
    copyString = curTriString(beginPlace:endPlace);
    fprintf(resTriFid, '%s\r\n', copyString);
    
    placeTriInf(order*3-2 : order*3) = [];
    outputNum = outputNum + 1;

end

fclose(oriTriFid);
fclose(resTriFid);
fclose(oriTxtFid);
fclose(resTxtFidX);
fclose(resTxtFidY);
    


