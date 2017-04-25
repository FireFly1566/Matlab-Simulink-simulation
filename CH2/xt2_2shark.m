function xdot= xt2_2shark( t,x )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

r=1;
d=0.5;
a=0.1;
b=0.02;

xdot = diag([r-a*x(2), -d+b*x(1)]) *x;


end

