clear all
nSamp=8; %矩形脉冲的取样点数
numSymb = 20000; %每种SNR下传输的符号数
M=4; %QPSK的符号类型数
SNR=-3:3; 
grayencod=[0 1 3 2];%格雷码编码格式
for ii=1:length(SNR)
    msg=randsrc(1,numSymb,[0:3]); %产生发送符号
    msg_gr=grayencod(msg+1); %进行格雷编码映射
    msg_tx=pskmod(msg_gr,M); %QPSK调制
    msg_tx=rectpulse(msg_tx,nSamp); %矩形脉冲成型
    msg_rx=awgn(msg_tx,SNR(ii),'measured'); %通过AWGN信道
    msg_rx_down=intdump(msg_rx,nSamp);%匹配滤波器相关解调
    msg_gr_demod = pskdemod(msg_rx_down,M); %QPSK解调
    [dummy graydecod]=sort(grayencod); 
    graydecod=graydecod-1;
    msg_demod=graydecod(msg_gr_demod+1); %格雷编码逆映射
    [errorBit BER(ii)]=biterr(msg,msg_demod,log2(M)); %计算BER
    [errorSym SER(ii)]=symerr(msg,msg_demod); %计算SER
    
end

scatterplot(msg_tx(1:100)); %画出发射信号星座图
title('发射信号星座图')
xlabel('同相分量');ylabel('正交分量');

scatterplot(msg_rx(1:100))  %画出接收信号的星座图
title('接收信号星座图')
xlabel('同相分量');ylabel('正交分量');

figure
semilogy(SNR,BER,'-r*',SNR,SER,'-g*')  %画出BER和SNR随SNR变化的曲线
legend('BER','SER');
title('QPSK在AWGN信道下的性能');
xlabel('信噪比（dB）');ylabel('误符号率和误比特率')











