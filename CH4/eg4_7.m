clear all
snr=-3:3;
SimulationTime=10; %仿真结束时间
for ii=1:length(snr)
    SNR=snr(ii); %赋值给AWGN模块中SNR
    sim('fz4_7'); %运行仿真
    ber(ii)= BER(1); %保存本次仿真得到的BER
    ser(ii)=SER(1);
    
end

figure
semilogy(snr,ber,'-ro',snr,ser,'-b*');
legend('BER','SER')
title('QPSK在AWGN信道下的性能')
xlabel('信噪比（db）');ylabel('误符号率和误比特率')