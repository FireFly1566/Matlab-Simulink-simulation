clear all
fd=120; %多普勒频移
ts=1/100000; %信号抽样时间间隔
t=0:ts:1;
tau=[0 6e-5 11e-5]; %多径延迟
pdb=[0 -3 -6]; %各径增益
chan = rayleighchan(ts,fd,tau,pdb);
%plot( 20*log10(abs(chan) )  );

title('fd=120Hz时的信道功率曲线');
xlabel('时间');ylabel('功率');