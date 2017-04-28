clear all
syms w t;
Fw=-1/tan(w-1) +tan(w+1);
f=ifourier(Fw,t);
