function [PosX,PosY,PosZ] = model_cal2R(th1Val,th2Val,len,errorB0,error01,error12)
    syms th1 th2
%     th1_val=th1Val;
%     th2_val=th2Val;
    a1=0.5e3; 
    a2=0.4e3;
    %% model
    TB0=mTr(errorB0(1),errorB0(2),errorB0(3),errorB0(4),errorB0(5),errorB0(6));
    T01=mTr(th1+error01(1),error01(2),a1+error01(3),error01(4),error01(5),error01(6));
    T12=mTr(th2+error12(1),error12(2),a2+error12(3),error12(4),error12(5),error12(6));
    T0n=TB0*T01*T12;
%     T0n_results=double(subs(T0n,{th1,th2},{th1_val,th2_val}));
    PosX(1:len)=double(subs(T0n(1,4),{th1,th2},{th1Val,th2Val}));
    PosY(1:len)=double(subs(T0n(2,4),{th1,th2},{th1Val,th2Val}));
    PosZ(1:len)=double(subs(T0n(3,4),{th1,th2},{th1Val,th2Val}));
end

