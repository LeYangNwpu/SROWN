clear
clc

oriClaImgRp = '/disk2/yangle/dataset/triDataset/hieImage/';
oriClaMaskRp = '/disk2/yangle/dataset/triDataset/hieMask/';
resImgRp = '/disk2/yangle/dataset/triDataset/image/';
resMaskRp = '/disk2/yangle/dataset/triDataset/mask/';

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
    
    beginOrd = 1;
    endOrd = round(length(imgSet) * 0.9);
    
    %parfor iimg = beginOrd:endOrd
    for iimg = 1:length(imgSet)
        imgName = imgSet(iimg).name;
        img = imread([oriImgRp, imgName]);
        img = imresize(img, [448,448], 'bilinear');
        resImgName = [claName, imgName];
        imwrite(img, [resImgRp, resImgName], 'png');
        mask = imread([oriMaskRp, imgName]);
        %mask = rgb2gray(mask);
        mask = imresize(mask, [448,448], 'bilinear');        
        mask(mask<30) = 0;
        mask(mask>=30) = 255;
        imwrite(mask, [resMaskRp, resImgName], 'png');        
    end    
    
end