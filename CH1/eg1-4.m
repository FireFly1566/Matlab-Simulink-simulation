x=linspace(0,2*pi,200);
y1=sin(x);
y2=cos(x);
plot(x,y1,'go',x,y2,'b-.')
title('sin(x),cos(x) 曲线');
xlabel('时间');
ylabel('振幅');
text(x(150),y1(150), 'sin(x)曲线');
text( x(150),y2(150),'cos(x)曲线' );
axis([0 2*pi -2 2]);
grid on
legend('sin(x)','cos(x)');