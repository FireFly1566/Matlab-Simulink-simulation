clear all
ts=0.0025;
t=0:ts:5-ts;
fs=1/ts;
df=fs/length(t);  %fft的频率分辨率
msg=randint(10,1,[-3,3],123);
msg1=msg*ones(1,fs/2);
msg2=reshape(msg1.',1,length(t));
Pm=fft(msg2)/fs;
f=-fs/2:df:fs/2-df;
subplot(3,1,1);plot(t,msg2);
title('消息信号');

fc=300;
s1=0.5*msg2.*cos(2*pi*fc*t); %USSB信号的同相分量
hmsg=imag(hilbert(msg2)); %消息信号的希尔伯特变换
s2=0.5*hmsg.*sin(2*pi*fc*t); %USSB信号的正交分量
Sussb=s1-s2; %完整USSB信号

y=Sussb.*cos(2*pi*fc*t); %相干解调
Y=fft(y)./fs; %解调后的频谱
f_stop=100;
n_stop=floor(f_stop/df);
Hlow=zeros(size(f));
Hlow(1:n_stop)=4;
Hlow(length(f)-n_stop+1:end)=4;
DEM=Y.*Hlow; %解调信号通过LPF
dem=real(ifft(DEM))*fs; %最终得到的解调信号
subplot(3,1,2);plot(t,dem);
title('无噪声的解调信号');

y1=awgn(Sussb,20,'measured');
y2=y1.*cos(2*pi*fc*t); %相干解调
Y2=fft(y2)/fs; 
DEM1=Y2.*Hlow;
dem1=real(ifft(DEM1))*fs;  %最终得到的解调信号
subplot(3,1,3);plot(t,dem1);
title('信噪比为20db时的解调信号')





















