function x = omp_norm(b,A,S)

% Orthogonal Matching Pursuit (OMP)
% 
% Input:
%   A: dictionary (matrix)
%   b: signal 
%   S: sparsity level
% Output:
%   x: coeff vector for sparse representation

[N,K] = size(A); % N:dim of signal, K:#atoms in dictionary
if (N ~= size(b))
    error('Dimension not matched');
end

x = zeros(K,1);      % coefficient (output)
r = b;               % residual of b
omega = zeros(S,1);  % selected support
A_omega = [];        % corresponding columns of A
cnt = 0;
while (cnt < S)  % choose S atoms
    cnt = cnt+1;
    x_tmp = zeros(K,1);
    inds = setdiff([1:K],omega); % iterate all columns except for the chosen ones
    for i = inds
        x_tmp(i) = A(:,i)' * r / norm(A(:,i)); % sol of min ||a'x-b||
    end
    [~,ichosen] = max(abs(x_tmp)); % choose the maximum
    omega(cnt) = ichosen;
    A_omega = [A_omega A(:,ichosen)];
    x_ls = A_omega \ b;  % Aomega * x_ls = b
    r = b - A_omega * x_ls; % update r
end

for i = 1:S
    x(omega(i)) = x_ls(i); %x_sparse(i).value;
end