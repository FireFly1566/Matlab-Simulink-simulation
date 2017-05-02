clear all
ts=0.001;%信号抽样时间间隔
t=0:ts:10-ts;
fs=1/ts;
df=fs/length(t); %fft频率分辨率
msg=randint(100,1,[-3,3],123);
msg1=msg*ones(1,fs/10); %扩展成取样信号形式
msg2=reshape(msg1.',1,length(t));
Pm=fft(msg2)/fs;
f=-fs/2:df:fs/2-df;

subplot(2,1,1);plot(f,fftshift(abs(Pm)));
title('消息信号频谱');

int_msg(1)=0; %消息信号积分
for ii=1:length(t)-1
    int_msg(ii+1)=int_msg(ii)+msg2(ii)*ts;
end

kf=50;

fc=250;
Sfm=cos(2*pi*fc*t+2*pi*kf*int_msg);
Pfm=fft(Sfm)/fs; %FM信号频谱

subplot(2,1,2);plot(f,fftshift(abs(Pfm)));
title('FM信号频谱')

Pc=sum(abs(Sfm).^2)/length(Sfm); %已调信号
Ps=sum(abs(msg2).^2)/length(msg2); %消息信号功率

fm=50;
betaf=kf*max(msg)/fm;  %调制指数
W=2*(betaf+1)*fm;











