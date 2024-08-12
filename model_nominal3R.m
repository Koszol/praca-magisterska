function [PosX,PosY, PosZ] = model_nominal3R(th1Val,th2Val,th3Val,len)
%MODEL2R Summary of this function goes here
%   Detailed explanation goes here
    syms th1 th2 th3
    a1=0.1e3; 
    a2=0.5e3;
    a3=0.2e3;
    d1=0.3e3;
    d4=0.3e3;
    A1=mA(th1,d1,a1,-pi/2);
    A2=mA(th2,0,a2,0);
    A3_1=mA(th3,0,0,0);
    A3_2=mA(pi/2,0,-a3,pi/2);
    A4=mA(0,d4,0,0);
    Tra=A1*A2*A3_1*A3_2*A4;
%     Tra_results=double(subs(Tra,{th1,th2},{th1Val(1:len),th2Val(1:len)}));
    PosX(1:len)=double(subs(Tra(1,4),{th1,th2,th3},{th1Val,th2Val,th3Val}));
    PosY(1:len)=double(subs(Tra(2,4),{th1,th2,th3},{th1Val,th2Val,th3Val}));
    PosZ(1:len)=double(subs(Tra(3,4),{th1,th2,th3},{th1Val,th2Val,th3Val}));
end

