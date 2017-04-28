clear all
n=0:10;
xn=0.3.^n;
hn=[1 0.45];
yn=conv(xn,hn);
stem(yn);