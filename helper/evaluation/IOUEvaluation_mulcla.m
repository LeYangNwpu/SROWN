clear
clc

vidgtrp='/disk2/yangle/BasicDataset/DAVIS/GroundTruth/';
claVidImgRp = '/disk2/yangle/code/GrabCut1/result/';
claSet = dir(claVidImgRp);
claSet = claSet(3:end);
claNum = length(claSet);
clarec = cell(1, claNum);

for icla = 1:claNum
    claName = claSet(icla).name;
    imgrp = [claVidImgRp, claName, '/'];
      
    gtrp=vidgtrp;
    imgset=dir([imgrp,'*.png']);
    imgnum=length(imgset);
    iourec=zeros(1,imgnum);    
    parfor iimg=1:imgnum
        fprintf('%d  ',iimg);
        imgname=imgset(iimg).name;        
        
        img=imread([imgrp,imgname]);
        
        gt=imread([gtrp,imgname]);
%         [imgrows,imgcols]=size(img);
%         [gtrows,gtcols]=size(gt);
%         if (imgrows~=gtrows) || (imgcols~=gtcols)
%             img=imresize(img,[gtrows,gtcols],'bilinear');
%         end
        interimg=bitand(img,gt);
        unionimg=bitor(img,gt);
        interimg=logical(interimg);
        unionimg=logical(unionimg);
        if sum(sum(unionimg))~=0
            iourec(iimg)=sum(sum(interimg))/sum(sum(unionimg));
        else
            iourec(iimg)=1;
        end    
    end    
    clarec{icla}=iourec;    
end

matName = 'IOU.mat';
save(matName,'clarec','claSet');