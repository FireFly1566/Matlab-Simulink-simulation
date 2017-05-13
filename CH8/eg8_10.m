clear all
EbN0=0:10;
N=1000000;  %消息比特个数
M=2;    %BPSK
L=7;    %约束长度
trel=poly2trellis(L,[171 133]);
tblen=6*L;  %维特比译码回溯深度
msg=randint(1,N);%消息比特序列
msg1=convenc(msg,trel); %卷积编码
x1=pskmod(msg1,M);  

for ii=1:length(EbN0)
    %加入高斯白噪声，因为码率是1/2，所以每个符号的能量要比比特能量少3db
    y=awgn(x1,EbN0(ii)-3);
    y1=pskdemod(y,M);   %硬判决
    y1=vitdec(y1,trel,tblen,'cont','hard');
    [err,ber1(ii)]=biterr(y1(tblen+1:end),msg(1:end-tblen));    %误比特率
    
    y2=vitdec(real(y),trel,tblen,'cont','unquant');%软判决
    [err,ber2(ii)]=biterr(y2(tblen+1:end),msg(1:end-tblen));
end

ber=berawgn(EbN0,'psk',2,'nodiff'); %BPSK理论误比特率
semilogy(EbN0,ber,'-ko',EbN0,ber1,'-k*',EbN0,ber2,'-k.');
legend('BPSK理论误比特率','硬判决误比特率','软判决误比特率')
title('卷积码性能')
xlabel('Eb/N0');ylabel('误比特率')







