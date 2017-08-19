clear all;
load Dict_build_all_X.mat
load Dict_build_all_Y.mat
Dict_build_all_X=X;
Dict_build_all_Y=Y;
load Dict_build_ROC_X.mat
load Dict_build_ROC_Y.mat
Dict_build_ROC_X=X;
Dict_build_ROC_Y=Y;
load Local_Smooth_X_2.mat
load Local_Smooth_Y_2.mat
local_smooth_X=X;
local_smooth_Y=Y;
load Local__X_2.mat
load Local__Y_2.mat
local_X=X;
local_Y=Y;
figure;
plot(local_X,local_Y,'k'),xlabel('False alarm rate','FontSize',14),ylabel('Probability of detection','FontSize',14);
hold on;
plot(local_smooth_X,local_smooth_Y,'g');
hold on;
legend('Dual window without smooth','Dual window with smooth');