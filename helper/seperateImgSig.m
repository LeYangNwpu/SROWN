clear
clc

imgOriRp = '/disk2/yangle/code/GrabCut1/preTrain_iter_45000/';
claResRp = '/disk2/yangle/code/GrabCut1/sepDataset/salmap/';

imgSet = dir([imgOriRp, '*.png']);
parfor iimg = 1:length(imgSet)
    imgName = imgSet(iimg).name;    
    claName = imgName(1:end-9);
    imgResRp = [claResRp, claName, '/'];
    if ~exist(imgResRp, 'dir')
        mkdir(imgResRp);
    end
    resImgName = imgName(end-8:end);
    copyfile([imgOriRp, imgName], [imgResRp, resImgName]);    
end


