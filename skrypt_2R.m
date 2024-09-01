clear all;
close all;
clc;

th1=0;
th2=0;
[PosX,PosY,PosZ]=model_nominal2R(th1,th2,1);
%% errors
% przypadek 1
errorB0=[deg2rad(-0.466),0,0.4641,deg2rad(0),0.0143,0];  % dth dz dx dalfa dy dfi  
error01=[deg2rad(0.0549),0,0.851,deg2rad(0),0,0];
error12=[deg2rad(-0.8206),0,0.7131,deg2rad(0),0,0];
% przypadek 2
% errorB0=[deg2rad(0),0,0,deg2rad(0),0,0];  % dth dz dx dalfa dy dfi  
% error01=[deg2rad(0.042),0,0,deg2rad(0),0,0];
% error12=[deg2rad(1.186),0,0,deg2rad(0),0,0];
% przypadek 3
% errorB0=[deg2rad(0.105),0,0.12,deg2rad(0),0,0];  % dth dz dx dalfa dy dfi  
% error01=[deg2rad(-0.156),0,-0.729,deg2rad(0),0,0];
% error12=[deg2rad(-1.192),0,0.229,deg2rad(0),0,0];
%% model skalibrowany
[PosrealX,PosrealY,PosrealZ]=model_real2R(th1,th2,1,errorB0,error01,error12);
delta_x=PosrealX-PosX;
delta_y=PosrealY-PosY;
delta_z=PosrealZ-PosZ;
Distance=sqrt(delta_x.^2+delta_y.^2+delta_z.^2)
%% ścieżka testowa
load("traj2R.mat")
th1_path=traj(1,:);
th2_path=traj(2,:);
PathSize=length(th1_path);
[PathX(1:PathSize),PathY(1:PathSize),PathZ(1:PathSize)]=model_nominal2R(th1_path,th2_path,PathSize);
[PathrealX(1:PathSize),PathrealY(1:PathSize),PathrealZ(1:PathSize)]=model_real2R(th1_path,th2_path,PathSize,errorB0,error01,error12);
%% normally distributed random errors 
% dth dz dx dalfa dy dfi
std1=0.03;
std2=0.005;
% std.*randn(1,PathSize)+mean

for i=1:10
    tic
    % przypadek 1
    errorB0_rand=[deg2rad(randVal(-0.466,std1,PathSize)),zeros(PathSize,1),randVal(0.4641,0.03,PathSize),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
    error01_rand=[deg2rad(randVal(0.0549,std2,PathSize)),zeros(PathSize,1),randVal(0.851,0.03,PathSize),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
    error12_rand=[deg2rad(randVal(-0.8206,std1,PathSize)),zeros(PathSize,1),randVal(0.7131,0.03,PathSize),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),];
    % przypadek 2
%     errorB0_rand=[zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
%     error01_rand=[deg2rad(randVal(0.042,std2,PathSize)),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
%     error12_rand=[deg2rad(randVal(1.186,std1,PathSize)),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1),];
%     przypadek 3
%     errorB0_rand=[deg2rad(randVal(0.105,std1,PathSize)),zeros(PathSize,1),randVal(0.12,std1,PathSize),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
%     error01_rand=[deg2rad(randVal(-0.156,std1,PathSize)),zeros(PathSize,1),randVal(-0.729,std1,PathSize),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
%     error12_rand=[deg2rad(randVal(-1.192,std1,PathSize)),zeros(PathSize,1),randVal(0.229,std1,PathSize),zeros(PathSize,1),zeros(PathSize,1),zeros(PathSize,1)];
    [PathRealX(i,:),PathRealY(i,:),PathRealZ(i,:)]=path_2R(th1_path,th2_path,errorB0_rand,error01_rand,error12_rand);
    delta_nominal=[PathRealX(i,:)-PathX;PathRealY(i,:)-PathY;PathRealZ(i,:)-PathZ];
    error_nominal(i,1:PathSize)=sqrt(delta_nominal(1,:).^2+delta_nominal(2,:).^2+delta_nominal(3,:).^2);
    delta_real=[PathRealX(i,:)-PathrealX;PathRealY(i,:)-PathrealY;PathRealZ(i,:)-PathrealZ];
    error_real(i,1:PathSize)=sqrt(delta_real(1,:).^2+delta_real(2,:).^2+delta_real(3,:).^2);    
    toc   
end

%% check
error_nominal_mean(1,1:PathSize)=mean(error_nominal(:,1:PathSize));
error_real_mean(1,1:PathSize)=mean(error_real(:,1:PathSize));
j=1;
x_errorbar=1:1:PathSize;
for i=x_errorbar
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
    real_std(i)=std(error_real(:,i));
    real_mean=error_real_mean(i);
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
save("RealVal.mat","X_real","Y_real","Z_real");
x0=[0,0,0,0,0,0];   %th1 a1 th2 a2 th0 a0
parametr=lsqnonlin(@myfun,x0);
x1=parametr(1);
x2=parametr(2);
x3=parametr(3);
x4=parametr(4);     % this shit is good i think
% x01=parametr(5);
% x02=parametr(6);
[CalX,CalY,CalZ,Tn]=model_cal2R(th1_path,th2_path,500,400,x1,x2,x3,x4);
[th1_c,th2_c]=invCalKin(CalX,CalY,x1,x2,x3,x4);
[PathCalX,PathCalY,PathCalZ]=model_real2R(th1_c,th2_c,PathSize,errorB0,error01,error12);
% plot(PathCalX,PathCalY)
% delta_cal=[PathCalX-PathrealX;PathCalY-PathrealY];
% error_cal(1,:)=sqrt(delta_cal(1,:).^2+delta_cal(2,:).^2)
for i=1:10
    delta_cal=[PathRealX(i,:)-PathCalX;PathRealY(i,:)-PathCalY;PathRealZ(i,:)-PathCalZ];
    error_cal(i,1:PathSize)=sqrt(delta_cal(1,:).^2+delta_cal(2,:).^2+delta_cal(3,:).^2);
end
%%
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
% figure
% plot(rad2deg(th2_c))
% hold on
% plot(rad2deg(th2_path))
figure
plot(PathX,PathY)
hold on
plot(PathrealX,PathrealY)
plot(PathCalX,PathCalY)
legend('nominal','real','calibration')
%% wykresy
figure
errorbar(x_errorbar,error_nominal_mean,nom_errorbar)
hold on
errorbar(x_errorbar,error_real_mean,real_errorbar)
errorbar(x_errorbar,error_cal_mean,cal_errorbar)
title("Odległość od rzeczywistego położenia robota")
legend('Model nominalny','Model skalibrowany')
xlabel("Numer próbki")
ylabel("Odległość [mm]")
grid on
axis tight
sr_blad_nominal=mean(error_nominal_mean)
sr_odch_stand_nominal=mean(nom_std)
sr_blad_real=mean(error_real_mean)
sr_odch_stand_real=mean(real_std)


function F=myfun(x)
    load("traj2R.mat")
    load("RealVal.mat")
    th1_path=traj(1,:);
    th2_path=traj(2,:);
    Tn=nom_sym;
    syms th1 a1 
    syms th2 a2
%     syms th0 a0
    XYZ_nom=Tn(1:3,4);
    X_nominalne(1,:)=double(subs(XYZ_nom(1,1),{th1,a1,th2,a2},{th1_path+x(1),500+x(2),th2_path+x(3),400+x(4)}));
    Y_nominalne(1,:)=double(subs(XYZ_nom(2,1),{th1,a1,th2,a2},{th1_path+x(1),500+x(2),th2_path+x(3),400+x(4)}));
    Z_nominalne(1,:)=double(subs(XYZ_nom(3,1),{th1,a1,th2,a2},{th1_path+x(1),500+x(2),th2_path+x(3),400+x(4)}));
    F(:,:)=[X_real(1,:)-X_nominalne(1,:);Y_real(1,:)-Y_nominalne(1,:);Z_real(1,:)-Z_nominalne(1,:)];
end

function [PosX,PosY,PosZ,Tra]=model_cal2R(th1V,th2V,a1V,a2V,x1V,x2V,x3V,x4V)
    syms th1 th2 a1 a2 x1 x2 x3 x4 x01 x02
%     A0=mA(x01,0,x02,0);
    A1=mA(th1+x1,0,a1+x2,0);
    A2=mA(th2+x3,0,a2+x4,0);
    Tra=A1*A2;
    PosX=double(subs(Tra(1,4),{th1,th2,a1,a2,x1,x2,x3,x4},{th1V,th2V,a1V,a2V,x1V,x2V,x3V,x4V}));
    PosY=double(subs(Tra(2,4),{th1,th2,a1,a2,x1,x2,x3,x4},{th1V,th2V,a1V,a2V,x1V,x2V,x3V,x4V}));
    PosZ=double(subs(Tra(3,4),{th1,th2,a1,a2,x1,x2,x3,x4},{th1V,th2V,a1V,a2V,x1V,x2V,x3V,x4V}));
end

function [th1,th2]=invCalKin(x,y,x1,x2,x3,x4)
    l1=500+x2;
    l2=400+x4;
    licz1=l2.^2-l1.^2-x.^2-y.^2;
    mian1=4*l1.^2*(x.^2+y.^2)-(l2.^2-l1.^2-x.^2-y.^2).^2;
    th1_1=atan2(-x,y)-atan2(licz1,sqrt(mian1))-x1;
    th1_2=atan2(-x,y)-atan2(licz1,-sqrt(mian1))-x1;
    th2_1=atan2(y-l1*sin(th1_1),x-l1*cos(th1_1))-th1_1-x3;
    th2_2=atan2(y-l1*sin(th1_2),x-l1*cos(th1_2))-th1_2-x3;
    th1_1=unwrap(th1_1);
    th1_2=unwrap(th1_2);
    th2_1=unwrap(th2_1);
    th2_2=unwrap(th2_2);
    th1=th1_2;
    th2=th2_2;
end

function Tra = nom_sym()
    syms th1 th2 a1 a2 th0 a0
%     A0=mA(th0,0,a0,0);
    A1=mA(th1,0,a1,0);
    A2=mA(th2,0,a2,0);
    Tra=A1*A2;
end
