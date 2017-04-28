clear all
n=0:100;
xn=cos(0.2*pi*n)+exp(-0.1*n).*sin(0.4*pi*n);
stem(xn);