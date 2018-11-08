GLOG_logtostderr=0 GLOG_log_dir=./Log/ \
/disk2/yangle/software/caffe-master/.build_release/tools/caffe train \
  --solver=/disk2/yangle/code/opProjTrain/ROS_solver.prototxt \
  -gpu 1 \
  -weights /disk2/yangle/code/opProjTrain/1_8preTrain_iter_7912.caffemodel \
  2>&1 | tee /disk2/yangle/code/opProjTrain/ROS_train_doc.d


