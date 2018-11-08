clear
clc

if exist('/disk1/yangle/software/caffe-master/matlab/+caffe', 'dir')
  addpath('/disk1/yangle/software/caffe-master/matlab/');
else
  error('Please run this demo from caffe/matlab/demo');
end

 caffe.reset_all();
% Set caffe mode
use_gpu=1;
if exist('use_gpu', 'var') && use_gpu
  caffe.set_mode_gpu();
  gpu_id = 1;
  caffe.set_device(gpu_id);
else
  caffe.set_mode_cpu();
end

modelRp = '/disk1/yangle/result/model/tri_style/';
imgRp='/disk1/yangle/dataset/image_data/test_img/';
resImgRp = '/disk1/yangle/result/segimg/tri_style/';

modelSet = dir([modelRp, '*.caffemodel']);
imgSet=dir([imgRp, '*.png']);
imgNum = length(imgSet);

mean_rgb =[100.279, 110.797, 116.304];
batch_size=40;
CROPPED_DIM=224;
image_rgb=zeros(CROPPED_DIM, CROPPED_DIM, 3, batch_size, 'single');

phase = 'test'; 

for imod = 41:length(modelSet)
%for imod = 1:40
    modelName = modelSet(imod).name;
    folName = modelName(1:(end-11));
    net_weights = [modelRp, modelName];    
    
    net_model = './ROS_CovDec_deploy.prototxt';
    saveRootPathImg = [resImgRp,folName, '/'];
    if ~exist(saveRootPathImg,'dir')
        mkdir(saveRootPathImg);
    end

    net = caffe.Net(net_model, net_weights, phase);

    for j=1:(imgNum/batch_size)
        fprintf('%d  ', j);
            for   i= ((j-1)*batch_size+1):j*batch_size
%                 fprintf('%d  ',i);
                        rgb=imread([imgRp,  imgSet(i).name]);  
                        [imgrows,imgcols,~]=size(rgb);
                        rgb= prepare_image(rgb,mean_rgb);
                        k= mod(i,batch_size);
                        if k==0
                            k=batch_size;
                        end
                        image_rgb(:,:,:,k)=imresize(rgb,[CROPPED_DIM,CROPPED_DIM],'bilinear');
            end
            image{1}=image_rgb;    
            prescores=net.forward(image);
            scores = prescores{1};

            parfor ii=1:batch_size
%                 fprintf('%d  ',ii);
                samp=scores(:,:,:,ii);
                salmap=permute(samp,[2,1]);
                imgname=imgSet((j-1)*batch_size+ii).name;
                salmap=imresize(salmap,[imgrows,imgcols],'bilinear');  
                salmap=uint8(255*salmap);
                saveImgName = [imgname(1:end-3), 'png'];
                imwrite(salmap,[saveRootPathImg, saveImgName], 'png');            
            end 
    end
    caffe.reset_all();
end

