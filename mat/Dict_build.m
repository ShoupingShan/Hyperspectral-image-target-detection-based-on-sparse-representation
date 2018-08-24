%------------------------------------------------------------------------------------------
%% Supervised dictionary construction based on part of hyperspectral target data
%------------------------------------------------------------------------------------------
clear all
clc
load PlaneGT.mat
load Sandiego.mat
P=PlaneGT;
[P_h,P_w]=size(P);
S_=Sandiego(1:P_h,1:P_w,10:79); %The original image is cropped to 100*100, and the information of the sample data is better than that of the sample data.
[S_h,S_w,S_b]=size(S_);

%Normalized data
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

sum=0;
sum_t_ignore=0;   %Record ignored target pixels
sum_b_ignore=0;
for i=1:P_h
    for j=1:P_w
        if P(i,j)==1
            sum=sum+1;
            temp=rand(1);
            if temp<0.667         %Extract 1/3 of the target pixel as a dictionary
                P(i,j)=2;
                sum_t_ignore=sum_t_ignore+1;
            end;
        else
            temp=rand(1);
            if temp<0.667         %Extract 1/3 of the background pixels as a dictionary
                P(i,j)=2;               %All pixels marked as 2 will not be used as a dictionary
                sum_b_ignore=sum_b_ignore+1;
            end;
        end;
    end;
end;
Dict_t=zeros(S_b,sum-sum_t_ignore);  %Target dictionary
Dict_b=zeros(S_b,P_h*P_w-sum-sum_b_ignore);  %Background dictionary
index_t=1;
index_b=1;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Construct target and background dictionary %
%%%%%%%%%%%%%%%%%%%%%%%%%%
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
Dict=zeros(S_b,P_h*P_w-sum_b_ignore-sum_t_ignore);  %Global dictionary
Dict(:,1:sum-sum_t_ignore)=Dict_t(:,:);
Dict(:,sum-sum_t_ignore+1:P_h*P_w-sum_b_ignore-sum_t_ignore)=Dict_b(:,:);  %cascade





















