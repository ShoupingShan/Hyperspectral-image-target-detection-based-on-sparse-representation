%---------------------------------------------------------------------------------
% Supervised dictionary construction based on all of the hyperspectral target data
%---------------------------------------------------------------------------------
%%
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
for i=1:P_h
    for j=1:P_w
        if P(i,j)==1
            sum=sum+1;
        end;
    end;
end;
Dict_t=zeros(S_b,sum);  %Target dictionary
Dict_b=zeros(S_b,P_h*P_w-sum);  %Background dictionary
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
        else
            Dict_b(:,index_b)=S(i,j,:);
            index_b=index_b+1;
        end;
    end;
end;
Dict=zeros(S_b,P_h*P_w);  %Global dictionary
Dict(:,1:sum)=Dict_t(:,:);
Dict(:,sum+1:P_h*P_w)=Dict_b(:,:);  %cascade