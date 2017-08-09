#include <iostream>
#include"opencv2/opencv.hpp"
#include"opencv2/core/core.hpp"
#include"opencv2/imgproc/imgproc.hpp"
#include"opencv2/highgui/highgui.hpp"
#include"opencv2/ml/ml.hpp"
#include<cstdlib>
#include<stdio.h>
#include<string.h>

#define TESTNUM   3334     ///测试样本数
#define TRAINNUM  6666  ///训练样本数
#define TYPENUM  2      ///类别
#define vec_len  70
#define P_h      100
#define P_w      100
#define TARGETNUM 57   ///目标数

using namespace std;
using namespace cv;
typedef struct {
	float img[vec_len];
	float type;
}datastruct;
typedef struct{
	float val[vec_len];
}HyperData;
HyperData Data[P_h][P_w];  //存放高光谱数据10~79波段
float trainLabels[TRAINNUM];
float testLabels[TESTNUM];
datastruct TRAIND[TRAINNUM];
datastruct TESTD[TESTNUM];
Mat train[TRAINNUM];  ///训练数据
Mat test[TESTNUM];	  ///测试数据
Mat Test_all[10000];
Mat trainmat;         ///训练矩阵
Mat trainLabel;       ///训练标签
Mat testLabel;        ///测试标签
int labelGT[P_h][P_w], GT[P_h][P_w];  ///存储groundtruth
int allTestlabel[10000];
Mat mergeRows(Mat A, Mat B)
{
	int totalRows;
	if (A.cols == B.cols&&A.type() == B.type())
	{
		totalRows = A.rows + B.rows;
	}
	else
	{
		std::cout << "Error 维数不匹配!" << std::endl;
	}
	Mat mergedDescriptors(totalRows, A.cols, A.type());
	Mat submat = mergedDescriptors.rowRange(0, A.rows);
	A.copyTo(submat);
	submat = mergedDescriptors.rowRange(A.rows, totalRows);
	B.copyTo(submat);
	return mergedDescriptors;
}

int main()
{


	cout << CV_VERSION << endl;
	///读取类标
	FILE *label = fopen("gt.txt", "r");
	int l = 10, ss = 0;
	for (int i = 0; i < P_h; i++)
	{
		for (int j = 0; j < P_w; j++)
		{
			fscanf(label, "%d", &labelGT[i][j]);
			GT[i][j] = labelGT[i][j];   //备份
		}
	}

	///读取全部样本
	FILE *fp = fopen("data.txt", "r");
	for (int i = 0; i<P_h; i++)
		for (int k = 0; k<vec_len; k++)   ///原始TXT文档按照行顺序存储
			for (int j = 0; j < P_w; j++)
				fscanf(fp, "%f", &Data[i][j].val[k]);


	int sum_t = 0;
	int sum_b = 0;
	for (int i = 0; i<P_h; i++)
		for (int j = 0; j<P_w; j++)
		{
			if (labelGT[i][j] == 1)
			{
				sum_t++;
				if (sum_t >= 38)
					labelGT[i][j] = 2;    //正类测试样本
			}
			else if (labelGT[i][j] == 0)
			{
				sum_b++;
				if (sum_b >= 6630)
					labelGT[i][j] = 3;    //负类测试样本
			}
		}
	///构造训练样本
		int TRAIND_index = 0;
		for (int i = 0; i < P_h; i++)
		{
			for (int j = 0; j<P_w; j++)
			{
				if (labelGT[i][j] == 0)
				{
					trainLabels[TRAIND_index] = 0;
					for (int k = 0; k<vec_len; k++)
						TRAIND[TRAIND_index].img[k] = Data[i][j].val[k];
					TRAIND[TRAIND_index].type = 0;

				}
				else if (labelGT[i][j] == 1)
				{
					trainLabels[TRAIND_index] = 1;
					for (int k = 0; k<vec_len; k++)
						TRAIND[TRAIND_index].img[k] = Data[i][j].val[k];
					TRAIND[TRAIND_index].type = 1;
				}
				TRAIND_index++;
			}
		}

	///构造测试样本
	int TESTD_index = 0;
	for (int i = 0; i < P_h; i++)
	{
		for (int j = 0; j<P_w; j++)
		{
			if (labelGT[i][j] == 3||labelGT[i][j]==2)
			{
				for (int k = 0; k<vec_len; k++)
					TESTD[TESTD_index].img[k] = Data[i][j].val[k];
				TESTD_index++;
				if (labelGT[i][j] == 3)
				{
					testLabels[TESTD_index] = 0;
					TESTD[TESTD_index].type = 0;
				}
				else
				{
					testLabels[TESTD_index] = 1;
					TESTD[TESTD_index].type = 1;
				}
			}
		}
	}

	for (int i = 0; i<TRAINNUM; i++)
	{
		train[i] = Mat(1, vec_len, CV_32FC1, TRAIND[i].img);
	}
	trainLabel = Mat(TRAINNUM, 1, CV_32FC1, trainLabels);
	//cout<<trainLabel;
	for (int i = 0; i<TESTNUM; i++)
	{
		test[i] = Mat(1, vec_len, CV_32FC1, TESTD[i].img);
	}
	for (int i = 0; i<P_h; i++)
	{
		for (int j = 0; j < P_w; j++)
		{
			Test_all[i*P_h+j] = Mat(1, vec_len, CV_32FC1, Data[i][j].val);
			allTestlabel[i*P_h + j] = GT[i][j];
		}
	}
	/*************************合成训练矩阵********************************/
	trainmat = train[0].clone();
	for (int i = 1; i < TRAINNUM; i++)
		trainmat = mergeRows(trainmat, train[i]);
	printf("trainmatrows=: %d cols=%d\n", trainmat.rows, trainmat.cols);
	printf("trainrows: %d cols=%d\n", trainLabel.rows, trainLabel.cols);
	CvSVMParams params = CvSVMParams();
	params.svm_type = SVM::C_SVC;
	params.kernel_type = SVM::RBF;
	params.gamma = 2.2500000000000003e-03;
	params.C = 1;
	params.term_crit = cvTermCriteria(CV_TERMCRIT_EPS, 100000, 0.000001);

	CvSVM SVM;

	SVM.train_auto(trainmat, trainLabel, Mat(), Mat(), params, 10);
	SVM.save("trainSample.xml");
	int Map[10000];
	int cnt = 0;
	float eta = 0.000001;
	for (int i = 0; i<10000; i++)
	{
		float res = -1.0;
		res = SVM.predict(Test_all[i]);
		//printf("%f %f\n", res, testLabels[i]);
		if (abs(res - allTestlabel[i])<eta)
			cnt++;
		if (abs(res - 1.0) < 0.01)
			Map[i] = 1;
		else
			Map[i] = 0;
	}
	freopen("Map.txt", "w", stdout);
	for (int i = 0; i < 10000; i++)
	{
		cout << Map[i] << " ";
		if (i % 100 == 0)
			cout << endl;
	}

	cout << "accuracy=" << (double)cnt / (double)10000;
	freopen("out.txt", "w", stdout);
	int c = SVM.get_support_vector_count();
	printf("support vector is %d\n", c);
	for (int i = 0; i<c; i++)
	{
		const float* v = SVM.get_support_vector(i);
		for (int j = 0; j<vec_len; j++)
			printf("%f ", v[j]);
		printf("\n");
	}
	return 0;
}
