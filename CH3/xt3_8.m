clear all
n1=0:20;
n2=0:10;
xn=2*n1-5;
hn=0.3*n2+exp(-0.1*n2);

yn=conv(xn,hn);
subplot(2,1,1);stem(yn);title('直接计算');

x=[xn zeros(1,length(hn)-1)];
h=[hn zeros(1,length(xn)-1)];

X1=fft(x);
H1=fft(h);
Y1=H1.*X1;
y1=ifft(Y1);

subplot(2,1,2);stem(y1);title('DFT计算')