clear
clc

oriClaImgRp = '/disk2/yangle/BasicDataset/DAVIS/Image/';
oriClaMaskRp = '/disk2/yangle/code/GrabCut1/result/salmap/';
resImgRp = '/disk2/yangle/dataset/lmdb/trainImg/';
resMaskRp = '/disk2/yangle/dataset/lmdb/trainMask/';

if ~exist(resImgRp, 'dir')
    mkdir(resImgRp);
end
if ~exist(resMaskRp, 'dir')
    mkdir(resMaskRp);
end

claSet = dir(oriClaImgRp);
claSet = claSet(3:end);

for icla = 1:length(claSet)
    claName = claSet(icla).name;
    oriImgRp = [oriClaImgRp, claName, '/'];
    oriMaskRp = [oriClaMaskRp, claName, '/'];
    imgSet = dir([oriImgRp, '*.png']);
    
    beginOrd =  1;
    endOrd = round(length(imgSet) * 0.9);
    
    parfor iimg = beginOrd:endOrd
        imgName = imgSet(iimg).name;
        wImgName = [claName, imgName];
        copyfile([oriImgRp, imgName], [resImgRp, wImgName]);
        copyfile([oriMaskRp, imgName], [resMaskRp, wImgName]);
    end    
    
end