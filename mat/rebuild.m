Dict_build
K=3;
x=S(18,50,:);
x=x(:);
tic
theta1=omp_norm(x,Dict,K);
x_r_1=Dict*theta1;
toc
tic
theta2=omp_norm(x,Dict_t,K);
x_r_2=Dict_t*theta2;
toc
tic
theta3=omp_norm(x,Dict_b,K);
x_r_3=Dict_b*theta3;
toc
%% »æÍ¼
figure(1);
subplot(1,3,1);
plot(x_r_1,'r');%»æ³öxµÄ»Ö¸´ÐÅºÅ
hold on;
plot(x,'k.-');%»æ³öÔ­ÐÅºÅx
hold off;
legend('Recovery','Original')
fprintf('\nDict»Ö¸´²Ð²î£º');
norm(x_r_1-x)%»Ö¸´²Ð²î

subplot(1,3,2);
plot(x_r_2,'r');%»æ³öxµÄ»Ö¸´ÐÅºÅ
hold on;
plot(x,'k.-');%»æ³öÔ­ÐÅºÅx
hold off;
legend('Recovery','Original')
fprintf('\nDict_t»Ö¸´²Ð²î£º');
norm(x_r_2-x)%»Ö¸´²Ð²î

subplot(1,3,3);
plot(x_r_3,'r');%»æ³öxµÄ»Ö¸´ÐÅºÅ
hold on;
plot(x,'k.-');%»æ³öÔ­ÐÅºÅx
hold off;
legend('Recovery','Original')
fprintf('\nDict_b»Ö¸´²Ð²î£º');
norm(x_r_3-x)%»Ö¸´²Ð²î