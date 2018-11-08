clear
clc

txtPath = '/disk2/yangle/dataset/lmdb/valList.txt';
imgRp = '/disk2/yangle/dataset/lmdb/augValMask/';

fid=fopen(txtPath,'w+');
fclose(fid);
imgSet = dir([imgRp, '*.png']);
imgnum=length(imgSet);
fid = fopen(txtPath,'w');
while imgnum    
    order=randi([1,imgnum]);
    imgname=imgSet(order).name;
    file_name=[imgname,' 0'];
    fprintf(fid, '%s\r\n', file_name);
    imgSet(order)=[];
    imgnum=length(imgSet);
end
fclose(fid);


