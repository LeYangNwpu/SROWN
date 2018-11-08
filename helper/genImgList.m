clear
clc

lstPath = '/home/yangle/dataset/test.lst';
claRp = '/home/yangle/dataset/cropedTestImg/';

fid=fopen(lstPath,'w+');
fclose(fid);
claSet = dir(claRp);
claSet = claSet(3:end);
fid=fopen(lstPath,'w+');
for icla = 1:length(claSet)
    claName = claSet(icla).name;
    fprintf('%s\r', claName);
    imgRp = [claRp, claName, '/'];
    imgSet = dir([imgRp, '*.jpg']);    
    for iimg = 1:length(imgSet)
        imgName = imgSet(iimg).name;
        fileName = [claName, imgName, ' ', num2str(icla-1)];
        fprintf(fid, '%s\r\n', fileName);        
    end    
end
