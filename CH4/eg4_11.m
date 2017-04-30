clear all
snr=-3:3;
SimulationTime=0; %仿真结束时间
eg4_7; %运行eg4_7
ser1=ser;ber1=ber; %保存示例4.7结果
%%
for ii=1:length(snr)
    SNR=snr(ii);
    sim('fz4_11');
    ber(ii)=BER(1); %保存本次仿真得到的BER
    ser(ii)=SER(1); %保存本次仿真得到的SER
  
end
%%
semilogy(snr,ber,'-rs',snr,ser,'-r^',snr,ber1,'-bo',snr,ser1,'-b*')
legend('Rayleigh衰落+AWGN信道BER','Rayleigh衰落+AWGN信道SER','AWGN信道BER','AWGN信道SER');
title('QPSK在AWGN和多径Rayleigh衰落下的性能')
xlabel('信噪比（dB）')
ylabel('误符号率和误比特率')



