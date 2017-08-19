clear ;
clc;
cd D:/MATLABsave/Hyper/圣地亚哥机场数据/local
load Sandiego.mat
load PlaneGT.mat
P=PlaneGT;
%S=Sandiego(1:100,1:100,10:79);  %S是左上角100*100的部分，选取10~79共70个波段进行分析。
[S_h,S_w]=size(P);
get_target_index

%归一化
S_=Sandiego(1:100,1:100,10:79);  %S是左上角100*100的部分，选取10~79共70个波段进行分析。
S_temp=zeros(100,100,70);
for i=1:100
    for j=1:100
        for k=1:70
            S_temp(i,j,k)=S_temp(i,j,k)+S_(i,j,k);
        end;
    end;
end;
S_temp=S_temp/70;
max_=max(max(S_temp));
max_=max_(:);
min_=min(min(S_temp));
min_=min_(:);
S=zeros(100,100,70);
for i=1:100
    for j=1:100
        for k=1:70
          S(i,j,:)=(S_temp(i,j,:)-min_(k))/(max_(k)-min_(k))*255;
        end;
    end;
end;
S=floor(S);

%%%%%%%%%%%%%%%%%%%%%%%%
%选取第一个目标共14个像素点作为目标字典

Dict_t=zeros(70,14);
for i=1:14
    Dict_t(:,i)=S(target_index(i,1),target_index(i,1),:);  
end;

%%%%%%%%%%%%%%%%%%
%DUAL WINDOW设计
%inner window 5*5
%outer window 11*11
%      ————————
%      |      outer             |
%      |           ——         |
%      |         | inner|       |
%      |         |         |       |
%      |           ——         |
%      ————————
%%%%%%%%%%%%%%%%%%%

%边界扩充
% S_expand=zeros(112,112,70);
% for i=1:6
%     S_expand(7:106,i,:)=S(:,1,:);
%     S_expand(7:106,i+106,:)=S(:,100,:);
% end;
%  S_expand(7:106,7:106,:)=S(:,:,:);
% for i=1:6
%     S_expand(i,:,:)=S_expand(7,:,:);
%     S_expand(i+106,:,:)=S_expand(106,:,:);
% end;
S_expand=zeros(110,110,70);
for i=1:5
    S_expand(6:105,i,:)=S(:,1,:);
    S_expand(6:105,i+105,:)=S(:,100,:);
end;
for i=1:5
    S_expand(i,6:105,:)=S(1,:,:);
    S_expand(i,1:5,:)=S_expand(6,1:5,:);
    S_expand(i,106:110,:)=S_expand(6,106:110,:);
    S_expand(i+105,6:105,:)=S(100,:,:);
    S_expand(i+105,1:5,:)=S_expand(105,1:5,:);
    S_expand(i+105,106:110,:)=S_expand(105,106:110,:);
end;
S_expand(6:105,6:105,:)=S(:,:,:);

K=3;   %稀疏度
Inner=9;   %内窗大小，可调节，外窗默认为11
b_num=11*11-Inner*Inner;   %背景字典数
%逐点检测像素点

Dict_b=zeros(70,b_num);   %11*11-5*5
all_num=14+b_num;       %总体字典列数  
Dict=zeros(70,all_num);


Residual=zeros(100,100);
z=zeros(70,1);
Z=zeros(70,all_num);
z=z(:);
for i=6:105
    for j=6:105
       Dict_b=get_dict_b(i,j,S_expand,Inner,5);
       Dict(:,1:b_num)=Dict_b(:,:);
       Dict(:,b_num+1:all_num)=Dict_t(:,:);   %完整的字典
       x1=S_expand(i,j,:);
       x2=S_expand(i-1,j,:);
       x3=S_expand(i,j-1,:);
       x4=S_expand(i+1,j,:);
       x5=S_expand(i,j+1,:);
       x1=x1(:);x2=x2(:);x3=x3(:);x4=x4(:);x5=x5(:);
       if i==10&&j==10
           disp('debug');
       end;
       if i==10&&j==87
           disp('debug');
       end;
        if i==21&&j==69
           disp('debug');
       end;
       %计算r_b=sqrt(sum|1->5 ||(x_i-A_b*beta_i)||2)
        %计算r_t=sqrt(sum|1->5 ||(x_i-A_t*alpha_i)||2)
       gamma=OMP(x1,Dict,K);
       beta1=gamma(1:b_num);
       alpha1=gamma(b_num+1:all_num);
        gamma=OMP(x2,Dict,K);
       beta2=gamma(1:b_num);
       alpha2=gamma(b_num+1:all_num);
        gamma=OMP(x3,Dict,K);
       beta3=gamma(1:b_num);
       alpha3=gamma(b_num+1:all_num);
        gamma=OMP(x4,Dict,K);
       beta4=gamma(1:b_num);
       alpha4=gamma(b_num+1:all_num); 
       gamma=OMP(x5,Dict,K);
       beta5=gamma(1:b_num);
       alpha5=gamma(b_num+1:all_num);
       b1=norm(x1-Dict_b*beta1);
       b2=norm(x2-Dict_b*beta2);
       b3=norm(x3-Dict_b*beta3);
       b4=norm(x4-Dict_b*beta4);
       b5=norm(x5-Dict_b*beta5);
       a1=norm(x1-Dict_t*alpha1);
       a2=norm(x2-Dict_t*alpha2);
       a3=norm(x3-Dict_t*alpha3);
       a4=norm(x4-Dict_t*alpha4);
       a5=norm(x5-Dict_t*alpha5);
       r_b=sqrt(b1^2+b2^2+b3^2+b4^2+b5^2);
       r_t=sqrt(a1^2+a2^2+a3^2+a4^2+a5^2);

       Dx=r_b/r_t;
       Residual(i-5,j-5)=Dx;
    end;
end;
    start_=-2;step=0.1;end_=20;   %取值范围
    num=floor((end_-start_)/step)+1;
    coord=zeros(num,2);
    coord_index=1;
    MIN_DISTENCE=100000000;    %记录最优的阈值
for threshold=start_:step:end_
    P_compare=zeros(P_h,P_w);
    for i=1:S_h
        for j=1:S_w
            if Residual(i,j)>threshold
                 P_compare(i,j)=1;
            end;
        end;
    end;
    sum_TP=0;    %真阳性
    sum_FP=0;    %伪阳性
    sum_FN=0;    %伪阴性
    sum_TN=0;    %真阴性
    for i=1:P_h
     for j=1:P_w
            if P_compare(i,j)==1&&PlaneGT(i,j)==1
             sum_TP=sum_TP+1;
            elseif P_compare(i,j)==0&&PlaneGT(i,j)==1
             sum_FN=sum_FN+1;
            elseif P_compare(i,j)==0&&PlaneGT(i,j)==0
             sum_TN=sum_TN+1;
            elseif P_compare(i,j)==1&&PlaneGT(i,j)==0
             sum_FP=sum_FP+1;
           end;
     end;
    end;
    FPR=sum_FP/(sum_FP+sum_TN);    %伪阳性率
    TPR=sum_TP/(sum_TP+sum_FN);    %真阳性率
    distence=(FPR)^2+(1-TPR)^2;
    if distence<MIN_DISTENCE
        MIN_DISTENCE=distence;
        BEST_THRESHOLD=threshold;
    end;
    coord(coord_index,1)=FPR;
    coord(coord_index,2)=TPR;
    coord_index=coord_index+1;
end;
%ROC曲线
X=coord(:,1);
Y=coord(:,2);
figure;

plot(X,Y,'r'),xlabel('FPR'),ylabel('TPR'),title('ROC curve');%输出ROC曲线

  P_compare=zeros(S_h,S_w);
    for i=1:S_h
        for j=1:S_w
            if Residual(i,j)<BEST_THRESHOLD
                 P_compare(i,j)=1;
            end;
        end;
    end;
    
%%画图
figure

subplot(1,2,1);
imshow(PlaneGT),title('GroundTruth');
subplot(1,2,2);
imshow(P_compare),title('Detect Result');