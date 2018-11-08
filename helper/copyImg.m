clear
clc

oriImgRp = '/home/nianliu/Data/Salient_Object/Benchmarks/MSRA10K/MSRA10K_Imgs_GT/GT/';
resImgRp = '/home/yangle/dataset/ROS/image/testMask/';

imgFiles = dir([oriImgRp ,'/*.png']);
imgNum = length(imgFiles);

for iimg = (round(0.9 * imgNum)+1):imgNum
    disp(iimg);
    imgName = imgFiles(iimg).name;
    copyfile([oriImgRp, imgName], [resImgRp, imgName]);    
end