clear all;
t=linspace(0,2*pi,100);
x=500*sin(t+pi/2);
y=500*sin(3*t);
z=linspace(400,600,100);
figure
plot3(x,y,z)
%% 
% x=000;
% y=900;
% z=500;
l1=300;
a1=100;
a2=100;
l2=500;

a3=200;
d4=300;
l3=sqrt(a3^2+d4^2);
alfa=asin(200/l3);
%%
th1=atan2(y,x);
% r1=sqrt(x.^2+y.^2);
r1=sqrt((x).^2+(y).^2)-sqrt((100*cos(th1)).^2+(100*sin(th1)).^2);
r2=z-l1;
fi2=atan2(r2,r1);
r3=sqrt(r1.^2+r2.^2);
fi1=acos((r3.^2+l2^2-l3^2)./(2*l2.*r3));
th2=round((fi2-fi1),8);
fi3=acos((l2^2+l3^2-r3.^2)./(-2*l2*l3))-alfa;
th3=round((pi-fi3),8);
figure
plot(th1)
hold on
plot(th2)
plot(th3)