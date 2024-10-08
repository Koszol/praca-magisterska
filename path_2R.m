function [PosX,PosY,PosZ] = path_2R(th1Val,th2Val,errorB0,error01,error12)
    syms th1 th2
    syms errorB0_1 errorB0_2 errorB0_3 errorB0_4 errorB0_5 errorB0_6
    syms error01_1 error01_2 error01_3 error01_4 error01_5 error01_6
    syms error12_1 error12_2 error12_3 error12_4 error12_5 error12_6
    a1=0.5e3; 
    a2=0.4e3;
    %% model
    TB0=mTr(errorB0_1,errorB0_2,errorB0_3,errorB0_4,errorB0_5,errorB0_6);
    T01=mTr(th1+error01_1,error01_2,a1+error01_3,error01_4,error01_5,error01_6);
    T12=mTr(th2+error12_1,error12_2,a2+error12_3,error12_4,error12_5,error12_6);
    T0n=TB0*T01*T12;
%     T0n_results=double(subs(T0n,{th1,th2},{th1_val,th2_val}));
    Results=double(subs(T0n(1:3,4),{th1,th2,errorB0_1,errorB0_2,errorB0_3,errorB0_4,errorB0_5,errorB0_6,...
        error01_1,error01_2,error01_3,error01_4,error01_5,error01_6,...
        error12_1,error12_2,error12_3,error12_4,error12_5,error12_6},...
        {th1Val,th2Val,errorB0(:,1)',errorB0(:,2)',errorB0(:,3)',errorB0(:,4)',errorB0(:,5)',errorB0(:,6)',...
        error01(:,1)',error01(:,2)',error01(:,3)',error01(:,4)',error01(:,5)',error01(:,6)',...
        error12(:,1)',error12(:,2)',error12(:,3)',error12(:,4)',error12(:,5)',error12(:,6)'}));
    PosX=Results(1,:);
    PosY=Results(2,:);
    PosZ=Results(3,:);
end

