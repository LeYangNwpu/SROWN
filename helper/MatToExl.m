clear
clc

load('./mat/IOU.mat');
claNum = length(clarec);

cloName = 'A';
cloIOU = 'B';
rowNum = 1;

for i=1:claNum
    disp(i);
    
    claName = claSet(i).name;
    namePlace = [cloName, num2str(rowNum)];
    xlswrite('test.xlsx',{claName},'sheet1',namePlace);    
    
    meanIOU=mean(clarec{i});
    meanIOU=(round(meanIOU*10000))/10000;
    iouPlace = [cloIOU, num2str(rowNum)];
    xlswrite('test.xlsx',meanIOU,'sheet1',iouPlace);
    
    rowNum = rowNum + 1;
end
