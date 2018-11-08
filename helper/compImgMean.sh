echo "Compute mean file of the image set..."
GLOG_logtostderr=0 GLOG_log_dir=./Log/ \
/disk2/yangle/software/caffe-master/.build_release/tools/compute_image_mean \
/disk2/yangle/dataset/lmdb/lmdb/train_image_lmdb \
/disk2/yangle/dataset/lmdb/lmdb/imageMean.binaryproto 

echo "Done."