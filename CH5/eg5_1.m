clear all
ts=0.0025; %信号抽样时间间隔
t=0:ts:10-ts;  %时间矢量
fs=1/ts; %抽样频率
df=fs/length(t);  %fft的频率分辨率
msg=randint(100,1,[-3,3],123) %消息序列，随机数种子123
msg1=msg*ones(1,fs/10); %扩展成取样信号形式
msg2=reshape(msg1.',1,length(t));

%因为原始信号是模拟信号，根据抽样定理，需要再计算出的FFT值后除以fs才能得到原来模拟信号的傅里叶变换
Pm=fft(msg2)/fs; %消息信号的频谱
f=-fs/2:df:fs/2-df;

subplot(2,1,1);plot(f,fftshift(abs(Pm)));  %消息信号频谱
title('消息信号频谱');

A=4;
fc=100; %载波频率
Sam=(A+msg2).*cos(2*pi*fc*t);  %已调信号
Pam=fft(Sam) / fs;  %已调信号频谱

subplot(2,1,2);plot(f,fftshift(abs(Pam)));
title('AM信号频谱');
axis([-200 200 0 23])

Pc=sum(abs(Sam).^2) / length(Sam); %已调信号功率
Ps=Pc-A^2/2;  %消息信号功率
eta=Ps /Pc;







