clear
clc

lstPath = '/disk1/yangle/dataset/tripletData/train.lst';
claRp = '/disk1/yangle/dataset/tripletData/image-ori/';

fid=fopen(lstPath,'w+');
fclose(fid);
claSet = dir(claRp);
claSet = claSet(3:end);
fid=fopen(lstPath,'w+');
for icla = 1:length(claSet)
    claName = claSet(icla).name;
    fprintf('%s\r', claName);
    imgRp = [claRp, claName, '/'];
    imgSet = dir([imgRp, '*.png']);    
    for iimg = 1:length(imgSet)
        imgName = imgSet(iimg).name;
        fileName = [claName, imgName, ' ', num2str(icla-1)];
        fprintf(fid, '%s\r\n', fileName);        
    end    
end
