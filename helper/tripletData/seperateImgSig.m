clear
clc

imgOriRp = '/disk1/yangle/dataset/image_data/train_mask/';
claResRp = '/disk1/yangle/dataset/tri-style/sep_train/';

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


