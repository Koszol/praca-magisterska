clear all;
close all;
clc;
%% lissajous
t=linspace(0,2*pi,50);
x=600*sin(t+pi/2);
y=600*sin(3*t);
plot(x,y)
%% zadanie odwrotne
% x=700;
% y=100;
l1=500;
l2=400;
licz1=l2.^2-l1.^2-x.^2-y.^2;
mian1=4*l1.^2*(x.^2+y.^2)-(l2.^2-l1.^2-x.^2-y.^2).^2;
th1_1=atan2(-x,y)-atan2(licz1,sqrt(mian1));
th2_1=atan2(y-l1*sin(th1_1),x-l1*cos(th1_1))-th1_1;
%% test
X=l1*cos(th1_1)+l2*cos(th1_1+th2_1);
Y=l1*sin(th1_1)+l2*sin(th1_1+th2_1);
% plot(X,Y)
traj=[th1_1;th2_1];
save("traj2R.mat","traj")