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
load("traj2R.mat")
th1_path=traj(1,:);
th2_path=traj(2,:);
PathSize=length(th1_path);
[PathX(1:PathSize),PathY(1:PathSize),PathZ(1:PathSize)]=model_nominal2R(th1_path,th2_path,PathSize);
[PathCalX(1:PathSize),PathCalY(1:PathSize),PathCalZ(1:PathSize)]=model_cal2R(th1_path,th2_path,PathSize,errorB0,error01,error12);
%% normally distributed random errors 
% dth dz dx dalfa dy dfi
std1=0.03;
std2=0.005;
% std.*randn(1,PathSize)+mean

for i=1:10
    tic
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
    [PathRealX(i,:),PathRealY(i,:),PathRealZ(i,:)]=path_2R(th1_path,th2_path,errorB0_rand,error01_rand,error12_rand);
    delta_nominal=[PathRealX(i,:)-PathX;PathRealY(i,:)-PathY;PathRealZ(i,:)-PathZ];
    error_nominal(i,1:PathSize)=sqrt(delta_nominal(1,:).^2+delta_nominal(2,:).^2+delta_nominal(3,:).^2);
    delta_cal=[PathRealX(i,:)-PathCalX;PathRealY(i,:)-PathCalY;PathRealZ(i,:)-PathCalZ];
    error_cal(i,1:PathSize)=sqrt(delta_cal(1,:).^2+delta_cal(2,:).^2+delta_cal(3,:).^2);    
    toc
end

%% check
error_nominal_mean(1,1:PathSize)=mean(error_nominal(:,1:PathSize));
error_cal_mean(1,1:PathSize)=mean(error_cal(:,1:PathSize));
j=1;
x_errorbar=1:1:PathSize;
for i=x_errorbar;
    nom_min=min(error_nominal(:,i));
    nom_max=max(error_nominal(:,i));
    nom_mean=error_nominal_mean(i);
    if abs(nom_mean-nom_max)>abs(nom_mean-nom_min)
        nom_errorbar(j)=abs(nom_mean-nom_max);
    else
        nom_errorbar(j)=abs(nom_mean-nom_min);
    end
    cal_min=min(error_cal(:,i));
    cal_max=max(error_cal(:,i));
    cal_mean=error_cal_mean(i);
    if abs(cal_mean-cal_max)>abs(cal_mean-cal_min)
        cal_errorbar(j)=abs(cal_mean-cal_max);
    else
        cal_errorbar(j)=abs(cal_mean-cal_min);
    end
    j=j+1;
end


figure
errorbar(x_errorbar,error_nominal_mean,nom_errorbar)
hold on
errorbar(x_errorbar,error_cal_mean,cal_errorbar)
title("Odległość od rzeczywistego położenia robota")
legend('Model nominalny','Model skalibrowany')
xlabel("Numer próbki")
ylabel("Odległość [mm]")
grid on
axis tight