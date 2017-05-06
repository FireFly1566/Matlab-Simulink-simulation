clear all
nsymbol=100000; %每种信噪比下发送的符号数

T=1;
fs=100; %每个符号的采样点数
ts=1/fs;
t=0:ts:T-ts;
fc=10;
c=sqrt(2/T)*exp(j*2*pi*fc*t);   %载波信号
c1=sqrt(2/T)*cos(2*pi*fc*t);    %同相载波
c2=-sqrt(2/T)*sin(2*pi*fc*t);   %正交载波
M=8;
graycode=[0 1 2 3 6 7  4 5];
EsN0=0:15;
snr1=10.^(EsN0/10); %信噪比转化为线性值
msg=randint(1,nsymbol,M);   %消息数据
msg1=graycode(msg+1);
msgmod=pskmod(msg1,M).';
tx=real(msgmod*c);  %载波调制
tx1=reshape(tx.',1,length(msgmod)*length(c));
spow=norm(tx1).^2/nsymbol;  %求每个符号的平均功率

for indx=1:length(EsN0)
    sigma=sqrt(spow/(2*snr1(indx)));    %根据符号功率求噪声功率
    rx=tx1+sigma*randn(1,length(tx1));  %加入高斯白噪声
    rx1=reshape(rx,length(c),length(msgmod));
    r1=(c1*rx1)/length(c1);
    r2=(c2*rx1)/length(c2);
    r=r1+j*r2;
    y=pskdemod(r,M);    %PSK解调
    decmsg=graycode(y+1);
    [err,ber(indx)]=biterr(msg,decmsg,log2(M));
    [err,ser(indx)]=symerr(msg,decmsg);
end

ser1=2*qfunc(sqrt(2*snr1)*sin(pi/M));   %理论误符号率
ber1=1/log2(M)*ser1;

semilogy(EsN0,ber,'-ko',EsN0,ser,'-k*',EsN0,ser1,EsN0,ber1,'-k.');
title('8-PSK在AWGN信道下的性能');
xlabel('Es/N0');ylabel('误比特率和误符号率');
legend('误比特率','误符号率','理论误符号率','理论误比特率');

















