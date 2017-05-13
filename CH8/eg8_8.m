clear all
N=100000;   %发送的帧数
L=16;   %一帧中的消息比特个数
poly=[1 1 1 0 1 0 1 0 1];   %CRC生成多项式
N1=length(poly)-1;  %CRC长度
EbN0=0:10;
ber=berawgn(EbN0,'qam',16); %16-QAM理论误比特率

for indx=1:length(ber)
    pe=ber(indx);   %BSC信道错误概率
    for iter=1:N
        msg=randint(1,L);   %消息比特
        msg1=[msg zeros(1,N1)]; %消息比特左移
        [q,r]=deconv(msg1,poly);%用多项式除法求CRC校验码，q为商，r为余数
        r=mod(abs(r),2);
        crc=r(L+1:end);%CRC校验码
        frame=[msg crc];    %发送帧
        x=bsc(frame,pe);    %通过二进制对称信道
        [q1,r1]=deconv(x,poly); %接收序列除以多项式
        r1=mod(abs(r1),2);
        err(iter)=biterr(frame,x);  %统计本帧是否产生误码
        err1(iter)=sum(r1); %通过CRC统计本帧是否产生误码
        
    end
    fer1(indx)=sum(err~=0); %误帧率
    fer2(indx)=sum(r1); %CRC统计本帧是否产生误码
    
end
pmissed=(fer1-fer2)/N;  %CRC检漏的概率
semilogy(EbN0,pmissed)
title('CRC-8检错性能')
xlabel('Eb/N0');ylabel('漏检概率')





