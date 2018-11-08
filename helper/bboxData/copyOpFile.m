clear, clc

oriClaOpPh = '/disk2/donzhang/dataset/DAVIS/optflow/augTrainImgOpticalFlow/';
resClaOpPh = '/disk2/yangle/dataset/opticalFlow/';
claImgPh = '/disk2/yangle/BasicDataset/DAVIS/Image/';

claSet = dir(claImgPh);
claSet = claSet(3:end);
for icla = 1:length(claSet)
    claName = claSet(icla).name;
    disp(claName);
    oriOpPh = [oriClaOpPh, claName, '/'];
    resOpPh = [resClaOpPh, claName, '/'];
    if ~exist(resOpPh, 'dir')
        mkdir(resOpPh);
    end
    
    imgPh = [claImgPh, claName, '/'];
    imgSet = dir([imgPh, '*.png']);
    for iimg = 1:length(imgSet)-1
        fprintf('%d  ', iimg);
        imgCurName = imgSet(iimg).name;
        imgNextName = imgSet(iimg+1).name;
        matCurName = imgCurName(1:5);
        matNextName = imgNextName(1:5);
        parfor iord = 1:12
            order = num2str(iord, '%02d');
            matFileName = ['op', matCurName, '-', order, 'To', matNextName, '-', order, '.mat'];
            if exist([resOpPh, matFileName], 'file')
                continue;
            end
            copyfile([oriOpPh, matFileName], [resOpPh, matFileName]);
%             if exist([oriOpPh, matFileName], 'file')
%                 copyfile([oriOpPh, matFileName], [resOpPh, matFileName]);
%             end            
        end
        
    end
    
    
end
