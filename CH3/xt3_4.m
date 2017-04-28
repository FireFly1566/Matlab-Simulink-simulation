clear all
x1=[1 2 3 4];
x2=[0.5,0.3,0.2,0.1];

sum = x1+x2;
subplot(2,1,1);stem(sum);title('序列和');

yn=conv(x1,x2);
subplot(2,1,2);stem(yn);title('卷积和');
