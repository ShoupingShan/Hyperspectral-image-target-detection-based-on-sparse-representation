cd D:\MATLABsave\Hyper\圣地亚哥机场数据
load PlaneGT.mat
P=PlaneGT;
[P_h,P_w]=size(P);
target_index=zeros(57,2);
index=1;
for i=1:P_h
    for j=1:P_w
        if P(i,j)==1
            target_index(index,1)=i;
            target_index(index,2)=j;
            index=index+1;
        end;
    end;
end;