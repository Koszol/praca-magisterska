function [PosX,PosY,PosZ] = path_2R(th1Val,th2Val,len,errorB0,error01,error12)
    syms th1 th2
    syms errorB0_1 errorB0_2 errorB0_3 errorB0_4 errorB0_5 errorB0_6
    a1=0.5e3; 
    a2=0.4e3;
    %% model
    TB0=mTr(errorB0_1,errorB0_2,errorB0_3,errorB0_4,errorB0_5,errorB0_6);
    T01=mTr(th1,0,a1,0,0,0);
    T12=mTr(th2,0,a2,0,0,0);
    T0n=TB0*T01*T12;
%     T0n_results=double(subs(T0n,{th1,th2},{th1_val,th2_val}));
    PosX=double(subs(T0n(1,4),{th1,th2,errorB0_1,errorB0_2,errorB0_3,errorB0_4,errorB0_5,errorB0_6},{th1Val,th2Val,errorB0(:,1)',errorB0(:,2)',errorB0(:,3)',errorB0(:,4)',errorB0(:,5)',errorB0(:,6)'}));
    PosY=double(subs(T0n(2,4),{th1,th2,errorB0_1,errorB0_2,errorB0_3,errorB0_4,errorB0_5,errorB0_6},{th1Val,th2Val,errorB0(:,1)',errorB0(:,2)',errorB0(:,3)',errorB0(:,4)',errorB0(:,5)',errorB0(:,6)'}));
    PosZ=double(subs(T0n(3,4),{th1,th2,errorB0_1,errorB0_2,errorB0_3,errorB0_4,errorB0_5,errorB0_6},{th1Val,th2Val,errorB0(:,1)',errorB0(:,2)',errorB0(:,3)',errorB0(:,4)',errorB0(:,5)',errorB0(:,6)'}));
end

