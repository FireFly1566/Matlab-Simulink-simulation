clear all
EbN0=0:10;
ber=berawgn(EbN0,'qam',16);
for ii=1:length(EbN0)
    BER=ber(ii);
    sim('fz8_7');
    ber1(ii)=BER1(1);
    
end

semilogy(EbN0,ber,'-ko',EbN0,ber1,'-k*');
legend('未编码','RS(15,11)编码')
title('未编码和RS(15,11)编码的16-QAM在AWGN下的性能')
xlabel('Eb/N0');ylabel('误比特率')