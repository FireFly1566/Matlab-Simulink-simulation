clear all
f=1; %�����ź�Ƶ��
v=0; %�ƶ�̨�ٶȣ���ֹΪ0
c=3e8; %����
r0=3; %�ƶ�̨���վ�ĳ�ʼ����
d=10; %��վ���뷴��ǽ����
t1=0.1:0.0001:10; 
E1= cos(2*pi*f*((1-v/c).*t1-r0/c))./(r0+v.*t1); %ֱ�侶�ź�
E2=cos(2*pi*f*((1+v/c)*t1+(r0-2*d)/c))./(2*d-r0-v*t1); %�����ź�

figure
plot(t1,E1,t1,E2,'-g',t1,E1-E2,'-r');
legend('ֱ�侶�ź�','���侶�ź�','�ƶ�̨���յĺϳ��ź�')
axis([0 10 -0.8 0.8])