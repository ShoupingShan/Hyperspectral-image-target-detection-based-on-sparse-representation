## Introduction

    Hyperspectral image target detection based on [sparse representation](https://en.wikipedia.org/wiki/Sparse_approximation),an effective method in Pattern Recognition.  

    The proposed approach relies on the binary hypothesis model of an unknown sample induced by sparse representation.

    The sample can be sparsely represented by training samples from the background and target dictionary. The sparse vector

    in the model can be recovered by a greedy algorithm [OMP](https://en.wikipedia.org/wiki/Matching_pursuit)

## Author
  * [@ShoupingShan](https://github.com/ShoupingShan)

## Theory

## Data
### San Diego hyperspectral dataset (400*400)
![原图](http://thumbnail0.baidupcs.com/thumbnail/f4c39e9279e0072c408ac06258144ccd?fid=676888674-250528-990921214246117&time=1502294400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-K1Qgg76PoyqKY7MZVkB4X9IPP94%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5125653704072191132&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
### GroundTruth (100*100)
![GT](http://thumbnail0.baidupcs.com/thumbnail/84d697b2c0bca97c195f87adea1d39ff?fid=676888674-250528-1069339338576912&time=1502294400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-pqqwNpefzLfLIYsu1Sn5POLXoys%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5125773466591858797&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)

## Detection
### Sparse Representation
![SR](http://thumbnail0.baidupcs.com/thumbnail/134418c291b3c0c089fa1f9d248e003c?fid=676888674-250528-301138876109000&time=1502294400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-HgvIEwZ%2F1PXMoubg6%2FzB1a7MsfE%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5125856103108996112&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)
### SVM
![SVM](http://thumbnail0.baidupcs.com/thumbnail/d85978e7c38f66973de75df5db0c2891?fid=676888674-250528-319202653783208&time=1502294400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-muv%2Bt%2BQBQ1D5IO%2BPJvbMHNNK%2FoE%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5125856103108996112&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)
## Platform
  * [Win10](https://www.microsoft.com/zh-cn)
  * [OpenCV 2.4.10](http://opencv.org/)
  * [VS2013](http://www.iplaysoft.com/vs2013.html)
  * [Matlab r2016b](https://www.mathworks.com/)

## Contact Us
  *shp395210@outlook.com*
