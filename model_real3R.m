function [PosX,PosY,PosZ] = model_real3R(th1Val,th2Val,th3Val,len,errorB0,error01,error12,error23)
    syms th1 th2 th3
%     th1_val=th1Val;
%     th2_val=th2Val;
    a1=0.1e3; 
    a2=0.5e3;
    a3=0.2e3;
    d1=0.3e3;
    d4=0.3e3;
    r=sqrt(a3.^2+d4.^2);
    %% model
    TB0=mTr(errorB0(1),errorB0(2),errorB0(3),errorB0(4),errorB0(5),errorB0(6));
    T01=mTr(th1+error01(1),d1+error01(2),a1+error01(3),-pi/2+error01(4),error01(5),error01(6));
    T12=mTr(th2+error12(1),error12(2),a2+error12(3),error12(4),error12(5),error12(6));
    T23=mTr(th3+error23(1),error23(2),r+error23(3),pi/2+error23(4),error23(5),error23(6));
%     T34=mTr(pi/2,0,-a3,pi/2,0,0);
%     T34=mTr(error34(1),d4+error34(2),error34(3),error34(4),error34(5),error34(6));
    T0n=TB0*T01*T12*T23;
%     T0n_results=double(subs(T0n,{th1,th2},{th1_val,th2_val}));
    PosX(1:len)=double(subs(T0n(1,4),{th1,th2,th3},{th1Val,th2Val,th3Val}));
    PosY(1:len)=double(subs(T0n(2,4),{th1,th2,th3},{th1Val,th2Val,th3Val}));
    PosZ(1:len)=double(subs(T0n(3,4),{th1,th2,th3},{th1Val,th2Val,th3Val}));
end

