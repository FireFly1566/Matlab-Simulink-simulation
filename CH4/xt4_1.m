clear all
T=1:0.001:10;
k=1+0.2*randn(1,length(T));
plot(T,k);
var(k);
