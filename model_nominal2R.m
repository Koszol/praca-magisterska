function [PosX,PosY, PosZ] = model_nominal2R(th1Val,th2Val,len)
%MODEL2R Summary of this function goes here
%   Detailed explanation goes here
    syms th1 th2
    a1=0.5e3; 
    a2=0.4e3;
    A1=mA(th1,0,a1,0);
    A2=mA(th2,0,a2,0);
    Tra=A1*A2;
%     Tra_results=double(subs(Tra,{th1,th2},{th1Val(1:len),th2Val(1:len)}));
    PosX(1:len)=double(subs(Tra(1,4),{th1,th2},{th1Val,th2Val}));
    PosY(1:len)=double(subs(Tra(2,4),{th1,th2},{th1Val,th2Val}));
    PosZ(1:len)=double(subs(Tra(3,4),{th1,th2},{th1Val,th2Val}));
end

