
## Introduction

Hyperspectral image target detection based on [sparse representation](https://en.wikipedia.org/wiki/Sparse_approximation),an effective method in Pattern Recognition.  Target detection
aims to separate the specific target pixel from the various backgrounds by the use of known target
pixels or anomalous properties.
The proposed approach relies on the binary hypothesis model of an unknown sample induced by sparse representation.
The sample can be sparsely represented by training samples from the background and target dictionary. The sparse vector
in the model can be recovered by a greedy algorithm [OMP](https://en.wikipedia.org/wiki/Matching_pursuit) .

## Author
  * [@ShoupingShan](https://github.com/ShoupingShan)

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
![原图](http://thumbnail0.baidupcs.com/thumbnail/f4c39e9279e0072c408ac06258144ccd?fid=676888674-250528-990921214246117&time=1502294400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-K1Qgg76PoyqKY7MZVkB4X9IPP94%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5125653704072191132&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)

### GroundTruth (100*100)
![GT](http://thumbnail0.baidupcs.com/thumbnail/84d697b2c0bca97c195f87adea1d39ff?fid=676888674-250528-1069339338576912&time=1502294400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-pqqwNpefzLfLIYsu1Sn5POLXoys%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5125773466591858797&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
## Rebuilt

  ### Target
  ![Target](http://thumbnail0.baidupcs.com/thumbnail/6f12bd1f666c96b7a2d81ff67128acd5?fid=676888674-250528-403840802942145&time=1502330400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-d9959Tu%2Fq5X76vAhP7yDzsaUxaE%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5135414757900587264&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)

  ### Background
  ![Background](http://thumbnail0.baidupcs.com/thumbnail/f22407fd5733172c52ccc02dd07a30a0?fid=676888674-250528-576378241897516&time=1502330400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-5u37f%2BwR3tKiI7Ywtn8ivPai%2B5w%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5135414757900587264&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)
## Detection

### Sparse Representation
![SR](http://thumbnail0.baidupcs.com/thumbnail/134418c291b3c0c089fa1f9d248e003c?fid=676888674-250528-301138876109000&time=1502294400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-HgvIEwZ%2F1PXMoubg6%2FzB1a7MsfE%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5125856103108996112&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)

### SVM
  ![SVM](http://thumbnail0.baidupcs.com/thumbnail/ae61d4fa64a1af9959423ef25adfd044?fid=676888674-250528-161904655768148&time=1502348400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-BLAcnivjLfejZQfaTMM7hjUCgkk%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5140608572431641589&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)


|  |Positive|Negative|Totle|Accuracy|
|:-:|:-----:|:------:|:---:|:------:|
|Train|37|6629|6666||
|Test|57|9943|10000|0.9989|

### Fisher

    1. Using all of data
![All](http://thumbnail0.baidupcs.com/thumbnail/8d8ce8444ae605283cd97f2e12475ae8?fid=676888674-250528-829920072955848&time=1502348400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-O1dIBpflwHs6iHYriLiCTJGPT24%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5140435538473245919&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)

    2. Using part of the data
![Part](http://thumbnail0.baidupcs.com/thumbnail/cf38d0d2e1b1301d6b8f4d11845b82da?fid=676888674-250528-738259958850869&time=1502348400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-aYzIFV%2B6h4LpoMIDh3bgHXNOcVQ%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5140435538473245919&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)
## ROC curve
  ![ROC](http://thumbnail0.baidupcs.com/thumbnail/8edd40996220e095e1e1825f0bd9cc3b?fid=676888674-250528-890559091439224&time=1502330400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-T4dYhf2kACwxpMPHiiBec5uUdas%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5135414757900587264&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)
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
