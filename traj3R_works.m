%%
clear all;
close all;
syms th11 d11 a11 al1
syms th22 d2 a22 al2
syms th33 d3 a33 al3
syms th4 d44 a4 al4
% load("traj3R.mat")
% th1_path=traj(1,:);
% th2_path=traj(2,:);
% th3_path=traj(3,:);
A1=mA(th11,d11,a11,-pi/2);
A2=mA(th22,0,a22,0);
% A3_1=mA(th33,0,0,0);
% A3_2=mA(pi/2,0,a33,-pi/2);
% A4=mA(0,d44,0,0);
A3=mA(th33,0,a33,pi/2);
% T03=A1*A2*A3_1*A3_2;
% A4=mA(th33,0,a33,pi/2);
zmie=[1,0,0,0;1,0,0,0;1,0,0,0];
% T03=zam(zmie,T03,'th')
Tra=A1*A2*A3;
T0n=zam(zmie,Tra,'th')
%% test case
PathSize=100;
t=linspace(0,2*pi,PathSize);
x=700*sin(t+pi/2);
y=700*sin(3*t);
z=linspace(200,400,PathSize);
% x=100+1000*cos(pi/4); y=0; z=300+1000*cos(pi/4);
a1=100; d1=300; a2=500;
r=sqrt(200.^2+300.^2);
th1_1=atan2(y,x);
alfa=sqrt(x.^2+y.^2);
A=2.*a2.*(-z+d1);
B=2.*a2.*(a1-alfa);
D=r^2-(alfa.^2+a1.^2-2.*alfa.*a1+a2.^2+d1^2+z.^2-2.*d1.*z);
th2_1=atan2(B,A)-atan2(D,sqrt(A.^2+B.^2-D.^2));
th2_2=atan2(B,A)-atan2(D,-sqrt(A.^2+B.^2-D.^2));
th3_1=atan2(d1-sin(th2_1)*a2-z,alfa-a1-cos(th2_1)*a2)-th2_1;
th3_2=atan2(d1-sin(th2_2)*a2-z,alfa-a1-cos(th2_2)*a2)-th2_2;
th1_1=unwrap(th1_1);
figure
plot(rad2deg(th1_1))
hold on
plot(rad2deg(th2_1))
plot(rad2deg(th3_1))
legend("Kąt theta1","Kąt theta2","Kąt theta3")
%% zadanie proste
% a1V=100; d1V=300; a2V=500; a3V=-200; d4V=300;
XYZ_sym=Tra(1:3,4);
XYZ_val=double(subs(XYZ_sym,{d11,a11,a22,a33,th11,th22,th33},{d1,a1,a2,r,th1_1,th2_2,th3_2}))
figure
plot3(XYZ_val(1,:),XYZ_val(2,:),XYZ_val(3,:))