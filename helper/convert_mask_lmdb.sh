echo "Creating train gt lmdb..."

/disk2/yangle/software/caffe-master/.build_release/tools/convert_imageset \
-gray \
/disk2/yangle/dataset/triDataset/mOpflowImg/ \
/disk2/yangle/dataset/triDataset/opflowImgList_x.txt \
/disk2/yangle/dataset/triDataset/lmdb/opX_lmdb \

echo "Done."
