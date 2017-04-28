clear all
ts=0.01; %载波频率20 Hz,采样时间间隔
fs=1/ts;   % 采样频率100 hz
t=0:ts:10;
df = fs/length(t);   %DFT的频率分辨率
f=-50:df:50-df;    %频率矢量
x=exp(-10*abs(t-5)).*cos(2*pi*20*t);
X=fft(x)/fs;   %求信号频谱

xa=hilbert(x);
Xa=fft(xa)/fs;
subplot(2,1,1);plot(t,x);title('信号x');xlabel('时间t');
subplot(2,1,2);plot(f,fftshift(abs(X)));title('信号 x 幅度谱');xlabel('频率f');

figure
subplot(2,1,1);plot(t,abs(xa));title('信号xa包络');xlabel('时间t');
subplot(2,1,2);plot(f,fftshift(abs(Xa)));title('信号xa幅度谱');xlabel('频率f');