clear all
snr=-15:10;
SimulationTime=10; %仿真结束时间
%%
for ii=1:length(snr)
    SNR=snr(ii);
    sim('fzxt4_3');
    ber(ii)=BER(1);  %保存本次仿真得到的BER
   
end

%%
figure
semilogy(snr,ber,'-ro');
legend('BER');
title('QPSK在AWGN信道下的性能')
xlabel('信噪比（dB）');ylabel('误比特率');
