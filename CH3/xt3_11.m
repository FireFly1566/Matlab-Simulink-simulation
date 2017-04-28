clear all;
n1=0:20;
n2=0:10000;
x1(n1+1)=1;
x2=x1 .* exp(j*pi*n1/4);
hn=0.7.^n2;

y1=conv(x1,hn);
y2=conv(x2,hn);

[Rx,lags]=xcorr(y1,50,'coeff');
Sf=fftshift(abs(fft(Rx)));
subplot(2,1,1);plot(lags,Rx);title('自相关函数');
subplot(2,1,2);plot(lags,Sf);title('功率谱密度');

figure
[Rx,lags]=xcorr(y2,50,'coeff');
Sf=fftshift(abs(fft(Rx)));
subplot(2,1,1);plot(lags,Rx);title('自相关函数');
subplot(2,1,2);plot(lags,Sf);title('功率谱密度');