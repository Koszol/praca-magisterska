clear all;
close all;
clc;

th1=0;
th2=0;
th3=0;
[PosX,PosY,PosZ]=model_nominal3R(th1,th2,th3,1);
%% errors
% przypadek 1
errorB0=[deg2rad(-0.0466),0.0017,0.4641,deg2rad(-0.3336),0,deg2rad(0)];  % dth dz dx dalfa dy dfi  
error01=[deg2rad(0.0549),0.5595,0.851,deg2rad(1.1304),0,0];
error12=[deg2rad(-0.8206),0.94,0.7131,deg2rad(0.6659),0,0];
error23=[deg2rad(-0.0883),0.6466,0.9169,deg2rad(-0.2763),0,0];
    error34=[deg2rad(0.2967),0.6303,0.9087,deg2rad(-0.575),0,deg2rad(0)];
% przypadek 2
% errorB0=[0,0,0,0,0,0];  % dth dz dx dalfa dy dfi  
% error01=[deg2rad(0.042),0,0,0,0,0];
% error12=[deg2rad(1.186),0,0,0,0,0];
% error23=[deg2rad(0.445),0,0,0,0,0];
% error34=[deg2rad(0.2967),0,0,0,0,0];
% przypadek 3
% errorB0=[deg2rad(0.105),0.082,0.12,deg2rad(0.084),0,0];  % dth dz dx dalfa dy dfi  
% error01=[deg2rad(-0.156),0.088,-0.729,deg2rad(0.037),0,0];
% error12=[deg2rad(-1.192),-0.404,0.229,deg2rad(0.017),0,0];
% error23=[deg2rad(0.479),0.106,-0.068,deg2rad(0.181),0,0];  % 4
%     error34=[deg2rad(-0.838),-0.085,-0.181,deg2rad(0.021),0,0];    % 5
%% model rzeczywisty
[PosrealX,PosrealY,PosrealZ]=model_real3R(th1,th2,th3,1,errorB0,error01,error12,error23);
%% ścieżka testowa
load("traj3R.mat")
th1_path=traj(1,:);
th2_path=traj(2,:);
th3_path=traj(3,:);
PathSize=length(th1_path);
[PathX(1:PathSize),PathY(1:PathSize),PathZ(1:PathSize)]=model_nominal3R(th1_path,th2_path,th3_path,PathSize);
[PathrealX(1:PathSize),PathrealY(1:PathSize),PathrealZ(1:PathSize)]=model_real3R(th1_path,th2_path,th3_path,PathSize,errorB0,error01,error12,error23);
%% random errors
% dth dz dx dalfa dy dfi
std1=0.1;
std2=0.01;
% std1=0.03;
% std2=0.005;
for i=1:5
    % std.*randn(1,PathSize)+mean
    % przypadek 1
    errorB0_rand=[deg2rad(randVal(-0.0466,std2,PathSize)),randVal(0.0017,std2,PathSize),randVal(0.4641,std1,PathSize),deg2rad(randVal(-0.3336,std1,PathSize)),randVal(0,0,PathSize),deg2rad(randVal(0,0,PathSize))];
    error01_rand=[deg2rad(randVal(0.0549,std2,PathSize)),randVal(0.5595,std1,PathSize),randVal(0.851,std1,PathSize),deg2rad(randVal(1.1304,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
    error12_rand=[deg2rad(randVal(-0.8206,std1,PathSize)),randVal(0.94,std1,PathSize),randVal(0.7131,std1,PathSize),deg2rad(randVal(0.6659,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
    error23_rand=[deg2rad(randVal(-0.0883,std2,PathSize)),randVal(0.6466,std1,PathSize),randVal(0.9169,std1,PathSize),deg2rad(randVal(-0.2763,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
%         error34_rand=[deg2rad(randVal(0.2967,std1,PathSize)),randVal(0.6303,std1,PathSize),randVal(0.9087,std1,PathSize),deg2rad(randVal(-0.575,std1,PathSize)),zeros(PathSize,1),deg2rad(randVal(0,0,PathSize))];
    % przypadek 2
%     errorB0_rand=[zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
%     error01_rand=[deg2rad(randVal(0.042,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
%     error12_rand=[deg2rad(randVal(1.186,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
%     error23_rand=[deg2rad(randVal(0.445,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
%       error34_rand=[zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
    % przypadek 3
%     errorB0_rand=[deg2rad(randVal(0.105,std1,PathSize)),randVal(0.0082,std2,PathSize),randVal(0.12,std1,PathSize),deg2rad(randVal(0.084,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
%     error01_rand=[deg2rad(randVal(-0.156,std1,PathSize)),randVal(0.088,std2,PathSize),randVal(-0.729,std1,PathSize),deg2rad(randVal(0.037,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
%     error12_rand=[deg2rad(randVal(-1.192,std1,PathSize)),randVal(-0.404,std1,PathSize),randVal(0.229,std1,PathSize),deg2rad(randVal(0.017,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
%     error23_rand=[deg2rad(randVal(0.479,std1,PathSize)),randVal(0.106,std1,PathSize),randVal(-0.068,std2,PathSize),deg2rad(randVal(0.181,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
%         error34_rand=[deg2rad(randVal(-0.838,std1,PathSize)),randVal(-0.085,std2,PathSize),randVal(-0.181,std1,PathSize),deg2rad(randVal(0.021,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1)];
    tic
    [PathRealX(i,:),PathRealY(i,:),PathRealZ(i,:)]=path_3R(th1_path,th2_path,th3_path,errorB0_rand,error01_rand,error12_rand,error23_rand);
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
%% kalibracja
X_real(1,:)=mean(PathRealX);
Y_real(1,:)=mean(PathRealY);
Z_real(1,:)=mean(PathRealZ);
save("RealVal3R.mat","X_real","Y_real","Z_real");
x0=[0;0;0;0;0;0;0];
disp("in")
tic
parametr=lsqnonlin(@myfun,x0);
toc
x1=parametr(1);
x2=parametr(2);
x3=parametr(3);
x4=parametr(4);
x5=parametr(5);
x6=parametr(6);
x7=parametr(7);
% x8=parametr(8);
% x9=parametr(9);
% x10=parametr(10);
% x11=parametr(11);
% x12=parametr(12);
%%
[CalX,CalY,CalZ,Tn]=model_cal3R(th1_path,th2_path,th3_path,x1,x2,x3,x4,x5,x6,x7);
% testing!
[th1_c,th2_c,th3_c]=invCalKin(CalX,CalY,CalZ,x1,x2,x3,x4,x5,x6,x7);
[PathCalX,PathCalY,PathCalZ]=model_real3R(th1_c,th2_c,th3_c,PathSize,errorB0,error01,error12,error23);

for i=1:5
    delta_cal=[PathRealX(i,:)-CalX;PathRealY(i,:)-CalY;PathRealZ(i,:)-CalZ];
    error_cal(i,1:PathSize)=sqrt(delta_cal(1,:).^2+delta_cal(2,:).^2+delta_cal(3,:).^2);
end
error_cal_mean(1,1:PathSize)=mean(error_cal(:,1:PathSize));
for i=x_errorbar
    cal_min=min(error_cal(:,i));
    cal_max=max(error_cal(:,i));
    cal_std(i)=std(error_cal(:,i));
    cal_mean=error_cal_mean(i);
    if abs(cal_mean-cal_max)>abs(cal_mean-cal_min)
        cal_errorbar(i)=abs(cal_mean-cal_max);
    else
        cal_errorbar(i)=abs(cal_mean-cal_min);
    end
end
%% wykresy
figure
errorbar(x_errorbar,error_nominal_mean,nom_errorbar)
hold on
errorbar(x_errorbar,error_real_mean,real_errorbar)
errorbar(x_errorbar,error_cal_mean,cal_errorbar)
title("Odległość od rzeczywistego położenia robota")
legend('Przed kalibracją','Po kalibracji')
xlabel("Numer próbki [-]")
ylabel("Odległość [mm]")
grid on
axis tight
sr_blad_nominal=mean(error_nominal_mean)
sr_odch_stand_nominal=mean(nom_std)
sr_blad_cal=mean(error_cal_mean)
sr_odch_stand_cal=mean(cal_std)
sr_blad_real=mean(error_real_mean)
sr_odch_stand_real=mean(real_std)
%% save models for next steps
% figure
% plot(delta_nominal(1,:))
% hold on
% plot(delta_real(1,:))

function F=myfun(x)
    load("traj3R.mat")
    load("RealVal3R.mat")
    th1_path=traj(1,:);
    th2_path=traj(2,:);
    th3_path=traj(3,:);
    Tn=nom_sym;
    syms th1 d1 a1 al1
    syms th2 d2 a2 al2
    syms th3 d3 r al3
%     syms th4 d4 a4 al4
    a1V=100; d1V=300; a2V=500; a3V=200; d4V=300;
    rV=sqrt(a3V^2+d4V^2);
    XYZ_nom=Tn(1:3,4);
    X_nominalne(1,:)=double(subs(XYZ_nom(1,:),{th1,d1,a1,al1,th2,d2,a2,al2,th3,d3,r,al3},...
        {th1_path+x(1),d1V+x(2),a1V+x(3),-pi/2,th2_path+x(4),0,a2V+x(5),0,th3_path+x(6),0,rV+x(7),pi/2}));
    Y_nominalne(1,:)=double(subs(XYZ_nom(2,:),{th1,d1,a1,al1,th2,d2,a2,al2,th3,d3,r,al3},...
        {th1_path+x(1),d1V+x(2),a1V+x(3),-pi/2,th2_path+x(4),0,a2V+x(5),0,th3_path+x(6),0,rV+x(7),pi/2}));
    Z_nominalne(1,:)=double(subs(XYZ_nom(3,:),{th1,d1,a1,al1,th2,d2,a2,al2,th3,d3,r,al3},...
        {th1_path+x(1),d1V+x(2),a1V+x(3),-pi/2,th2_path+x(4),0,a2V+x(5),0,th3_path+x(6),0,rV+x(7),pi/2}));
    F(:,:)=[X_real(1,:)-X_nominalne(1,:);Y_real(1,:)-Y_nominalne(1,:);Z_real(1,:)-Z_nominalne(1,:)];
end



function Tra=nom_sym()
    syms th1 d1 a1 al1
    syms th2 d2 a2 al2
    syms th3 d3 a3 al3
    syms th4 d4 a4 al4 r
    A1=mA(th1,d1,a1,al1);
    A2=mA(th2,d2,a2,al2);
    A3=mA(th3,d3,r,al3);
    Tra=A1*A2*A3;
end

function [PosX,PosY,PosZ,Tra]=model_cal3R(th1V,th2V,th3V,x1V,x2V,x3V,x4V,x5V,x6V,x7V)
    syms th1 d1 a1 al1
    syms th2 d2 a2 al2
    syms th3 d3 a3 al3 r
    syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12
%     syms th4 d4 a4 al4
    A1=mA(th1+x1,d1+x2,a1+x3,-pi/2);
    A2=mA(th2+x4,0,a2+x5,0);
    A3=mA(th3+x6,0,r+x7,pi/2);
    Tra=A1*A2*A3;
    a1V=100; d1V=300; a2V=500; a3V=200; d4V=300;
    rV=sqrt(a3V^2+d4V^2);
    Tra=subs(Tra,{a1,d1,a2,r},{a1V,d1V,a2V,rV});
    PosX=double(subs(Tra(1,4),{th1,th2,th3,x1,x2,x3,x4,x5,x6,x7},{th1V,th2V,th3V,x1V,x2V,x3V,x4V,x5V,x6V,x7V}));
    PosY=double(subs(Tra(2,4),{th1,th2,th3,x1,x2,x3,x4,x5,x6,x7},{th1V,th2V,th3V,x1V,x2V,x3V,x4V,x5V,x6V,x7V}));
    PosZ=double(subs(Tra(3,4),{th1,th2,th3,x1,x2,x3,x4,x5,x6,x7},{th1V,th2V,th3V,x1V,x2V,x3V,x4V,x5V,x6V,x7V}));    
end

function [th1,th2,th3]=invCalKin(x,y,z,x1V,x2V,x3V,x4V,x5V,x6V,x7V)
    a1=100+x3V; d1=300+x2V; a2=500+x5V;
    r=sqrt(200.^2+300.^2)+x7V;
    alfa=sqrt(x.^2+y.^2);
    th1_1=atan2(y,x)+x1V;
    A=2.*a2.*(-z+d1);
    B=2.*a2.*(a1-alfa);
    D=r^2-(alfa.^2+a1.^2-2.*alfa.*a1+a2.^2+d1^2+z.^2-2.*d1.*z);
%     th2_1=atan2(B,A)-atan2(D,sqrt(A.^2+B.^2-D.^2));
    th2_2=atan2(B,A)-atan2(D,-sqrt(A.^2+B.^2-D.^2))+x4V;
%     th3_1=atan2(d1-sin(th2_1)*a2-z,alfa-a1-cos(th2_1)*a2)-th2_1;
    th3_2=atan2(d1-sin(th2_2)*a2-z,alfa-a1-cos(th2_2)*a2)-th2_2+x6V;
%     th1_1;th2_2;th3_2
    th1=th1_1;
    th2=th2_2;
    th3=th3_2;
end