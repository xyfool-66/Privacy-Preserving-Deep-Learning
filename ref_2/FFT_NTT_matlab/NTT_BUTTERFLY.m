%% 16-point ntt implemmentation using butterfly architecture
clc; clear all; close all;
%% parameters
pow = 3;
N = 2^pow;
NN = 0:N-1;
g = 3;  % 原根
M = 17;  % 模数
A = g.^((M-1)/N*[0:N-1].');
A = mod(A, M);
% x = randi(9,N,1);
x = [7 3 5 9 1 4 6 4]';
x'
x1 = zeros(N,1);
x2 = zeros(N,1);
x3 = zeros(N,1);

%% Layer1
[x1(1), x1(2)] = PE(x(1), x(5), A(1), M);
[x1(3), x1(4)] = PE(x(3), x(7), A(1), M);
[x1(5), x1(6)] = PE(x(2), x(6), A(1), M);
[x1(7), x1(8)] = PE(x(4), x(8), A(1), M);

%% Layer2
[x2(1), x2(3)] = PE(x1(1), x1(3), A(1), M);
[x2(2), x2(4)] = PE(x1(2), x1(4), A(3), M);
[x2(5), x2(7)] = PE(x1(5), x1(7), A(1), M);
[x2(6), x2(8)] = PE(x1(6), x1(8), A(3), M);

%% Layer3
[x3(1), x3(5)] = PE(x2(1), x2(5), A(1), M);
[x3(2), x3(6)] = PE(x2(2), x2(6), A(2), M);
[x3(3), x3(7)] = PE(x2(3), x2(7), A(3), M);
[x3(4), x3(8)] = PE(x2(4), x2(8), A(4), M);
MOD(x3,M);
x3'

pow = 3;
N = 2^pow;
NN = 0:N-1;
a = 3;  % 原根
M = 17;  % 模数
ntt_mat = a.^((M-1)/N*[0:N-1]' * [0:N-1]);
x = [7 3 5 9 1 4 6 4]';
ntt_mat = MOD(ntt_mat, M);
X_ntt_mat = MOD(ntt_mat * x, M)





