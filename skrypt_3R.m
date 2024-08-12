clear all;
close all;
clc;

th1=0;
th2=0;
th3=0;
[PosX,PosY,PosZ]=model_nominal3R(th1,th2,th3,1);
%% errors
errorB0=[];
error01=[];
error12=[];
error23=[];
error34=[];
%% model skalibrowany