clear all

M=4;
T=1;    %符号持续时间
deltaf=1/T; %FSK的频率间隔
fs=60;  %采样频率
ts=1/fs;
t=0:ts:T;
fc=4;   %载波频率
msg=[0 1 3 2 randint(1,10000-M,M)]; %消息序列
msg_mod=fskmod(msg,M,deltaf,fs,fs);
t1=0:ts:length(msg)-ts; %消息序列的时间矢量
y=real(msg_mod.*exp(j*2*pi*fc*t1));

subplot(2,1,1);
plot(t1(1:4*fs),y(1:4*fs));
axis([0 4 -1.5 1.5]);
title('4FSK调制信号波形');
xlabel('时间');ylabel('振幅');
ly=length(y);   %调制信号长度
freq=[-fs/2:fs/ly:fs/2-fs/ly];
Syy=10*log10(fftshift(abs(fft(y)/fs)));
subplot(2,1,2);
plot(freq,Syy)












