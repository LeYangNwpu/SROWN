GLOG_logtostderr=0 GLOG_log_dir=./Log/ \
./caffe-master/.build_release/tools/caffe train \
  --solver=./ROS_solver.prototxt \
  -gpu 1 \
  --weights /disk2/yangle/result/preTrain/preTrain_iter_45000.caffemodel \
  2>&1 | tee ./ROS_train_doc.txt


