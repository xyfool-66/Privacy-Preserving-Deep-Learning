clc; clear all; close all;
%% parameters
N = 8192;
H = 100; %sqrt(N)
W = 100;
C = 3;
k = 36;
filter_size = [2 3 4 5 6 7 8 9 10];
len = length(filter_size);
coeff = [1,3*log2(N),2,5,1;
         1,3*log2(N),2,5,1;
         1,3*log2(N),2,5,1];
operation = zeros(3, 5);
time = zeros(3, len);

%% 
i = 1;
for h = filter_size
    O=(W-h+1)*(H-h+1);
    T1=floor(O/(C*h*h));
    T2=O-T1*C*h*h;
    operation = [
    0, 0, O, O*ceil(log2(C*h*h)), O*ceil(log2(C*h*h));   
    0, 0, (T1+1)*C*h*h, T1+C*h*h+ceil(log2(T2)), (T1+1)*(C*h*h-1)+ceil(log2(T2))
    2*k, k, 0, 0, 0
    ];
    time(:,i) = sum(operation.*coeff,2);
    i = i+1;
end
% time = log10(time)
operation
time

hold on;
title('Conv');
xlabel('Filter size'); 
ylabel('Time (Log based)');
grid on;
plot(filter_size,time(1,:),'-ks',...
     filter_size,time(2,:),'-bs',...
     filter_size,time(3,:),'-rs',...
     'linewidth',2);
legend('SIMD (Naive)',...
       'SIMD (Diag+Hybrid)',...
       'Encoding');
hold off;
