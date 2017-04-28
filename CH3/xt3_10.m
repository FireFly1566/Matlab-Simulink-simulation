clear all
xn=rand(1,10000)-0.5;

[Rx,lags]=xcorr(xn,50,'coeff');
Sf=fftshift(abs(fft(Rx)));

subplot(2,1,1);plot(lags,Rx);title('自相关函数');
subplot(2,1,2);plot(lags,Sf);title('功率谱密度');
axis([-50 50 0 2]);