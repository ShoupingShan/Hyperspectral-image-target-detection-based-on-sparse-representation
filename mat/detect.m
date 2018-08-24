    Dict_build
    K=3;
    Collect=zeros(P_h*P_w,1);
    index=1;
    for i=1:S_h
       for j=1:S_w
            x=S(i,j,:);
           x=x(:);
          theta_b=OMP(x,Dict_b,K);
          gamma=OMP(x,Dict_t,K);
          n0=x'*(x-Dict_b*theta_b);
          n1=x'*(x-Dict_t*gamma);
          D=n0*(1/n1);
          Collect(index)=D;   %classfication result response
          index=index+1; 
      end;
    end;
    start_=0.2;step=0.2;end_=10;   % cycle Ranges
    num=(end_-start_)/step+1;
    coord=zeros(num,2);
    coord_index=1;
    MIN_DISTENCE=1000000;    %Record the optimal threshold
for threshold=start_:step:end_
    P_compare=zeros(P_h,P_w);
    for i=1:S_h
        for j=1:S_w
            if Collect(P_h*(i-1)+j)>threshold
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
    TPR=sum_TP/(sum_TP+sum_FN);    %True positive rate
    distence=(FPR)^2+(1-TPR)^2;
    if distence<MIN_DISTENCE
        MIN_DISTENCE=distence;
        BEST_THRESHOLD=threshold;
    end;
    coord(coord_index,1)=FPR;
    coord(coord_index,2)=TPR;
    coord_index=coord_index+1;
end;
%ROC curve
X=coord(:,1);
Y=coord(:,2);
figure;
plot(X,Y),xlabel('FPR'),ylabel('TPR');%Plot ROC curve

  P_compare=zeros(S_h,S_w);
    for i=1:S_h
        for j=1:S_w
            if Collect(P_h*(i-1)+j)>BEST_THRESHOLD
                 P_compare(i,j)=1;
            end;
        end;
    end;
    
%% Plot
figure
subplot(1,2,1);
imshow(PlaneGT),title('Standard image');
subplot(1,2,2);
imshow(P_compare),title('Test results');





