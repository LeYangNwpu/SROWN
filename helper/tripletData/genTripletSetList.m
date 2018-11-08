clear
clc

triImgList = '/disk2/yangle/dataset/triDataset/oriTriImgList.tri';
opflowImgList = '/disk2/yangle/dataset/triDataset/oriOpflowImgList.txt';
claRp = '/disk2/yangle/dataset/triDataset/hieMask/';

fid=fopen(triImgList,'w+');
fclose(fid);
fidOp = fopen(opflowImgList, 'w+');
fclose(fidOp);
claSet = dir(claRp);
claSet = claSet(3:end);
fid=fopen(triImgList,'w+');
fidOp = fopen(opflowImgList, 'w+');
claNum = length(claSet);

for icla = 1:claNum
    claName = claSet(icla).name;
    fprintf('%s\r', claName);
    imgRp = [claRp, claName, '/'];
    imgSet = dir([imgRp, '*.png']);
    imgNum = length(imgSet);
    
     for iimg = 2:2:length(imgSet)
        imgQurName = [claName, imgSet(iimg-1).name];
        imgPosName = [claName, imgSet(iimg).name];
        
        imgNameFore =  imgSet(iimg-1).name;
        imgNameBack =  imgSet(iimg).name;
        opName = [claName, 'op', imgNameFore(1:end-4), 'To', imgNameBack];
        fileStr = [opName, ' 0'];
        fprintf(fidOp, '%s\r\n', fileStr);
        
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
        
        IsSameShot = '0';
        
        fprintf(fid, '%s\t%s\t%s %s\n', imgQurName, imgPosName, imgNegName, IsSameShot);
        
    end
         
end

