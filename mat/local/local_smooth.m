clear ;
clc;
load Sandiego.mat
load PlaneGT.mat
P=PlaneGT;
[S_h,S_w]=size(P);
get_target_index %Get coordinate point coordinates

%Normalized
S_=Sandiego(1:100,1:100,10:79);  %S is the part of the upper left corner of 100*100, and a total of 70 bands of 10 to 79 are selected for analysis.
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


%Select the first target to have a total of 14 pixels as the target  dictionary
Dict_t=zeros(70,14);
for i=1:14
    Dict_t(:,i)=S(target_index(i,1),target_index(i,1),:);  
end;

%%%%%%%%%%%%%%%%%%
%DUAL WINDOW design
%inner window 5*5
%outer window 11*11
%      ！！！！！！！！
%      |      outer             |
%      |           ！！         |
%      |         | inner|       |
%      |         |         |       |
%      |           ！！         |
%      ！！！！！！！！
%%%%%%%%%%%%%%%%%%%

%Boundary expansion
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


%% Point-by-point detection of pixels
K=5;
Dict_b=zeros(70,96);   %11*11-5*5
Dict=zeros(70,110);


Residual=zeros(100,100);
z=zeros(70,1);
Z=zeros(70,110);
z=z(:);
for i=6:105
    for j=6:105
       Dict_b=get_dict_b(i,j,S_expand);
       Dict(:,1:96)=Dict_b(:,:);
       Dict(:,97:110)=Dict_t(:,:);   %Complete dictionary A
       A=[4*Dict,-Dict,-Dict,-Dict,-Dict; Dict,Z,Z,Z,Z; Z,Dict,Z,Z,Z; Z,Z,Dict,Z,Z; Z,Z,Z,Dict,Z; Z,Z,Z,Z,Dict];
       x1=S_expand(i,j,:);
       x2=S_expand(i-1,j,:);
       x3=S_expand(i,j-1,:);
       x4=S_expand(i+1,j,:);
       x5=S_expand(i,j+1,:);
       x1=x1(:);x2=x2(:);x3=x3(:);x4=x4(:);x5=x5(:);
       X=[z;x1;x2;x3;x4;x5];
       GAMMA=OMP(X,A,K);
       beta1=GAMMA(1:96);
       alpha1=GAMMA(97:110);
       beta2=GAMMA(111:206);
       alpha2=GAMMA(207:220);
       beta3=GAMMA(221:316);
       alpha3=GAMMA(317:330);
       beta4=GAMMA(331:426);
       alpha4=GAMMA(427:440);
       beta5=GAMMA(441:536);
       alpha5=GAMMA(537:550);
       
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
%        y=S_expand(i,j,:);
%        y=y(:);
%        gamma=OMP(y,Dict,K);
%        gamma_b=gamma(1:96);
%        gamma_t=gamma(97:110);
%        y_b=Dict_b*gamma_b;
%        r_b=norm(y_b-y);  %Recovery residual
%      % r_b=y'*y_b;
%        y_t=Dict_t*gamma_t;
%        r_t=norm(y_t-y);  %Recovery residual
      %r_t=y'*y;
       Dx=r_b-r_t;
       Residual(i-5,j-5)=Dx;
    end;
end;
    start_=800;step=1;end_=2000;   %Ranges
    num=floor((end_-start_)/step)+1;
    coord=zeros(num,2);
    coord_index=1;
    MIN_DISTENCE=100000000;    %Record the optimal threshold
for threshold=start_:step:end_
    P_compare=zeros(P_h,P_w);
    for i=1:S_h
        for j=1:S_w
            if Residual(i,j)>threshold
                 P_compare(i,j)=1;
            end;
        end;
    end;
     sum_TP=0;    %True positive
    sum_FP=0;    %False positive
    sum_FN=0;    %False negative
    sum_TN=0;    %True negative
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
    FPR=sum_FP/(sum_FP+sum_TN);    %False positive rate
    TPR=sum_TP/(sum_TP+sum_FN);     %True positive rate
    distence=(FPR)^2+(1-TPR)^2;
    if distence<MIN_DISTENCE
        MIN_DISTENCE=distence;
        BEST_THRESHOLD=threshold;
    end;
    coord(coord_index,1)=FPR;
    coord(coord_index,2)=TPR;
    coord_index=coord_index+1;
end;
%% ROCcurve
X=coord(:,1);
Y=coord(:,2);
figure;

plot(X,Y,'r'),xlabel('FPR'),ylabel('TPR'),title('ROC curve');

  P_compare=zeros(S_h,S_w);
    for i=1:S_h
        for j=1:S_w
            if Residual(i,j)<BEST_THRESHOLD
                 P_compare(i,j)=1;
            end;
        end;
    end;
    
%% Plot
figure

subplot(1,2,1);
imshow(PlaneGT),title('GroundTruth');
subplot(1,2,2);
imshow(P_compare),title('Detect Result');

