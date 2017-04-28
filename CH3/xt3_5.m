clear all
syms t;
xt=exp(-t*t);
Xf=fourier(xt);
%ezplot(abs(Xf));
ezplot(Xf);