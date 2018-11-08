#include <opencv2/core/core.hpp>
#include <opencv2/opencv.hpp>

#include "caffe/layers/opflow_project_layer.hpp"
#include "caffe/util/math_functions.hpp"

namespace caffe {
	
template <typename Dtype>
void OpflowProjectLayer<Dtype>::LayerSetUp(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top) {
	CHECK_EQ(bottom[0]->count(), bottom[1]->count());
	CHECK_EQ(bottom[0]->count(), bottom[2]->count());
	
    OpflowProjectParameter opflow_project_param = this->layer_param_.opflow_project_param();
	is_forward_ = opflow_project_param.is_forward();	
}
	
template <typename Dtype>
void OpflowProjectLayer<Dtype>::Reshape(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top) {
	top[0]->ReshapeLike(*bottom[0]);
}

template <typename Dtype>
void OpflowProjectLayer<Dtype>::Forward_cpu(
    const vector<Blob<Dtype>*>& bottom, const vector<Blob<Dtype>*>& top) {
		
	const int count = bottom[0]->count();
	const int height = bottom[0]->height();
	const int width = bottom[0]->width();
		
	Dtype* salmapCur = bottom[0]->mutable_cpu_data();
	Dtype* opflowX = bottom[1]->mutable_cpu_data();
	Dtype* opflowY = bottom[2]->mutable_cpu_data();	
	const Dtype* opflowLabel = bottom[3]->cpu_data();
	Dtype* salmapProj = top[0]->mutable_cpu_data();
	
	
	if (opflowLabel[0] == Dtype(1))
	{
		caffe_scal(count, Dtype(-1), opflowX);
		caffe_scal(count, Dtype(-1), opflowY);
	}
	if (!is_forward_)
	{
		caffe_scal(count, Dtype(-1), opflowX);
		caffe_scal(count, Dtype(-1), opflowY);
	}
	

	cv::Mat opImgX;
	opImgX.create(height, width, CV_32FC1);	
	int pixCount = 0;
	for (int i = 0;i < height;i++)
		for (int j = 0;j < width;j++)
		{
			opImgX.at<float>(i,j) = opflowX[pixCount];
			pixCount++;
		}
		
	cv::Mat opImgY;
	pixCount = 0;
	opImgY.create(height, width, CV_32FC1);	
	for (int i = 0;i < height;i++)
		for (int j = 0;j < width;j++)
		{
			opImgY.at<float>(i,j) = opflowY[pixCount];
			pixCount++;
		}
	
	cv::Mat meshX, meshY;
    meshX.create(height, width,CV_32FC1);
    meshY.create(height, width,CV_32FC1);
    cv::Range xgv = cv::Range(0,meshX.cols - 1);
    cv::Range ygv = cv::Range(0,meshX.rows - 1);
    std::vector<float> t_x, t_y;
    for (int i = xgv.start; i <= xgv.end; i++) t_x.push_back(i);
    for (int j = ygv.start; j <= ygv.end; j++) t_y.push_back(j);
    cv::repeat(cv::Mat(t_x).t(), t_y.size(), 1, meshX);
    cv::repeat(cv::Mat(t_y), 1, t_x.size(), meshY);
	
	cv::Mat srcMask;
	srcMask.create(height, width, CV_32FC1);	
	pixCount = 0;
	for (int i = 0;i < height;i++)
		for (int j = 0;j < width;j++)
		{
			srcMask.at<float>(i,j) = salmapCur[pixCount];
			pixCount++;
		}
	
	cv::Mat offsetX = meshX + opImgX;
    cv::Mat offsetY = meshY + opImgY;
	
	cv::Mat resMask;
    resMask.create(height, width, CV_32FC1);
	cv::remap(srcMask,resMask,offsetX,offsetY,cv::INTER_LINEAR,0,cv::Scalar::all(0));
	pixCount = 0;
	for (int i = 0;i < height;i++)
		for (int j = 0;j < width;j++)
		{
			salmapProj[pixCount] = resMask.at<float>(i,j);
			pixCount++;
		}
	
}

template <typename Dtype>
void OpflowProjectLayer<Dtype>::Backward_cpu(const vector<Blob<Dtype>*>& top,
    const vector<bool>& propagate_down, const vector<Blob<Dtype>*>& bottom) {
	//not implementation
	const Dtype* salmapProj_diff = top[0]->cpu_diff();
	Dtype* salmapCur_diff = bottom[0]->mutable_cpu_diff();
	Dtype* opflowX_diff = bottom[1]->mutable_cpu_diff();
	Dtype* opflowY_diff = bottom[2]->mutable_cpu_diff();
	Dtype* opflowLabel_diff = bottom[3]->mutable_cpu_diff();
	
	const int count = top[0]->count();
	caffe_copy(count, salmapProj_diff, salmapCur_diff);
	//must we set the opflowX_diff & opflowY_diff to be zero?
	caffe_set(count, Dtype(0), opflowX_diff);
	caffe_set(count, Dtype(0), opflowY_diff);
	caffe_set(Dtype(1), Dtype(0), opflowLabel_diff);
		
}
	
INSTANTIATE_CLASS(OpflowProjectLayer);
REGISTER_LAYER_CLASS(OpflowProject);
	
}  // namespace caffe

