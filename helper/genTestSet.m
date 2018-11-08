clear
clc

oriClaRp = '/home/yangle/dataset/cropedTrainImg/';
resClaRp = '/home/yangle/dataset/cropedTestImg/';

claSet = dir(oriClaRp);
claSet = claSet(3:end);
for icla = 1:length(claSet)
    claName = claSet(icla).name;
    fprintf('%s\r', claName);
    oriImgRp = [oriClaRp, claName, '/'];
    resImgRp = [resClaRp, claName, '/'];
    if ~exist(resImgRp, 'dir')
        mkdir(resImgRp);
    end
        
    imgSet = dir([oriImgRp, '*.jpg']);    
    numTestImg = round(length(imgSet)/6);
    for iimg = 1:numTestImg
        imgName = imgSet(iimg).name;
        copyfile([oriImgRp, imgName], [resImgRp, imgName]);
    end
    
end