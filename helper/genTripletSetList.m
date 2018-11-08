clear
clc

ImgDoc = '/disk1/yangle/dataset/tripletData/train.tri';
claRp = '/disk1/yangle/dataset/tripletData/image/';

fid=fopen(ImgDoc,'w+');
fclose(fid);
claSet = dir(claRp);
claSet = claSet(3:end);
fid=fopen(ImgDoc,'w+');
claNum = length(claSet);

for icla = 1:claNum
    claName = claSet(icla).name;
    fprintf('%s\r', claName);
    imgRp = [claRp, claName, '/'];
    imgSet = dir([imgRp, '*.png']);    
    for iimg = 2:2:length(imgSet)
        imgQurName = [claName, imgSet(iimg-1).name];
        imgPosName = [claName, imgSet(iimg).name];
        
        %randomly select the negetive image
        while 1
            nesOrder = randi([1, claNum]);
            if nesOrder ~= icla
                break;
            end
        end
        negClaName = claSet(nesOrder).name;
        negImgSet = dir([claRp, '/', negClaName, '/*.png']);
        negImgOrder = randi([1, length(negImgSet)]);
        imgNegName = [negClaName, negImgSet(negImgOrder).name];
        
        fprintf(fid, '%s\t%s\t%s\n', imgQurName, imgPosName, imgNegName);
        
    end
    
end