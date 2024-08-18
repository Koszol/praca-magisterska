clear all;
close all;
clc;

th1=0;
th2=0;
th3=0;
[PosX,PosY,PosZ]=model_nominal3R(th1,th2,th3,1);
%% errors
% przypadek 1
% errorB0=[deg2rad(-0.466),0.0017,-0.3336,deg2rad(0.4641),0.0143,deg2rad(0.9586)];  % dth dz dx dalfa dy dfi  
% error01=[deg2rad(0.0549),0.5595,1.1304,deg2rad(0.851),0,0];
% error12=[deg2rad(-0.8206),0.94,0.6659,deg2rad(0.7131),0,0];
% error23=[deg2rad(-0.0883),0.6466,-0.2763,deg2rad(0.9169),0,0];
% error34=[deg2rad(0.2967),0.6303,-0.575,deg2rad(0.9087),0,deg2rad(0.7318)];
% przypadek 3
errorB0=[deg2rad(0.105),0.082,0.12,deg2rad(0.084),0,0];  % dth dz dx dalfa dy dfi  
error01=[deg2rad(-0.156),0.088,-0.729,deg2rad(0.037),0,0];
error12=[deg2rad(-1.192),-0.404,0.229,deg2rad(0.017),0,0];
error23=[deg2rad(0.479),0.106,-0.068,deg2rad(0.181),0,0];  % 4
error34=[deg2rad(-0.838),-0.085,-0.181,deg2rad(0.021),0,0];    % 5
%% model skalibrowany
[PosCalX,PosCalY,PosCalZ]=model_cal3R(th1,th2,th3,1,errorB0,error01,error12,error23,error34);
%% ścieżka testowa
PathSize=200;
th1_path=linspace(0,pi/2,PathSize);
th2_path=linspace(0,pi/4,PathSize);
th3_path=linspace(0,pi/4,PathSize);
[PathX(1:PathSize),PathY(1:PathSize),PathZ(1:PathSize)]=model_nominal3R(th1_path,th2_path,th3_path,PathSize);
[PathCalX(1:PathSize),PathCalY(1:PathSize),PathCalZ(1:PathSize)]=model_cal3R(th1_path,th2_path,th3_path,PathSize,errorB0,error01,error12,error23,error34);
%% random errors
% dth dz dx dalfa dy dfi
std1=0.03;
std2=0.005;
% std.*randn(1,PathSize)+mean
% przypadek 1
% errorB0_rand=[deg2rad(randVal(-0.466,std1,PathSize)),randVal(0.0017,std2,PathSize),randVal(-0.3336,std1,PathSize),deg2rad(randVal(0.4641,std1,PathSize)),randVal(0.0143,std2,PathSize),deg2rad(randVal(0.9586,std1,PathSize))];
% error01_rand=[deg2rad(randVal(0.0549,std2,PathSize)),randVal(0.5595,std1,PathSize),randVal(1.1304,std1,PathSize),deg2rad(randVal(0.851,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
% error12_rand=[deg2rad(randVal(-0.8206,std1,PathSize)),randVal(0.94,std1,PathSize),randVal(0.6659,std1,PathSize),deg2rad(randVal(0.7131,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
% error23_rand=[deg2rad(randVal(-0.0883,std2,PathSize)),randVal(0.6466,std1,PathSize),randVal(-0.2763,std1,PathSize),deg2rad(randVal(0.9169,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
% error34_rand=[deg2rad(randVal(0.2967,std1,PathSize)),randVal(0.6303,std1,PathSize),randVal(-0.575,std1,PathSize),deg2rad(randVal(0.9087,std1,PathSize)),zeros(PathSize,1),deg2rad(randVal(0.7318,std1,PathSize))];
% przypadek 2
errorB0_rand=[deg2rad(randVal(0.105,std1,PathSize)),randVal(0.0082,std2,PathSize),randVal(0.12,std1,PathSize),deg2rad(randVal(0.084,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
error01_rand=[deg2rad(randVal(-0.156,std1,PathSize)),randVal(0.088,std2,PathSize),randVal(-0.729,std1,PathSize),deg2rad(randVal(0.037,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
error12_rand=[deg2rad(randVal(-1.192,std1,PathSize)),randVal(-0.404,std1,PathSize),randVal(0.229,std1,PathSize),deg2rad(randVal(0.017,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
error23_rand=[deg2rad(randVal(0.479,std1,PathSize)),randVal(0.106,std1,PathSize),randVal(-0.068,std2,PathSize),deg2rad(randVal(0.181,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
error34_rand=[deg2rad(randVal(-0.838,std1,PathSize)),randVal(-0.085,std2,PathSize),randVal(-0.181,std1,PathSize),deg2rad(randVal(0.021,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];

tic
[PathRealX,PathRealY,PathRealZ]=path_3R(th1_path,th2_path,th3_path,errorB0_rand,error01_rand,error12_rand,error23_rand,error34_rand);
toc
%% check
delta_nominal=[PathRealX-PathX;PathRealY-PathY;PathRealZ-PathZ];
error_nominal(1:PathSize)=sqrt(delta_nominal(1,:).^2+delta_nominal(2,:).^2+delta_nominal(3,:).^2);
delta_cal=[PathRealX-PathCalX;PathRealY-PathCalY;PathRealZ-PathCalZ];
error_cal(1:PathSize)=sqrt(delta_cal(1,:).^2+delta_cal(2,:).^2+delta_cal(3,:).^2);
plot(error_nominal)
hold on
plot(error_cal)
title("Odległość od rzeczywistego położenia robota")
legend('Przed kalibracją','Po kalibracji')
xlabel("Numer próbki[-]")
ylabel("Odległość[mm]")
grid on
srednia_bledu_nominal=mean(error_nominal)
srednia_bledu_cal=mean(error_cal)