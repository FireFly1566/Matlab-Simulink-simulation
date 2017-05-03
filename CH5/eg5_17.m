clear all
ts=0.001; %抽样时间间隔
t=0:ts:5-ts;
fs=1/ts;
df=fs/length(t); %fft频谱分辨率
msg=randint(10,1,[-3,3],123);
msg1=msg*ones(1,fs/2); %扩展成取样信号形式
msg2=reshape(msg1.',1,length(t));
%%
subplot(3,1,1);plot(t,msg2);title('消息信号');
%%
int_msg(1)=0;
for ii=1:length(t)-1
    int_msg(ii+1)=int_msg(ii)+msg2(ii)*ts;
end

kf=50;
fc=300;
Sfm=cos(2*pi*fc*t+2*pi*kf*int_msg); %调频信号

phase=angle(hilbert(Sfm).*exp(-j*2*pi*fc*t)); %FM调制信号相位
phi=unwrap(phase);
dem=(1/(2*pi*kf)*diff(phi)/ts); %求相位积分，得到消息信号
dem(length(t))=0;
%%
subplot(3,1,2);plot(t,dem);
title('无噪声的解调信号');
%%
y1=awgn(Sfm,20,'measured');
y1(find(y1>1))=1; %调制信号限幅
y1(find(y1<-1))=-1;
phase1=angle(hilbert(y1).*exp(-j*2*pi*fc*t)); %信号解调
phi1=unwrap(phase1);
dem1=(1/(2*pi*kf)*diff(phi1)/ts);
dem1(length(t))=0;
subplot(3,1,3);plot(t,dem1);
title('信噪比为20db时的解调信号')














