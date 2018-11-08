clear
clc

oriImgPath = '/disk1/yangle/dataset/dataset/img/';
oriMaskPath = '/disk1/yangle/dataset/dataset/mask/';
resImgPath = '/disk1/yangle/dataset/dataset/valimage/';
resMaskPath = '/disk1/yangle/dataset/dataset/valmask/';

testNum = 1000;

imgSet = dir([oriImgPath, '*.jpg']);

for iimg = 1:testNum
    disp(iimg);
    imgNum = length(imgSet);
    order=randi([1,imgNum]);
    imgName = imgSet(iimg).name;
    copyfile([oriImgPath, imgName], [resImgPath, imgName]);
    delete([oriImgPath, imgName]);
    maskName = [imgName(1:end-3), 'png'];
    copyfile([oriMaskPath, maskName], [resMaskPath, maskName]);
    delete([oriMaskPath, maskName]);
    imgSet(order) = [];
end
