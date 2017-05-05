clear all
nsamp=10; %每个脉冲信号的抽样点数

s0=ones(1,nsamp); %基带脉冲信号
s1=-s0;

nsymbol=100000; %每种信噪比下的发送符号数

EbN0=0:10;
msg=randint(1,nsymbol); %消息数据
s00=zeros(nsymbol,1);
s11=zeros(nsymbol,1);
indx=find(msg==0);
s00(indx)=1;
s00=s00*s0; %比特0映射为发送波形s0

indx1=find(msg==1);
s11(indx1)=1;
s11=s11*s1;
s=s00+s11;
s=s.';

for indx=1:length(EbN0)
    decmsg=zeros(1,nsymbol);
    r=awgn(s,EbN0(indx)-7);
    r00=s0*r;
    indx1=find(r00<0);
    decmsg(indx1)=1; %判决
    [err,ber(indx)]=biterr(msg,decmsg);
end

semilogy(EbN0,ber,'-ko',EbN0,qfunc(sqrt(10.^(EbN0/10))),'-k*',EbN0,qfunc(sqrt(2*10.^(EbN0/10)))  );
title('双极性信号误比特率性能');
xlabel('EbN0');ylabel('误比特率Pe');
legend('仿真结果','正交信号理论误比特率','双极性信号理论误比特率')











