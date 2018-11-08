clear
clc

oriTriPath = '/disk2/yangle/dataset/triDataset/oriTriImgList.tri';
resTriPath = '/disk2/yangle/dataset/triDataset/triImgList.tri';

oriTriFid = fopen(oriTriPath, 'r');
resTriFid = fopen(resTriPath, 'w+');
frewind(oriTriFid); 
frewind(resTriFid); 

curString = fread(oriTriFid,'*char');
curString = curString';
placeInf = strfind(curString, '.png');

outputNum = 1;
while placeInf
    disp(outputNum);
    lineNum = length(placeInf)/3;
    order=randi([1,lineNum]);
    
    place1 = placeInf(order*3 - 2);
    place2 = placeInf(order*3 - 1);
    place3 = placeInf(order*3);
    
    inter1_2 = place2 - place1;
    beginPlace = place1 - (inter1_2-1) + 4;
    endPlace = place3 + 3;
    
    copyString = curString(beginPlace:endPlace);
    fprintf(resTriFid, '%s\r\n', copyString);
    
    placeInf(order*3-2 : order*3) = [];
    outputNum = outputNum + 1;

end

fclose(oriTriFid);
fclose(resTriFid);
    


