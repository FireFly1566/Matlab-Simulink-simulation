clear all
ts=0.0025; %抽样时间间隔
t=0:ts:10-ts;
fs=1/ts;
df=fs/length(t); %fft频谱分辨率
msg=randint(100,1,[-3,3],123);
msg1=msg*ones(1,fs/10);
msg2=reshape(msg1.',1,length(t));
Pm=fft(msg2)/fs;  %消息信号频谱
f=-fs/2:df:fs/2-df;
%%
subplot(2,1,1);plot(f,fftshift(abs(Pm)));
title('消息信号频谱');
%%
fc=100;
Sdsb=msg2.*cos(2*pi*fc*t); %DSB信号
Pdsb=fft(Sdsb)/fs;

%%
f_stop=100; %LPF截止频率
n_stop=floor(f_stop/df);
Hlow=zeros(size(f));  %设计LPF
Hlow(1:n_stop)=1;
Hlow(length(f)-n_stop+1:end)=1;
Plssb=Pdsb.*Hlow; %LSSB信号频谱
%%
subplot(2,1,2);plot(f,fftshift(abs(Plssb)));
title('已调信号频谱');
axis([-200 200 0 2]);

%%
Slssb=real(ifft(Plssb))*fs;
Pc=sum(abs(Slssb).^2) / length(Slssb); %已调信号功率
Ps=sum(abs(msg2).^2)/length(msg2);







