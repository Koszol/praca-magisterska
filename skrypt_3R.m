clear all;
close all;
clc;

th1=0;
th2=0;
th3=0;
[PosX,PosY,PosZ]=model_nominal3R(th1,th2,th3,1);
%% errors
% dth dz dx dalfa dy dfi
errorB0=[0,0.1,0,0,0.1,0];
error01=[0,0,0.1,0,0,0];
error12=[deg2rad(0.1),0,0,0,0,0];
error23=[0,0,0,0,0,0];
error34=[0,0,0,0,0,0];
%% model skalibrowany
[PosCalX,PosCalY,PosCalZ]=model_cal3R(th1,th2,th3,1,errorB0,error01,error12,error23,error34);

%% ścieżka testowa
PathSize=1000;
th1_path=linspace(0,0,PathSize);
th2_path=linspace(0,pi/2,PathSize);
th3_path=linspace(0,0,PathSize);
[PathX(1:PathSize),PathY(1:PathSize),PathZ(1:PathSize)]=model_nominal3R(th1_path,th2_path,th3_path,PathSize);
[PathCalX(1:PathSize),PathCalY(1:PathSize),PathCalZ(1:PathSize)]=model_cal3R(th1_path,th2_path,th3_path,PathSize,errorB0,error01,error12,error23,error34);
%% random errors
% dth dz dx dalfa dy dfi
% std.*randn(1,PathSize)+mean
errorB0_rand=[zeros(PathSize,1),randVal(0.1,0.01,PathSize),zeros(PathSize,1),zeros(PathSize,1),randVal(0.1,0.01,PathSize),zeros(PathSize,1)];
error01_rand=[zeros(PathSize,1),zeros(PathSize,1),randVal(0.1,0.01,PathSize),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
error12_rand=[deg2rad(randVal(0.1,0.01,PathSize)),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),];
error23_rand=[zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
error34_rand=[zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
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
srednia_bledu_nominal=mean(error_nominal)
srednia_bledu_cal=mean(error_cal)