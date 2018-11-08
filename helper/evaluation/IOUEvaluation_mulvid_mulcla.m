clear
clc

vidgtrp = '/disk2/yangle/BasicDataset/DAVIS/GroundTruth/';
claVidImgRp = '/disk2/yangle/result/GrabCut/sepTriStyle-5-loss/';
claSet = dir(claVidImgRp);
claSet = claSet(3:end);

for icla = 1:length(claSet)
    claName = claSet(icla).name;
    vidimgrp = [claVidImgRp, claName, '/'];    

    vidset=dir(vidimgrp);
    vidset=vidset(3:end);
    vidnum=length(vidset);
    vidrec=cell(1,vidnum);
    for ivid=1:vidnum
        vidname=vidset(ivid).name;
        imgrp=[vidimgrp,vidname,'/'];
        gtrp=[vidgtrp,vidname,'/'];

        imgset=dir([imgrp,'*.png']);
        imgnum=length(imgset);
        iourec=zeros(1,imgnum);    
        parfor iimg=1:imgnum
            fprintf('%d  ',iimg);
            imgname=imgset(iimg).name;
            img=imread([imgrp,imgname]);
            
            img(img < 30) = 0;
            img(img >= 30) = 255;
            
            gt=imread([gtrp,imgname]);
%             [imgrows,imgcols]=size(img);
%             [gtrows,gtcols]=size(gt);
%             if (imgrows~=gtrows) || (imgcols~=gtcols)
%                 img=imresize(img,[gtrows,gtcols],'bilinear');
%             end
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
        vidrec{ivid}=iourec;    

    end
    matName = [claName, '.mat'];
    save(matName,'vidrec','vidset');

end