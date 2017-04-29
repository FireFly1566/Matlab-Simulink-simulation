function [h]=rayleigh(fd,t)
%利用改进的jakes模型来产生单径的平坦型瑞利衰落信道
% fd:信道的最大多普勒频移，Hz
% t:信号的抽样时间序列
% h:输出的瑞利信道函数，是一个时间函数复序列

N=40; %入射波数目
wm=2*pi*fd;

N0=N/4; %每象限的入射波数目即振荡器数目

Tc=zeros(1,length(t)); %信道函数的实部
Ts =zeros(1,length(t)); %信道函数的虚部

P_nor=sqrt(1/N0); %归一化功率系数

theta=2*pi*rand(1,1)-pi; %区别每条路径的均匀分布随机相位

for ii=1:N0
    alfa(ii)=(2*pi*ii-pi+theta)/N; %第i条入射波的入射角
    fi_tc=2*pi*rand(1,1)-pi; %对每个子载波而言在（-pi,pi）之间均匀分布的随机相位
    fi_ts=2*pi*rand(1,1)-pi;
    
    Tc=Tc+cos(cos(alfa(ii))*wm*t+fi_tc);
    Ts=Ts+cos(sin(alfa(ii))*wm*t+fi_ts);
    
    
end

h=P_nor*(Tc+j*Ts); %归一化功率系数得到传输函数




