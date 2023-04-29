clc; clear all; close all;
pow = 3;
N = 2^pow;
NN = 0:N-1;
a = 3;  % 原根
M = 17;  % 模数
ntt_mat = a.^((M-1)/N*[0:N-1]' * [0:N-1]);
x = [7 3 5 9 1 4 6 4]';
ntt_mat = mod(ntt_mat, M);
X_ntt_mat = mod(ntt_mat * x, M)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 验证正确版本
pow = 4;
N = 2^pow;
NN = 0:N-1;
a = 2;  
M = 257;  % 模数
ntt_mat = a.^([0:N-1]' * [0:N-1]);
x = [74 -38 45 41 76 92 -32 -18 -7 43 90 39 -57 -23 89 137]';
% 正确的变换输出 X= [37 81 86 -43 -50 -96 -55 104 5 54 -64 15 95 59 -32 -40]
ntt_mat = MOD(ntt_mat, M);
X_ntt_mat = MOD(ntt_mat * x, M);  %% 结果正确
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%