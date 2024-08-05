function [dT]=mTr(th,z,x,alfa,y,fi)
%%
% digits(6);
% T=[cos(th)*cos(beta)-sin(th)*sin(alfa)*sin(beta),   -sin(th)*cos(alfa), cos(th)*sin(beta)+sin(th)*sin(alfa)*cos(beta),  a*cos(th);
%     sin(th)*cos(beta)+cos(th)*sin(alfa)*sin(beta),  cos(th)*cos(alfa),  sin(th)*sin(beta)-cos(th)*sin(alfa)*cos(beta),  a*sin(th);
%     -cos(alfa)*sin(beta),   sin(alfa),  cos(alfa)*cos(beta),    d;
%     0,0,0,1];
% pochodne
A1=trax(x);
A2=tray(y);
A3=traz(z);
A4=rotz(th);
A5=roty(fi);
A6=rotx(alfa);
dT=A4*A3*A1*A6*A2*A5;
end