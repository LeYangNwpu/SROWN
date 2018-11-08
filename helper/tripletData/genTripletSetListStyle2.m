clear
clc

listDoc = '/disk2/yangle/dataset/triDataset/oriList.tri';
claRp = '/disk2/yangle/dataset/triDataset/hieMask/';

fid=fopen(listDoc,'w+');
fclose(fid);
claSet = dir(claRp);
claSet = claSet(3:end);
fid=fopen(listDoc,'w+');
claNum = length(claSet);

for icla = 1:claNum
    claName = claSet(icla).name;
    fprintf('%s\r', claName);
    imgRp = [claRp, claName, '/'];
    imgSet = dir([imgRp, '*.png']);
    imgNum = length(imgSet);
    for iimg = 1:imgNum
        %quary image
        imgQurName = [claName, imgSet(iimg).name];
       %postive image
        while 1
            posOrder = randi([1, imgNum]);
                if posOrder ~= iimg
                    break;
                end            
        end
         imgPosName = [claName, imgSet(posOrder).name];
        
         %negative image
        for ineg = 1:2
            if ineg == 1
                %from other video shot, randomly select the negetive image
                while 1
                    nesOrder = randi([1, claNum]);
                    if nesOrder ~= icla
                        break;
                    end
                end
                negClaName = claSet(nesOrder).name;
                negImgSet = dir([claRp, '/', negClaName, '/*.png']);
                negOthImgOrder = randi([1, length(negImgSet)]);
                imgNegName = [negClaName, negImgSet(negOthImgOrder).name];
                IsSameShot = '0';
            else
                %from the same shot, randomly select the negetive image
                while 1
                    negSameImgOrder = randi([1, length(imgSet)]);
                    if negSameImgOrder ~= iimg
                        break;
                    end
                end
                imgNegName = [claName, imgSet(negSameImgOrder).name];
                IsSameShot = '1';
            end          
            fprintf(fid, '%s\t%s\t%s %s\n', imgQurName, imgPosName, imgNegName, IsSameShot);
        end
       
        
        
    end
    
end