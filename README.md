
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
![source](http://thumbnail0.baidupcs.com/thumbnail/d26037edf7bff9a61dabcfb54ebfa61b?fid=676888674-250528-178581789731721&time=1503115200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-5lHytGdqfGohW6i9EQngoiitgZs%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5346076110800793261&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)

### GroundTruth (100*100)
![GT](http://thumbnail0.baidupcs.com/thumbnail/84d697b2c0bca97c195f87adea1d39ff?fid=676888674-250528-1069339338576912&time=1503115200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-EgahHn8v0jUNQkhIQepdiJmdY7Q%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5346101656161517232&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
## Rebuilt

  ### Sparse coefficients
  ![SC](http://thumbnail0.baidupcs.com/thumbnail/2404bbfe7663d2b71ce432fd46073218?fid=676888674-250528-910500821419148&time=1503115200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-6kTlurvcKPmS3ZV0RlOYEuq%2B9rQ%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5346132216478573241&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)
  ### Rebuild by dict_b and dict_t
  ![SC](http://thumbnail0.baidupcs.com/thumbnail/1fb9d4361d8a03d1f917af574da947cb?fid=676888674-250528-298416477942221&time=1503115200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-eirfTBqF0I5rZ9xQ2TwRtgrpKYE%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5346132216478573241&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)
## Detection

### Sparse Representation
![SR](http://thumbnail0.baidupcs.com/thumbnail/134418c291b3c0c089fa1f9d248e003c?fid=676888674-250528-558410542282547&time=1503115200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-PbYCu7QLHyscyjCLiSmexRGYj0U%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5346316537936453332&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
### Dual window
![DW](http://thumbnail0.baidupcs.com/thumbnail/ef779f8d0083d1157f9203f40e4eab51?fid=676888674-250528-883972315486660&time=1503115200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-xvyh74ZBslEzyx%2Fh572CjJch3Qk%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5346076110800793261&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)
### Dual window with smooth
![DWS](http://thumbnail0.baidupcs.com/thumbnail/c1cf93a915915a472f71992297ecbbb1?fid=676888674-250528-894802367746190&time=1503115200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Fa2aE%2FUcZvZs1IbmEwR%2FqtV4eKw%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5346076110800793261&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)
### SVM
  ![SVM](http://thumbnail0.baidupcs.com/thumbnail/ae61d4fa64a1af9959423ef25adfd044?fid=676888674-250528-161904655768148&time=1503115200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-HuirWB2chOXUbc%2BN54jUbSo8xp4%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5346241090896561155&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)


|  |Positive|Negative|Total|Accuracy|
|:-:|:-----:|:------:|:---:|:------:|
|Train|37|6629|6666||
|Test|57|9943|10000|0.9989|

### Fisher

    1. Using all of data
    
![All](http://thumbnail0.baidupcs.com/thumbnail/8d8ce8444ae605283cd97f2e12475ae8?fid=676888674-250528-829920072955848&time=1503115200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-ieGBRYYkdLFwTzzC7CpyMJSka8Y%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5346241090896561155&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)

|  |Positive|Negative|Total|Accuracy|
|:-:|:-----:|:------:|:---:|:------:|
|Train|57|9943|10000||
|Test|57|9943|10000|0.9926|


    2. Using part of the data
    
![Part](http://thumbnail0.baidupcs.com/thumbnail/cf38d0d2e1b1301d6b8f4d11845b82da?fid=676888674-250528-738259958850869&time=1503115200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-7HgTyBjvSFCjMKBDkqGLb5ZKc%2BM%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5346241090896561155&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)

|  |Positive|Negative|Total|Accuracy|
|:-:|:-----:|:------:|:---:|:------:|
|Train|37|6629|6666||
|Test|57|9943|10000|0.985|


## ROC curve
  ![ROC](http://thumbnail0.baidupcs.com/thumbnail/41fa51838f822c5fc7515ddb9a818a06?fid=676888674-250528-703685863989540&time=1503115200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-uQoQM8ttqmuwqZLDh2V5wHLbeTA%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5346076110800793261&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)
  ![ROC_all](http://thumbnail0.baidupcs.com/thumbnail/ee7e3ec17d1cee001d2354aaf31bd6d2?fid=676888674-250528-678793626515287&time=1503115200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Y540ul7VxNRp5lyH3ss9pudZWN4%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5346076110800793261&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)
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
