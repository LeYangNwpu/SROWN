clear
clc

oriClaPath = '/disk1/yangle/BasicDataset/DAVIS/Image/';
resClaPath = '/disk1/yangle/dataset/lmdb-style/train_img/';
claSet = dir(oriClaPath);
claSet = claSet(3:end);

for icla = 1:length(claSet)
    claName = claSet(icla).name;
    disp(claName);
    oriImgRp = [oriClaPath, claName, '/'];
    imgSet = dir([oriImgRp, '*.png']);
    
    selImgNum = round(0.9 * length(imgSet));
    parfor iimg = 1:selImgNum
        oriImgName = imgSet(iimg).name;
        img = imread([oriImgRp, oriImgName]);
        img = imresize(img, [224, 224], 'bilinear');
        %img(img<30) = 0;
        %img(img>=30) = 255;
        resImgName = [claName, oriImgName];
        imwrite(img, [resClaPath, resImgName], 'png');        
        
    end
        
end



