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
        end;
    end;
end;
for i=1:P_h
    for j=1:P_w
        if P(i,j)==1
            sum_t_ignore=sum_t_ignore+1;
           if sum_t_ignore>floor(sum*1/3)
               P(i,j)=2;
           end;
       elseif P(i,j)==0
             sum_b_ignore=sum_b_ignore+1;
           if sum_b_ignore>floor((P_h*P_w-sum)*1/3)
              P(i,j)=2;
           end;
        
        end;
      
    end;
end;
Dict_t=zeros(S_b,floor(sum*1/3));  %目标字典
Dict_b=zeros(S_b,floor((P_h*P_w-sum)*1/3));  %背景字典
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
Dict=zeros(S_b,floor((P_h*P_w-sum)*1/3)+floor(sum*1/3));  %全局字典
Dict(:,1:floor(sum*1/3))=Dict_t(:,:);
Dict(:,floor(sum*1/3)+1:end)=Dict_b(:,:);  %级联
disp('自定义字典构造完成')





















