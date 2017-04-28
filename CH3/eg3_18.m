clear all    %本例自相关函数是连续函数，计算时需要对其抽样，
ts = 0.002;  %设置抽样间隔
tao=-1:ts:1;  %| tao| >1时，自相关函数值很小
B=20;
f0=100;
R=sinc(2*B*tao) .* cos(2*pi*f0*tao);

fs=1/ts;  %抽样频率
df = fs/length(tao); %频率分辨率
f = -fs/2 : df :fs/2-df;  %生成频率矢量
S = fft(R)/fs; %计算功率谱密度
subplot(2,1,1);plot(tao,R);title('自相关函数');xlabel('tao');ylabel('R');
subplot(2,1,2);plot(f,fftshift(abs(S)));title('功率谱密度');xlabel('f');ylabel('S');