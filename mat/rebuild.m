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
%% Plot rebuild
figure(1);
subplot(1,3,1);
plot(x_r_1,'r');%Draw the recovery signal of x
hold on;
plot(x,'k.-');% x before
hold off;
legend('Recovery','Original')
fprintf('\nDict Recovery residual£º');
norm(x_r_1-x)%Recovery residual

subplot(1,3,2);
plot(x_r_2,'r');%Draw the recovery signal of x
hold on;
plot(x,'k.-');%Draw the original signal x
hold off;
legend('Recovery','Original')
fprintf('\nDict_t Recovery residual£º');
norm(x_r_2-x)%Recovery residual

subplot(1,3,3);
plot(x_r_3,'r');%Draw the recovery signal of x
hold on;
plot(x,'k.-');%Draw the original signal x
hold off;
legend('Recovery','Original')
fprintf('\nDict_b Recovery residual£º');
norm(x_r_3-x)%Recovery residual