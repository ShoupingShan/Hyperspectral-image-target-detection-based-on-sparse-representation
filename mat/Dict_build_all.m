clear all
clc
cd D:\MATLABsave\Hyper\圣地亚哥机场数据
load PlaneGT.mat
load Sandiego.mat
P=PlaneGT;
[P_h,P_w]=size(P);
S=Sandiego(1:P_h,1:P_w,10:79); %裁剪原始图像为100*100,经过观察样本数据10~79波段信息较为良好
[S_h,S_w,S_b]=size(S);
sum=0;
for i=1:P_h
    for j=1:P_w
        S(i,j,:)=S(i,j,:)*0.0001;      %归一化数据,亮度范围0~10000
        if P(i,j)==1
            sum=sum+1;
        end;
    end;
end;
Dict_t=zeros(S_b,sum);  %目标字典
Dict_b=zeros(S_b,P_h*P_w-sum);  %背景字典
index_t=1;
index_b=1;
%%%%%%%%%%%%%%%
%  构造目标和背景字典%
%%%%%%%%%%%%%%%
for i=1:P_h
    for j=1:P_w
        if P(i,j)==1
            Dict_t(:,index_t)=S(i,j,:);
            index_t=index_t+1;
        else
            Dict_b(:,index_b)=S(i,j,:);
            index_b=index_b+1;
        end;
    end;
end;
Dict=zeros(S_b,P_h*P_w);  %全局字典
Dict(:,1:sum)=Dict_t(:,:);
Dict(:,sum+1:P_h*P_w)=Dict_b(:,:);  %级联