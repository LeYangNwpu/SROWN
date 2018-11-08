clear
clc

oriImgRp = '/home/yangle/dataset/ROS/image/testImg/';
resImgRp = '/home/yangle/dataset/ROS/image/sizeSelTestImg/';

imgFiles = dir([oriImgRp ,'/*.jpg']);
imgNum = length(imgFiles);

for iimg = 1:imgNum
    disp(iimg);
    imgName = imgFiles(iimg).name;
    img = imread([oriImgRp, imgName]);
    [rows, cols, ~] = size(img);
    if rows == 300 && cols == 400
        copyfile([oriImgRp, imgName], [resImgRp, imgName]);    
    end
    
end



