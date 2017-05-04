clear all
nsamp=10; %每个脉冲信号的抽样点数

s0=ones(1,nsamp); %基带脉冲信号
s1=[ones(1,nsamp/2) -ones(1,nsamp/2)];

nsymbol=100000; %每种信噪比下的符号数
EbN0=0:12;
msg=randint(1,nsymbol); %消息比特
s00=zeros(nsymbol,1);
s11=zeros(nsymbol,1);
indx=find(msg==0); %比特0在发送消息中的位置
s00(indx)=1;
s00=s00*s0; %比特0映射为发送波形s0
indx1=find(msg==1);
s11(indx1)=1;
s11=s11*s1;
s=s00+s11;  %总发送波形
s=s.';%数据转置，方便接收端处理

for indx=1:length(EbN0)
    decmsg=zeros(1,nsymbol);
    r=awgn(s,EbN0(indx)-7);
    r00=s0*r; %与s0相关
    r11=s1*r;
    indx1=find(r11>=r00);
    decmsg(indx1)=1;
    [err,ber(indx)]=biterr(msg,decmsg);

end

semilogy(EbN0,ber,'-ko',EbN0,qfunc(sqrt(10.^(EbN0/10))));
title('二进制正交信号误比特率性能');
xlabel('EbN0');ylabel('误比特率Pe');
legend('仿真结果','理论结果')





       


