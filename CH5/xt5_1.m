clear all
ts=0.0025;
t=0:ts:10-ts;
fs=1/ts;
df=fs/length(t);
msg2=(cos(2*pi*t)+exp(-t).*sin(4*pi*t));
Pm=fft(msg2)/fs;
f=-fs/2:df:fs/2-df;
%%
subplot(2,1,1);
plot(f,fftshift(abs(Pm)));
title('消息信号频谱');
%%
A=1;
fc=300;
Sam=(A+msg2).*sin(2*pi*fc*t);
Pam=fft(Sam)/fs;
subplot(2,1,2);
plot(f,fftshift(abs(Pam)));
title('AM信号频谱');
axis([-500 500 0 10]);

Pc=sum(abs(Sam).^2)/length(Sam);
Ps=Pc-A^2/2;
eta=Ps/Pc;






