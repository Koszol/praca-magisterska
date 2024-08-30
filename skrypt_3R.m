clear all;
close all;
clc;

th1=0;
th2=0;
th3=0;
[PosX,PosY,PosZ]=model_nominal3R(th1,th2,th3,1);
%% errors
% przypadek 1
% errorB0=[deg2rad(-0.0466),0.0017,0.4641,deg2rad(-0.3336),0.0143,deg2rad(0.9586)];  % dth dz dx dalfa dy dfi  
% error01=[deg2rad(0.0549),0.5595,0.851,deg2rad(1.1304),0,0];
% error12=[deg2rad(-0.8206),0.94,0.7131,deg2rad(0.6659),0,0];
% error23=[deg2rad(-0.0883),0.6466,0.9169,deg2rad(-0.2763),0,0];
% error34=[deg2rad(0.2967),0.6303,0.9087,deg2rad(-0.575),0,deg2rad(0.7318)];
% przypadek 2
% errorB0=[0,0,0,0,0,0];  % dth dz dx dalfa dy dfi  
% error01=[deg2rad(0.042),0,0,0,0,0];
% error12=[deg2rad(1.186),0,0,0,0,0];
% error23=[deg2rad(0.445),0,0,0,0,0];
% error34=[deg2rad(0.2967),0,0,0,0,0];
% przypadek 3
errorB0=[deg2rad(0.105),0.082,0.12,deg2rad(0.084),0,0];  % dth dz dx dalfa dy dfi  
error01=[deg2rad(-0.156),0.088,-0.729,deg2rad(0.037),0,0];
error12=[deg2rad(-1.192),-0.404,0.229,deg2rad(0.017),0,0];
error23=[deg2rad(0.479),0.106,-0.068,deg2rad(0.181),0,0];  % 4
error34=[deg2rad(-0.838),-0.085,-0.181,deg2rad(0.021),0,0];    % 5
%% model skalibrowany
[PosrealX,PosrealY,PosrealZ]=model_real3R(th1,th2,th3,1,errorB0,error01,error12,error23,error34);
%% ścieżka testowa
load("traj3R.mat")
th1_path=traj(1,:);
th2_path=traj(2,:);
th3_path=traj(3,:);
PathSize=length(th1_path);
[PathX(1:PathSize),PathY(1:PathSize),PathZ(1:PathSize)]=model_nominal3R(th1_path,th2_path,th3_path,PathSize);
[PathrealX(1:PathSize),PathrealY(1:PathSize),PathrealZ(1:PathSize)]=model_real3R(th1_path,th2_path,th3_path,PathSize,errorB0,error01,error12,error23,error34);
%% random errors
% dth dz dx dalfa dy dfi
std1=0.03;
std2=0.005;
for i=1:3
    % std.*randn(1,PathSize)+mean
    % przypadek 1
%     errorB0_rand=[deg2rad(randVal(-0.0466,std2,PathSize)),randVal(0.0017,std2,PathSize),randVal(0.4641,std1,PathSize),deg2rad(randVal(-0.3336,std1,PathSize)),randVal(0.0143,std2,PathSize),deg2rad(randVal(0.9586,std1,PathSize))];
%     error01_rand=[deg2rad(randVal(0.0549,std2,PathSize)),randVal(0.5595,std1,PathSize),randVal(0.851,std1,PathSize),deg2rad(randVal(1.1304,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
%     error12_rand=[deg2rad(randVal(-0.8206,std1,PathSize)),randVal(0.94,std1,PathSize),randVal(0.7131,std1,PathSize),deg2rad(randVal(0.6659,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
%     error23_rand=[deg2rad(randVal(-0.0883,std2,PathSize)),randVal(0.6466,std1,PathSize),randVal(0.9169,std1,PathSize),deg2rad(randVal(-0.2763,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
%     error34_rand=[deg2rad(randVal(0.2967,std1,PathSize)),randVal(0.6303,std1,PathSize),randVal(0.9087,std1,PathSize),deg2rad(randVal(-0.575,std1,PathSize)),zeros(PathSize,1),deg2rad(randVal(0.7318,std1,PathSize))];
    % przypadek 2
%     errorB0_rand=[zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
%     error01_rand=[deg2rad(randVal(0.042,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
%     error12_rand=[deg2rad(randVal(1.186,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
%     error23_rand=[deg2rad(randVal(0.445,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
%     error34_rand=[zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
    % przypadek 3
    errorB0_rand=[deg2rad(randVal(0.105,std1,PathSize)),randVal(0.0082,std2,PathSize),randVal(0.12,std1,PathSize),deg2rad(randVal(0.084,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
    error01_rand=[deg2rad(randVal(-0.156,std1,PathSize)),randVal(0.088,std2,PathSize),randVal(-0.729,std1,PathSize),deg2rad(randVal(0.037,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
    error12_rand=[deg2rad(randVal(-1.192,std1,PathSize)),randVal(-0.404,std1,PathSize),randVal(0.229,std1,PathSize),deg2rad(randVal(0.017,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
    error23_rand=[deg2rad(randVal(0.479,std1,PathSize)),randVal(0.106,std1,PathSize),randVal(-0.068,std2,PathSize),deg2rad(randVal(0.181,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
    error34_rand=[deg2rad(randVal(-0.838,std1,PathSize)),randVal(-0.085,std2,PathSize),randVal(-0.181,std1,PathSize),deg2rad(randVal(0.021,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
    
    tic
    [PathRealX(i,:),PathRealY(i,:),PathRealZ(i,:)]=path_3R(th1_path,th2_path,th3_path,errorB0_rand,error01_rand,error12_rand,error23_rand,error34_rand);
    toc
    delta_nominal=[PathRealX(i,:)-PathX;PathRealY(i,:)-PathY;PathRealZ(i,:)-PathZ];
    error_nominal(i,1:PathSize)=sqrt(delta_nominal(1,:).^2+delta_nominal(2,:).^2+delta_nominal(3,:).^2);    
    delta_real=[PathRealX(i,:)-PathrealX;PathRealY(i,:)-PathrealY;PathRealZ(i,:)-PathrealZ];
    error_real(i,1:PathSize)=sqrt(delta_real(1,:).^2+delta_real(2,:).^2+delta_real(3,:).^2);
end
%% check
error_nominal_mean(1,1:PathSize)=mean(error_nominal(:,1:PathSize));
error_real_mean(1,1:PathSize)=mean(error_real(:,1:PathSize));
% plot(error_nominal_mean)
% hold on
% plot(error_real_mean)

j=1;
x_errorbar=1:1:PathSize;
for i=x_errorbar;
    nom_min=min(error_nominal(:,i));
    nom_max=max(error_nominal(:,i));
    nom_std(i)=std(error_nominal(:,i));
    nom_mean=error_nominal_mean(i);
    if abs(nom_mean-nom_max)>abs(nom_mean-nom_min)
        nom_errorbar(j)=abs(nom_mean-nom_max);
    else
        nom_errorbar(j)=abs(nom_mean-nom_min);
    end
    real_min=min(error_real(:,i));
    real_max=max(error_real(:,i));
    real_mean=error_real_mean(i);
    real_std(i)=std(error_real(:,i));
    if abs(real_mean-real_max)>abs(real_mean-real_min)
        real_errorbar(j)=abs(real_mean-real_max);
    else
        real_errorbar(j)=abs(real_mean-real_min);
    end
    j=j+1;
end
figure
errorbar(x_errorbar,error_nominal_mean,nom_errorbar)
hold on
errorbar(x_errorbar,error_real_mean,real_errorbar)
title("Odległość od rzeczywistego położenia robota")
legend('Przed kalibracją','Po kalibracji')
xlabel("Numer próbki [-]")
ylabel("Odległość [mm]")
grid on
axis tight
sr_blad_nominal=mean(error_nominal_mean)
sr_odch_stand_nominal=mean(nom_std)
sr_blad_real=mean(error_real_mean)
sr_odch_stand_real=mean(real_std)
%% save models for next steps
figure
plot(delta_nominal(1,:))
hold on
plot(delta_real(1,:))