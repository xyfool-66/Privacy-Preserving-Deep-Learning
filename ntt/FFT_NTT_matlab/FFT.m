clc; clear all; close all;

N = 32;
NN = 0:N-1;
fft_mat = exp(-1j*2*pi/N*[0:N-1]' * [0:N-1]);
x = randi(9,N,1);
X_fft_mat = fft_mat * x;
X_fft = fft(x, N);

figure();
stem(NN, abs(X_fft_mat));
figure();
stem(NN, abs(X_fft));

a = zeros(64,1);
for i =1:64
   a(i) = i-1; 
end
a'
b = a+10;
a'*b