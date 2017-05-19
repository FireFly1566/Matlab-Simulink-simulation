clear all
%仿真V-BALST结构ZF检测算法性能，QPSK调制

Nt=4;   %发射天线数
Nr=4;   %接收天线数
N=10;   %每帧长度
L=10000;    %仿真的总帧数
EbN0=0:2:20;
M=4;
x=randint(N*L,Nt,M);    %信源数据
s=pskmod(x,M,pi/4);

for  indx=1:length(EbN0)
    s1=[];
    s2=[];
    s3=[];
    for indx1=1:L
        h=randn(Nt,Nr)+j*randn(Nt,Nr);  %Rayleigh衰落信道系数
        h=h./sqrt(2);   %信道系数归一化
        [q1,r1]=qr(h'); %信道系数矩阵QR分解
        r=r1(1:Nt,:)';  %矩阵R
        q=q1(:,1:Nt)';
        
        sigma1=sqrt(1/(10.^(EbN0(indx)/10)));   %每根接收天线的高斯白噪声标准差
        n=sigma1*(randn(N,Nr)+j*randn(N,Nr));   %每根接收天线的高斯白噪声
        
        y=s((indx1-1)*N+1:indx1*N,:)*h*q'+n*q'; %信号通过信道
        
        y1=y*inv(r);    %无干扰消除时的ZF检测
        s1=[s1;pskdemod(y1,M,pi/4)];
        
        %有干扰消除时的ZF检测
        y(:,Nt)=y(:,Nt)./(r(Nt,Nt));    %检测第Nt层
        y1(:,Nt)=pskdemod(y(:,Nt),M,pi/4);  %解调第Nt层
        y(:,Nt)=pskmod(y1(:,Nt),M,pi/4);    %对第Nt层解调结果重新进行调制
        y2=y;
        y3=y1;
        
        for jj=Nt-1:-1:1    %检测第Nt-1:1 层
            for kk=jj+1:Nt
                y(:,jj)=y(:,jj)-r(kk,jj).*y(:,kk);  %非理想干扰消除
                y2(:,jj)=y2(:,jj)-r(kk,jj).*s((indx1-1)*N+1:indx1*N,kk);
                
            end
            
            y(:,jj)=y(:,jj)./r(jj,jj);
            y2(:,jj)=y2(:,jj)./r(jj,jj);    %第jj层判决变量
            y1(:,jj)=pskdemod(y(:,jj),M,pi/4);  %对第jj层解调
            y3(:,jj)=pskdemod(y2(:,jj),M,pi/4);
            y(:,jj)=pskmod(y1(:,jj),M,pi/4);    %对jj层解调结果重新进行解调
            y2(:,jj)=pskmod(y3(:,jj),M,pi/4);
           
        end
        
        s2=[s2;y1];
        s3=[s3;y3];
        
    end
    
    [temp,ber1(indx)]=biterr(x,s1,log2(M)); %无干扰消除时的系统误码率
    [temp,ber2(indx)]=biterr(x,s2,log2(M)); %非理想干扰消除时系统总的误码率
    [temp,ber3(indx)]=biterr(x,s3,log2(M)); %理想干扰消除时系统总的误码率
    
    [temp,ber24(indx)]=biterr(x(:,1),s2(:,1),log2(M));  %非理想干扰消除时第4层的误码率
    [temp,ber23(indx)]=biterr(x(:,2),s2(:,2),log2(M)); %非理想干扰消除时第3层的误码率
   [temp,ber22(indx)]=biterr(x(:,3),s2(:,3),log2(M));   %非理想干扰消除时第2层的误码率
   [temp,ber21(indx)]=biterr(x(:,4),s2(:,4),log2(M));   %非理想干扰消除时1层误码率
   
   [temp,ber34(indx)]=biterr(x(:,1),s3(:,1),log2(M));   %理想干扰消除时第4层误码率
   [temp,ber33(indx)]=biterr(x(:,2),s3(:,2),log2(M));
   [temp,ber32(indx)]=biterr(x(:,3),s3(:,3),log2(M));
   [temp,ber31(indx)]=biterr(x(:,4),s3(:,4),log2(M));
      
end

semilogy(EbN0,ber1,'-k*',EbN0,ber2,'-ko',EbN0,ber3,'-kd')
title('V-BLAST结构ZF检测算法性能')
legend('无干扰消除','非理想干扰消除','理想干扰消除')
xlabel('EbN0(dB)')
ylabel('BER')

figure
semilogy(EbN0,ber34,'-k*',EbN0,ber33,'-ko',EbN0,ber32,'-kd',EbN0,ber31,'-k^')
title('理想干扰消除时ZF检测算法各层性能')
legend('第1层','2层','3层','4层')
xlabel('EbN0')
ylabel('BER')

figure
semilogy(EbN0,ber24,'-k*',EbN0,ber23,'-ko',EbN0,ber22,'-kd',EbN0,ber21,'-k^')
title('非理想干扰消除时ZF检测算法各层性能')
xlabel('EbN0')
ylabel('BER')








