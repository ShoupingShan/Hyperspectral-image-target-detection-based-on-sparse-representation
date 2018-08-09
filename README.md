
## Introduction

Hyperspectral image target detection based on [sparse representation](https://en.wikipedia.org/wiki/Sparse_approximation),an effective method in Pattern Recognition.  Target detection
aims to separate the specific target pixel from the various backgrounds by the use of known target
pixels or anomalous properties.
The proposed approach relies on the binary hypothesis model of an unknown sample induced by sparse representation.
The sample can be sparsely represented by training samples from the background and target dictionary. The sparse vector
in the model can be recovered by a greedy algorithm [OMP](https://en.wikipedia.org/wiki/Matching_pursuit) .

## Author
  * [@ShoupingShan](https://github.com/ShoupingShan)

##   Bibliography

 1. **[Sub-space Matching](http://ieeexplore.ieee.org/abstract/document/5766028/)**
    
     *Chen Y, Nasrabadi N M, Tran T D. Hyperspectral image classification using dictionary-based sparse representation[J]. IEEE Transactions on Geoscience and Remote Sensing, 2011, 49(10): 3973-3985.*
 2. **[Dual Window](http://ieeexplore.ieee.org/abstract/document/5711635/)**
    
     *Chen Y, Nasrabadi N M, Tran T D. Sparse representation for target detection in hyperspectral imagery[J]. IEEE Journal of Selected Topics in Signal Processing, 2011, 5(3): 629-640.*
  

## Theory (SMSD)

The problem of target detection can be regarded as a competitive relationship of two hypotheses ![](http://latex.codecogs.com/gif.latex?%24H_0%24)(Background) and ![](http://latex.codecogs.com/gif.latex?%24H_1%24)(Target).

![](http://latex.codecogs.com/gif.latex?%24%24%5Cbegin%7Baligned%7DH_0%20%26%20%3DB%5Calpha_b&plus;n%20%5C%5C%5C%5CH_1%26%3DT%5Calpha_t&plus;B%5Calpha_b&plus;n%5Cend%7Baligned%7D%20%24%24)

  T and B are both matrices, their column vectors are divided into target and background subspace. ![](http://latex.codecogs.com/gif.latex?%24%5Calpha_t%24) and ![](http://latex.codecogs.com/gif.latex?%24%5Calpha_b%24) form the coefficient vectors of the coefficients, respectively. N denotes Gaussian random noise, [T,B]represents a cascade matrix of T and B.

![](http://latex.codecogs.com/gif.latex?%24%24%5Cbegin%7Baligned%7Dn_0%20%26%20%3Dx-B%5Calpha_b%3D%28I-P_B%29x%20%5C%5Cn_1%26%3Dx-T%5Calpha_t&plus;B%5Calpha_b%3D%28I-P_%7BTB%7D%29x%5Cend%7Baligned%7D%20%24%24)

  Suppose ![](http://latex.codecogs.com/gif.latex?D_%7BMSD%7D%28x%29%3D%5Cfrac%7Bx%5ET%281-P_B%20%29x%7D%7Bx%5ET%281-P_%7BTB%7D%29x%7D),When D is greater than a certain threshold η, then X is the target.

  That means we need to find a projection matrix p.

  By the sparse representation of knowledge, it is known that the residual error of signal reconstruction can be expressed as:

![](http://latex.codecogs.com/gif.latex?%24%24%5Cbegin%7Baligned%7Dn_0%27%20%26%20%3Dx-A_b%5Calpha%5C%5Cn_1%27%26%3Dx-A%5Cgamma%5Cend%7Baligned%7D%20%24%24)

After comparison we can find:

![](http://latex.codecogs.com/gif.latex?%24%24%5Cbegin%7Baligned%7Dn_0%20%26%20%3D%28I-P_B%29x%5Cto%20x-A_b%5Calpha%27%20%5C%5Cn_1%26%3D%281-P_%7BTB%7D%20%29x%5Cto%20x-A%5Cgamma%5Cend%7Baligned%7D%20%24%24)

Suppose ![](http://latex.codecogs.com/gif.latex?D_%7BMSD%7D%28x%29%3D%5Cfrac%7Bx%5ET%281-A_b%5Calpha%27%20%29x%7D%7Bx%5ET%281-A%5Cgamma%29x%7D),When D is greater than a certain threshold η, then X is the target.

Then it is based on the ROC curve to compare different threshold effects, resulting in the final result.

However, it is better to amend Denominator as ![](http://latex.codecogs.com/gif.latex?%24x%5ET%20%28x-A_t%20%5Cgamma%29x%24) in practice.


## Data

### San Diego hyperspectral dataset (400*400)
![SOURCE](http://i2.bvimg.com/607553/f7bff9a61dabcfb5.png)

### GroundTruth (100*100)
![DT](http://i1.bvimg.com/607553/72923bb1a6b0a913.png)
## Rebuilt

  ### Sparse coefficients
![SC](./mat/local/ima/theta.png)
  ### Rebuild by dict_b and dict_t
![SC_REBUILD](./mat/ima/rebuilt.png)
## Detection

### Sparse Representation
![SR_good](./mat/ima/Sparse.png)
![SR_bad](./mat/ima/ima.png)
### Dual window
![DW](./mat/ima/Dual_window.png)
### Dual window with smooth
![DWS](http://i1.bvimg.com/607553/15915a472f719922.png)
### SVM
![SVM](./mat/ima/SVM.png)


|  |Positive|Negative|Total|Accuracy|
|:-:|:-----:|:------:|:---:|:------:|
|Train|37|6629|6666||
|Test|57|9943|10000|0.9989|

### Fisher

    1. Using all of data

![ALL](./mat/ima/fisher_all.png)




|  |Positive|Negative|Total|Accuracy|
|:-:|:-----:|:------:|:---:|:------:|
|Train|57|9943|10000||
|Test|57|9943|10000|0.9926|


    2. Using part of the data

![PART](./mat/ima/fisher_part.png)

|  |Positive|Negative|Total|Accuracy|
|:-:|:-----:|:------:|:---:|:------:|
|Train|37|6629|6666||
|Test|57|9943|10000|0.985|


## ROC curve
![ROC](./mat/local/ima/local_smooth_new_roc.png)
![ROC_ALL](./mat/local/ima/ROC_all.png)
## Platform
  * [Win10](https://www.microsoft.com/zh-cn)
  * [VS2013](http://www.iplaysoft.com/vs2013.html)
  * [OpenCV 2.4.9](http://opencv.org/)
  * [Matlab r2016b](https://www.mathworks.com/)
## How to run
  > For Sparse Representation

      mat/detect.m
  > For SVM

      svm/main.cpp
  > For Fisher_part

      fisher/fisher.cpp
  > For Fisher_all

      fisher/fisher_all.cpp
## Contact Us
  *shp395210@outlook.com*
