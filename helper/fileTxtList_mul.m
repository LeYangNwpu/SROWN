clear
clc

txtImgPath = '/disk1/yangle/dataset/lmdb/trainImgList.txt';
txtMaskPath = '/disk1/yangle/dataset/lmdb/trainMaskList.txt';
imgRp = '/disk1/yangle/dataset/augTrainImage/';

fidImg=fopen(txtImgPath,'w+');
fclose(fidImg);
fidMask=fopen(txtMaskPath,'w+');
fclose(fidMask);
imgSet = dir([imgRp, '*.jpg']);
imgnum=length(imgSet);
fidImg = fopen(txtImgPath,'w');
fidMask = fopen(txtMaskPath,'w');
while imgnum    
    order=randi([1,imgnum]);
    imgName=imgSet(order).name;
    imgFileName=[imgName,' 0'];
    fprintf(fidImg, '%s\r\n', imgFileName);
    maskName = [imgName(1:end-3), 'png'];
    maskFileName = [maskName, ' 0'];
    fprintf(fidMask, '%s\r\n', maskFileName);
    imgSet(order)=[];
    imgnum=length(imgSet);
end
fclose(fidImg);


