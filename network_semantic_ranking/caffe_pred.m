clear, clc

if exist('./caffe-master/matlab/+caffe', 'dir')
  addpath('./caffe-master/matlab/');
else
  error('Please run this demo from caffe/matlab/demo');
end

 caffe.reset_all();
% Set caffe mode
use_gpu=1;
if exist('use_gpu', 'var') && use_gpu
  caffe.set_mode_gpu();
  gpu_id = 2; 
  caffe.set_device(gpu_id);
else
  caffe.set_mode_cpu();
end

modelRp = '/disk2/yangle/result/model/triStyle5loss/';
imgRp='/disk2/yangle/BasicDataset/DAVIS/mImage/';
resImgRp = '/disk2/yangle/result/salmap/triStyle5loss/';

modelSet = dir([modelRp, '*.caffemodel']);
imgSet=dir([imgRp, '*.png']);
imgNum = length(imgSet);

mean_rgb =[ 115.269, 122.346, 122.819];
batch_size=1;
CROPPED_DIM=224;
image_rgb=zeros(CROPPED_DIM, CROPPED_DIM, 3, batch_size, 'single');

phase = 'test'; 

for imod = 1:length(modelSet)
    modelName = modelSet(imod).name;
    folName = modelName(1:(end-11));
    net_weights = [modelRp, modelName];    
    
    net_model = './ROS_deploy.prototxt';
    saveRootPathImg = [resImgRp,folName, '/'];
    if ~exist(saveRootPathImg,'dir')
        mkdir(saveRootPathImg);
    end

    net = caffe.Net(net_model, net_weights, phase);

    for j=1:imgNum
        imgname = imgSet(j).name;
        %if exist([saveRootPathImg, imgname], 'file')
         %   continue;
        %end
        fprintf('%d  ',j);
        rgb=imread([imgRp  imgname]);  
        [imgrows,imgcols,~]=size(rgb);
        rgb= prepare_image(rgb,mean_rgb);
        image_rgb(:,:,:,1)=imresize(rgb,[CROPPED_DIM,CROPPED_DIM],'bilinear');
        image{1}=image_rgb;    
        prescores=net.forward(image);
        scores = prescores{1};

        samp=scores(:,:,2);
        salmap=permute(samp,[2,1]);
        imgname=imgSet(j).name;
        salmap=imresize(salmap,[imgrows,imgcols],'bilinear');
        
        %normalization
        maxValue = max(max(salmap));
        salmap = salmap / maxValue;
        
        salmap=uint8(255*salmap);
        saveImgName = [imgname(1:end-3), 'png'];

        imwrite(salmap,[saveRootPathImg, imgname],'png');
    end
     caffe.reset_all();
end







