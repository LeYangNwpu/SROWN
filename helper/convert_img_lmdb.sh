echo "Creating train rgb lmdb..."

/disk2/yangle/software/caffe-master/.build_release/tools/convert_imageset \
/disk2/yangle/dataset/augTrainImg/ \
/disk2/yangle/dataset/trainImgList.txt \
/disk2/yangle/dataset/lmdb/train_img_lmdb \

echo "Done."
