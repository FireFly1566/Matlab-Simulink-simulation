clear all
EsN0=0:15;

for ii=1:length(EsN0)
    SNR=EsN0(ii);
    sim('fz6_8');
    ber(ii)=BER(1);
    ser(ii)=SER(1);
end

semilogy(EsN0,ber,'-ko',EsN0,ser,'-k*',EsN0,1.5*qfunc(sqrt(0.4*10.^(EsN0/10))));
title('4PAM信号在AWGN信道下的性能');
xlabel('Es/N0');ylabel('误比特率和误符号率');
legend('误比特率','误符号率','理论误符号率')