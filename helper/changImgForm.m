clear
clc

oriClaRp = '/home/yangle/BasicDataset/dataset/Annotations/';
resClaRp = '//home/yangle/BasicDataset/dataset/newAnnotations/';

claSet = dir(oriClaRp);
claSet = claSet(3:end);
for icla = 1:length(claSet)
    claName = claSet(icla).name;
    oriImgRp = [oriClaRp, claName, '/'];
    resImgRp = [resClaRp, claName, '/'];
    if ~exist(resImgRp, 'dir')
        mkdir(resImgRp);
    end
    imgSet = dir([oriImgRp, '*.jpg']);
    parfor iimg = 1:length(imgSet)
        oriImgName = imgSet(iimg).name;
        img = imread([oriImgRp, oriImgName]);
        img(img < 30) = 0;
        img(img >= 30) = 255;
        imwrite(img, [resImgRp, oriImgName], 'jpg');    
    end
        
end

% imgSet = dir([oriImgRp, '*.png']);
% parfor iimg = 1:length(imgSet)
%     oriImgName = imgSet(iimg).name;
%     img = imread([oriImgRp, oriImgName]);
%     resImgName = [oriImgName(1:end-3), 'jpg'];
%     imwrite(img, [resImgRp, resImgName], 'jpg');    
% end