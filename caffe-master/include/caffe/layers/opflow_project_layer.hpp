#ifndef CAFFE_OPFLOW_PROJECT_LAYER_HPP_
#define CAFFE_OPFLOW_PROJECT_LAYER_HPP_

#include "caffe/blob.hpp"
#include "caffe/layer.hpp"
#include "caffe/proto/caffe.pb.h"

namespace caffe {

/*
*according to optical flow, project the salmap to neighbour frame
*/
template <typename Dtype>
class OpflowProjectLayer : public Layer<Dtype> {
 public:
  explicit OpflowProjectLayer(const LayerParameter& param)
      : Layer<Dtype>(param) {}
  virtual void LayerSetUp(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top);
  virtual void Reshape(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top);

  virtual inline const char* type() const { return "OpflowProject"; }
  virtual inline int ExactNumBottomBlobs() const { return 4; }
  virtual inline int ExactNumTopBlobs() const { return 1; }

 protected:
  virtual void Forward_cpu(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top);
  virtual void Backward_cpu(const vector<Blob<Dtype>*>& top,
      const vector<bool>& propagate_down, const vector<Blob<Dtype>*>& bottom);
  
  bool is_forward_;
  
};
	
	
}  // namespace caffe

#endif  // CAFFE_OPFLOW_PROJECT_LAYER_HPP_

