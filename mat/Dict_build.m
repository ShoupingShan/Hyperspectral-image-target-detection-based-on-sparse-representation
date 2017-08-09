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
sum_t_ignore=0;   %记录被忽略的目标像素点
sum_b_ignore=0;
for i=1:P_h
    for j=1:P_w
        S(i,j,:)=S(i,j,:)*0.0001;      %归一化数据
        if P(i,j)==1
            sum=sum+1;
            temp=rand(1);
            if temp<0.667         %抽取目标像素的1/3作为字典
                P(i,j)=2;
                sum_t_ignore=sum_t_ignore+1;
            end;
        else
            temp=rand(1);
            if temp<0.667         %抽取背景像素的1/3作为字典
                P(i,j)=2;               %所有标记为2的像素点都不会被作为字典
                sum_b_ignore=sum_b_ignore+1;
            end;
        end;
    end;
end;
Dict_t=zeros(S_b,sum-sum_t_ignore);  %目标字典
Dict_b=zeros(S_b,P_h*P_w-sum-sum_b_ignore);  %背景字典
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
        elseif P(i,j)==0
            Dict_b(:,index_b)=S(i,j,:);
            index_b=index_b+1;
        end;
    end;
end;
Dict=zeros(S_b,P_h*P_w-sum_b_ignore-sum_t_ignore);  %全局字典
Dict(:,1:sum-sum_t_ignore)=Dict_t(:,:);
Dict(:,sum-sum_t_ignore+1:P_h*P_w-sum_b_ignore-sum_t_ignore)=Dict_b(:,:);  %级联





















