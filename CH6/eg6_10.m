clear all
nsymbol=100000; %每种信噪比下发送的符号数

Fd=1; %符号采样频率
Fs=10;  %滤波器采样频率
rolloff=0.25;   %滚降系数
delay=5;    %滤波器时延
M=4;
graycode=[0 1 3 2];
EsN0=0:15;
msg=randint(1,nsymbol,4);   %消息数据
msg1=graycode(msg+1);   %格雷映射
msgmod=pammod(msg1,M); %4PAM映射
rrcfilter=rcosine(Fd,Fs,'fir/sqrt',rolloff,delay);
s=rcosflt(msgmod,Fd,Fs,'filter',rrcfilter); %通过根升余弦滤波器进行脉冲成型
%%
for indx=1:length(EsN0)
    decmsg=zeros(1,nsymbol);
    r=awgn(real(s),EsN0(indx)-7,'measured');
    rx=rcosflt(r,Fd,Fs,'Fs/filter',rrcfilter);  %通过根升余弦进行相关
    rx1=downsample(rx,Fs); %相关器采样
    rx2=rx1(2*delay+1:end-2*delay); %去掉延迟
    msg_demod=pamdemod(rx2,M);
    decmsg=graycode(msg_demod+1);   %格雷逆映射
    [err,ber(indx)]=biterr(msg,decmsg,log2(M));
    [err,ser(indx)]=symerr(msg,decmsg);
end

semilogy(EsN0,ber,'-ko',EsN0,ser,'-k*',EsN0,1.5*qfunc(sqrt(0.4*10.^(EsN0/10))));
title('4-PAM信号在AWGN理想带限信道下的性能');
xlabel('Es/N0');ylabel('误比特率和误符号率');
legend('误比特率','误符号率','理论误符号率');





