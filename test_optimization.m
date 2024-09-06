clear all
close all
a1=100;
d1=300;
a2=500;
a3=-200;
d4=300;
options=optimoptions(@fsolve,'Algorithm','trust-region','Functiontolerance',1e-8,'Display','iter');
%% test case
% x=900; y=0; z=500;
PathSize=30;
% x=0; y=900; z=500;
t=linspace(0,2*pi,PathSize);
x=500*sin(t+pi/2);
y=500*sin(3*t);
z=linspace(400,600,PathSize);
initialGuessDegrees=[45;45;45];
initialGuessRadians=deg2rad(initialGuessDegrees);

[solutionThetaRadians]=fsolve(@(theta)kinematics(theta,x,y,z,a1,a2,a3,d1,d4),initialGuessRadians,options)
solutionThetaDegrees=rad2deg(solutionThetaRadians)
function F=kinematics(theta,x,y,z,a1,a2,a3,d1,d4)
F=[x-(cos(theta(1))*(a1+cos(theta(2))*a2+cos(theta(2)+theta(3))*d4-sin(theta(2)+theta(3))*a3));
    y-(sin(theta(1))*(a1+cos(theta(2))*a2+cos(theta(2)+theta(3))*d4-sin(theta(2)+theta(3))*a3));
    z-(d1-cos(theta(2)+theta(3))*a3-sin(theta(2))*a2-sin(theta(2)+theta(3))*d4)];
end