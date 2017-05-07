clear all
M=4;
EsN0=0:15;
EsN01=10.^(EsN0/10);
SymbolRate=2;

for ii=1:length(EsN0)
    SNR=EsN0(ii);
    sim('fz7_7');
    ber(ii)=BER(1);
    ser(ii)=SER(1)
end

ser1=2*qfunc(sqrt(EsN01)*sin(pi/M));    %理论误符号率
ber1=1/log2(M)*ser1;
semilogy(EsN0,ber,'-ko',EsN0,ser,'-k*',EsN0,ser1,EsN0,ber1,'-k.');
title('4-DPSK载波调制信号在AWGN信道下的性能')
xlabel('Es/N0')
ylabel('误比特率和误符号率')
legend('误比特率','误符号率','理论误符号率','理论误比特率');



