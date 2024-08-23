clear all;
close all;
PathSize=30;
t=linspace(0,2*pi,PathSize);
x=500*sin(t+pi/2);
y=500*sin(3*t);
z=linspace(400,600,PathSize);
figure
plot3(x,y,z)
hold on
grid on
xlabel("Oś X [mm]")
ylabel("Oś Y [mm]")
zlabel("Oś Z [mm]")
title("Przebieg trajektorii w rzucie izometrycznym")
axis tight
figure
plot(x,y)
hold on
grid on
xlabel("Oś X [mm]")
ylabel("Oś Y [mm]")
axis tight
title("Przebieg trajektorii w rzucie z góry")
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
plot(rad2deg(wrapToPi(th1)))
hold on
plot(rad2deg(wrapToPi(th2)))
plot(rad2deg(wrapToPi(th3)))
axis tight
grid on
xlabel("Czas [s]")
ylabel("Kąt [stopnie]")
legend("Kąt theta1","Kąt theta2")
title("Wykres współrzędnych złączowych układu 3R")
legend("Kąt theta1","Kąt theta2","Kąt theta3")
traj=[th1;th2;th3];
save("traj3R.mat","traj")