clear
clc

%�趨resize�ĳߴ�
imgSize=224;
maskSize=224;

MaskImgType = '.png';
%data agmentation methods
methods={{'hflip'},{'crop'},{'rotate'}};
paras={{[1,-1]},{{'whole','up','down','left','right','middle'}},{[0]}};
cropFrac=[0.1];

oriClaImgPath = '/disk1/yangle/dataset/hieDataset/trainImg/';
oriClaMaskPath = '/disk1/yangle/dataset/hieDataset/trainMask/';
resClaImgPath = '/disk1/yangle/dataset/hieDataset/augTrainImg/';
resClaMaskPath = '/disk1/yangle/dataset/hieDataset/augTrainMask/';

claSet = dir(oriClaImgPath);
claSet = claSet(3:end);
for icla = 1:length(claSet)
    claName = claSet(icla).name;
    imgPath = [oriClaImgPath, claName, '/'];
    maskPath = [oriClaMaskPath, claName, '/'];
    savePathImg = [resClaImgPath, claName, '/'];
    savePathMask = [resClaMaskPath, claName, '/'];
    
    if  ~exist(savePathImg, 'dir')
        mkdir(savePathImg);
    end
     if  ~exist(savePathMask, 'dir')
        mkdir(savePathMask);
     end
         
    %ͼƬ��ʽ
    imgFiles = dir([imgPath,'/*.png']);
    maskFiles = dir([maskPath,'/*.png']);
    [imgNum,~]=size(imgFiles);

    parfor imgIdx=1:imgNum
        disp(imgIdx);
        imgAgmIdx=0;

        img=imread([imgPath '/' imgFiles(imgIdx).name]);
        img_s=imresize(img,[imgSize,imgSize],'bilinear');
        [imgName,ext]=strtok(imgFiles(imgIdx).name,'.');

        mask=imread([maskPath '/' imgName MaskImgType]);
        mask=double(mask)/255;
        mask_s=imresize(mask,[maskSize,maskSize],'bilinear');
        %imgTmp=[];
        %maskTmp=[];
        for i=1:length(methods{1})
            if strcmp(methods{1}{i},'hflip')
                thisParas1=paras{1}{i};
                for ii=1:length(thisParas1)
                    if thisParas1(ii)==1
                        imgTmp1=img_s;
                        maskTmp1=mask_s;
                    elseif thisParas1(ii)==-1
                        imgTmp1=img_s(:,end:-1:1,:);
                        maskTmp1=mask_s(:,end:-1:1,:);
                    end
                    for j=1:length(methods{2})
                        if strcmp(methods{2}{j},'crop')
                            thisParas2=paras{2}{j};
                            for jj=1:length(thisParas2)
                                for jjj=1:length(cropFrac)
                                    imgTmp2=imgCrop(imgTmp1,thisParas2{jj},cropFrac(jjj));
                                    maskTmp2=imgCrop(maskTmp1,thisParas2{jj},cropFrac(jjj));
                                    for k=1:length(methods{3})
                                        if strcmp(methods{3}{k},'rotate')
                                            thisParas3=paras{3}{k};
                                            for kk=1:length(thisParas3)
                                                if thisParas3(kk)==0
                                                    imgTmp3=imgTmp2;
                                                    maskTmp3=maskTmp2;
                                                else
                                                    imgTmp3=imgRotate(imgTmp2,thisParas3(kk));
                                                    maskTmp3=imgRotate(maskTmp2,thisParas3(kk));
                                                end
                                                imgTmp=imgTmp3;
                                                maskTmp=double(im2bw(maskTmp3,0.5));
                                                imgAgmIdx=imgAgmIdx+1;
                                                saveNameImg=[imgName '-' num2str(imgAgmIdx, '%02d') ext];
                                                saveNameMask=[imgName '-' num2str(imgAgmIdx, '%02d') '.png'];
                                                imwrite(imgTmp,[savePathImg '/' saveNameImg]);
                                                imwrite(maskTmp,[savePathMask '/' saveNameMask]);
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

