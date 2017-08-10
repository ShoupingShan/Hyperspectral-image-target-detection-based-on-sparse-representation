<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script>
## Introduction

Hyperspectral image target detection based on [sparse representation](https://en.wikipedia.org/wiki/Sparse_approximation),an effective method in Pattern Recognition.  

The proposed approach relies on the binary hypothesis model of an unknown sample induced by sparse representation.

The sample can be sparsely represented by training samples from the background and target dictionary. The sparse vector

in the model can be recovered by a greedy algorithm [OMP](https://en.wikipedia.org/wiki/Matching_pursuit) .

## Author
  * [@ShoupingShan](https://github.com/ShoupingShan)

## Theory

The problem of target detection can be regarded as a competitive relationship of two hypotheses $H_0$(Background) and $H_1$(Target).

$$\begin{aligned}H_0 & =B\alpha_b+n       \\\\H_1&=T\alpha_t+B\alpha_b+n\end{aligned} $$


  T and B are both matrices, their column vectors are divided into target and background subspace. $\alpha_t$ and $\alpha_b$form the coefficient vectors of the coefficients, respectively. N denotes Gaussian random noise, [T,B]represents a cascade matrix of T and B.


  $$\begin{aligned}n_0 & =x-B\alpha_b=(I-P_B)x      \\n_1&=x-T\alpha_t+B\alpha_b=(I-P_{TB})x\end{aligned} $$
  Suppose $D_MSD (x)=\frac{x^T (1-P_B)x}{x^T (1-P_{TB})x}$,When D is greater than a certain threshold η, then X is the target.

  That means we need to find a projection matrix p.

  By the sparse representation of knowledge, it is known that the residual error of signal reconstruction can be expressed as:


  $$\begin{aligned}n_0' & =x-A_b\alpha\\n_1'&=x-A\gamma\end{aligned} $$


$$\begin{aligned}n_0 & =(I-P_B)x\to x-A_b\alpha'     \\n_1&=(1-P_{TB} )x\to x-A\gamma\end{aligned} $$

Suppose $D_MSD (x)=\frac{x^T(x-A_b α')}{x^T(x-Aγ)x}$,When D is greater than a certain threshold η, then X is the target.
Then it is based on the ROC curve to compare different threshold effects, resulting in the final result.
However, it is better to amend Denominator as $x^T (x-A_t γ)x$ in practice.


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
  ![SVM](http://thumbnail0.baidupcs.com/thumbnail/84d697b2c0bca97c195f87adea1d39ff?fid=676888674-250528-1069339338576912&time=1502330400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-r6X%2FNgfYAhB3cSq5YsYOUCUm8cQ%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5135319725655736071&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)

## ROC curve
  ![ROC](http://thumbnail0.baidupcs.com/thumbnail/8edd40996220e095e1e1825f0bd9cc3b?fid=676888674-250528-890559091439224&time=1502330400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-T4dYhf2kACwxpMPHiiBec5uUdas%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=5135414757900587264&dp-callid=0&size=c10000_u10000&quality=90&vuk=-&ft=video)
## Platform
  * [Win10](https://www.microsoft.com/zh-cn)
  * [VS2013](http://www.iplaysoft.com/vs2013.html)
  * [OpenCV 2.4.9](http://opencv.org/)
  * [Matlab r2016b](https://www.mathworks.com/)

## Contact Us
  *shp395210@outlook.com*
