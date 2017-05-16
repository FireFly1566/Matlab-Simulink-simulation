function [ h] = rayleigh( fd,t)
%UNTITLED2 此处显示有关此函数的摘要
%   fd:信道最大多普勒频移
% t:信号抽样时间序列，抽样时间间隔
% h为输出的瑞利信道函数，是一个时间函数复序列

%假设的入射波数目
N=40;
wm=2*pi*fd;

% 每象限的入射波数目即振荡器数目
N0=N/4;

% 信道函数实部
Tc=zeros(1,length(t));

% 信道函数虚部
Ts=zeros(1,length(t));

%归一化功率系数
P_nor=sqrt(1/N0);

%区别各条路径的均匀分布随机相位
theta=2*pi*rand(1,1)-pi;

for ii=1:N0
    % 第i条入射波的入射角
    alfa(ii)=(2*pi*ii-pi+theta)/N;
    
    % 对每个子载波而言在（-pi,pi）之间均匀分布的随机相位
    fi_tc=2*pi*rand(1,1)-pi;
    fi_ts=2*pi*rand(1,1)-pi;
    
    %计算冲击响应函数
    Tc=Tc+cos(cos(alfa(ii)) *wm*t+fi_tc);
    Ts=Ts+cos(cos(alfa(ii))*wm*t+fi_ts);
    
end

% 乘归一化功率系数得到的传输函数
h=P_nor*(Tc+j*Ts);



end

