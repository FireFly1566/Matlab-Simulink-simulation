clear all
syms t;  %说明t是符号变量
f = t*exp(-abs(t));
subplot(1,2,1);ezplot(f);
F = fourier(f);
subplot(1,2,2);ezplot(abs(F));  %幅频响应曲线