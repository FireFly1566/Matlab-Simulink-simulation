clear all
ts=0.0025;
t=0:ts:10-ts;
fs=1/ts;
df=fs/length(t);
msg=randint(100,1,[-3,3],123);
msg1=msg*ones(1,fs/10); %扩展成取样信号形式
msg2=reshape(msg1.',1,length(t));
Pm=fft(msg2)/fs;
f=-fs/2:df:fs/2-df;

subplot(2,1,1);plot(f,fftshift(abs(Pm))); 
title('消息信号频谱');

fc=100;
s1=0.5*msg2.*cos(2*pi*fc*t); %USSB信号同相分量
hmsg=imag(hilbert(msg2)); %消息信号的希尔伯特变换
s2=0.5*hmsg.*sin(2*pi*fc*t); %USSB信号的正交分量
Sussb=s1-s2; %完整的USSB信号
Pussb=fft(Sussb)/fs;
subplot(2,1,2);plot(f,fftshift(abs(Pussb)));
title('USSB信号频谱');
axis([-200 200 0 2]);

Pc=sum(abs(Sussb).^2) / length(Sussb); %已调信号功率
Ps=sum(abs(msg2).^2)/length(msg2); %消息信号功率






