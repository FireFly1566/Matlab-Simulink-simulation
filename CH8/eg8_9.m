clear all
EbN0=0:10;
ber=berawgn(EbN0,'qam',16);

for ii=1:length(EbN0)
    BER=ber(ii);
    sim('fz8_9');
    pmissed(ii)=MissedFrame(end)/length(MissedFrame);
    
end

semilogy(EbN0,pmissed,'-ko');
title('CRC-16¼ì²âĞÔÄÜ')
xlabel('Eb/N0');ylabel('¼ìÂ©¸ÅÂÊ')
axis([0 8 10.^(-6) 10.^(-3)])