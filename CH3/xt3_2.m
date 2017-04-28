clear all;
n1 = 0:50;
n2=0:20;
xn=cos(1/8*pi*n1-3/4*pi);
hn=0.5 .^n2;
yn=conv(xn,hn);
stem(yn);