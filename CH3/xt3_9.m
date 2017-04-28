clear all   %程序有问题！！！！！！！！！！！！！
ts=0.001;
fs=1/ts;
t=0 : ts :0.5;
df = fs/length(t); %DFT频谱分辨率
f = -1000:df: 1000-df;

x=6*( cos(20*pi*t)-3*sin(30*pi*t) ) .*cos(400*pi*t+3/8*pi*t);

X=fft(x)/fs;

subplot(2,1,1);plot(t,x);title('信号x');xlabel('时间t');
%subplot(2,1,2);plot(f,fftshift(abs(X)));title('信号x幅度谱');xlabel('频率f');

xa=hilbert(x);
Xa=fft(xa)/fs;

figure
subplot(2,1,1);plot(t,abs(xa));title('信号xa包络');xlabel('时间t');
subplot(2,1,2);plot(f,fftshift(abs(Xa)));title('信号Xa幅度');xlabel('频率f');

