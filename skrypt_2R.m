clear all;
close all;
clc;

th1=0;
th2=0;
[PosX,PosY,PosZ]=model_nominal2R(th1,th2,1);
%% errors
% przypadek 1 POPRAWIĆ!!!
errorB0=[deg2rad(-0.466),0,0.4641,deg2rad(0),0.0143,0];  % dth dz dx dalfa dy dfi  
error01=[deg2rad(0.0549),0,0.851,deg2rad(0),0,0];
error12=[deg2rad(-0.8206),0,0.6659,deg2rad(0),0,0];
% przypadek 2
% errorB0=[deg2rad(0.042),0,0,deg2rad(0),0,0];  % dth dz dx dalfa dy dfi  
% error01=[deg2rad(1.186),0,0,deg2rad(0),0,0];
% error12=[deg2rad(0.445),0,0,deg2rad(0),0,0];
% przypadek 3
% errorB0=[deg2rad(0.105),0.082,0.12,deg2rad(0.084),0,0];  % dth dz dx dalfa dy dfi  
% error01=[deg2rad(-0.156),0.088,-0.729,deg2rad(0.037),0,0];
% error12=[deg2rad(-1.192),-0.404,0.229,deg2rad(0.017),0,0];
%% model skalibrowany
[PosCalX,PosCalY,PosCalZ]=model_cal2R(th1,th2,1,errorB0,error01,error12);
delta_x=PosCalX-PosX;
delta_y=PosCalY-PosY;
delta_z=PosCalZ-PosZ;
Distance=sqrt(delta_x.^2+delta_y.^2+delta_z.^2)
%% ścieżka testowa
PathSize=1000;
th1_path=linspace(0,pi/2,PathSize/2);
th1_path((PathSize/2)+1:PathSize)=linspace(pi/2,pi/2,PathSize/2);
th2_path=linspace(0,0,PathSize/2);
th2_path((PathSize/2)+1:PathSize)=linspace(0,pi/2,PathSize/2);
[PathX(1:PathSize),PathY(1:PathSize),PathZ(1:PathSize)]=model_nominal2R(th1_path,th2_path,PathSize);
[PathCalX(1:PathSize),PathCalY(1:PathSize),PathCalZ(1:PathSize)]=model_cal2R(th1_path,th2_path,PathSize,errorB0,error01,error12);
%% normally distributed random errors 
% dth dz dx dalfa dy dfi
std1=0.03;
std2=0.005;
% std.*randn(1,PathSize)+mean
% przypadek 1
errorB0_rand=[deg2rad(randVal(-0.466,0.03,PathSize)),zeros(PathSize,1),randVal(0.4641,0.03,PathSize),zeros(PathSize,1),randVal(0.0143,0.005,PathSize),zeros(PathSize,1)];
error01_rand=[deg2rad(randVal(-0.0549,0.005,PathSize)),zeros(PathSize,1),randVal(0.851,0.03,PathSize),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
error12_rand=[deg2rad(randVal(-0.8206,0.03,PathSize)),zeros(PathSize,1),randVal(0.6659,0.03,PathSize),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),];
% przypadek 2
% errorB0_rand=[deg2rad(randVal(0.042,0.033,PathSize)),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
% error01_rand=[deg2rad(randVal(1.186,0.643,PathSize)),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
% error12_rand=[deg2rad(randVal(0.445,0.36,PathSize)),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),];
% przypadek 3
% errorB0_rand=[deg2rad(randVal(0.105,std1,PathSize)),randVal(0.082,std2,PathSize),randVal(0.12,std1,PathSize),deg2rad(randVal(0.084,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
% error01_rand=[deg2rad(randVal(-0.156,std1,PathSize)),randVal(0.088,std2,PathSize),randVal(-0.729,std1,PathSize),deg2rad(randVal(0.037,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
% error12_rand=[deg2rad(randVal(-1.192,std1,PathSize)),randVal(-0.404,std1,PathSize),randVal(0.229,std1,PathSize),deg2rad(randVal(0.017,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];

tic
[PathRealX,PathRealY,PathRealZ]=path_2R(th1_path,th2_path,errorB0_rand,error01_rand,error12_rand);
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
xlabel("Numer próbki")
ylabel("Odległość [mm]")
grid on
srednia_bledu_nominal=mean(error_nominal)
srednia_bledu_cal=mean(error_cal)