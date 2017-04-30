clear all
t=0:0.001:10;
x=sawtooth(t,0.5);
snr=20;
y=awgn(x,snr);
subplot(2,1,1);plot(t,x);title('三角波信号');
subplot(2,1,2);plot(t,y);title('叠加了高斯白噪声后的三角波信号')