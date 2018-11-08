clear
clc

CROPED_SIZE = 224;

gtRp = '/home/yangle/BasicDataset/dataset/mAnnotation/';
imgRp = '/home/yangle/BasicDataset/dataset/mImg/';
cropedImgRp = '/home/yangle/result/cropedImg/';

imgSet = dir([imgRp, '*.jpg']);
for iimg = 1:length(imgSet)
    disp(iimg);
    imgName = imgSet(iimg).name;
    gtName = [imgName(1:end-3), 'png'];
    gt = imread([gtRp, gtName]);
    oriImg = imread([imgRp, imgName]);
    
    [x, y] = find(gt == 255);
    if isempty(x) && isempty(y)
        continue;
    end    
    x_min = min(x);
    x_max = max(x);
    y_min = min(y);
    y_max = max(y);
    
    cropedImg = oriImg(x_min:x_max, y_min:y_max, :);
    cropedImg = imresize(cropedImg, [CROPED_SIZE, CROPED_SIZE], 'bilinear');    
    imwrite(cropedImg, [cropedImgRp, imgName], 'jpg');
    
end