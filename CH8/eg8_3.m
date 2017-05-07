clear all
EbN0=0:10;
SymbolRate=50000;   %符号速率

for ii=1:length(EbN0)
    SNR=EbN0(ii);
    sim('fz8_3');
    ber1(ii)=BER1(1);
    ber2(ii)=BER2(1);
end

semilogy(EbN0,ber1,'-ko',EbN0,ber2,'-k*');
legend('未编码','Hamming(7,4)编码');
title('未编码和Hamming(7,4)编码的QPSK在AWGN下的性能');
xlabel('Eb/N0');ylabel('误比特率')