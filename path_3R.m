function [PosX,PosY,PosZ] = path_3R(th1Val,th2Val,th3Val,errorB0,error01,error12,error23,error34)
    syms th1 th2 th3
    syms errorB0_1 errorB0_2 errorB0_3 errorB0_4 errorB0_5 errorB0_6
    syms error01_1 error01_2 error01_3 error01_4 error01_5 error01_6
    syms error12_1 error12_2 error12_3 error12_4 error12_5 error12_6
    syms error23_1 error23_2 error23_3 error23_4 error23_5 error23_6
    syms error34_1 error34_2 error34_3 error34_4 error34_5 error34_6
    a1=0.1e3; 
    a2=0.5e3;
    a3=0.2e3;
    d1=0.3e3;
    d4=0.3e3;
    TB0=mTr(errorB0_1,errorB0_2,errorB0_3,errorB0_4,errorB0_5,errorB0_6);
    T01=mTr(th1+error01_1,d1+error01_2,a1+error01_3,-pi/2+error01_4,error01_5,error01_6);
    T12=mTr(th2+error12_1,error12_2,a2+error12_3,error12_4,error12_5,error12_6);
    T23=mTr(th3+error23_1,error23_2,error23_3,error23_4,error23_5,error23_6);
    T3_12=mTr(pi/2,0,-a3,pi/2,0,0);
    T34=mTr(error34_1,d4+error34_2,error34_3,error34_4,error34_5,error34_6);
    T0n=TB0*T01*T12*T23*T3_12*T34;
    Results=double(subs(T0n(1:3,4),{th1,th2,th3,errorB0_1,errorB0_2,errorB0_3,errorB0_4,errorB0_5,errorB0_6,...
        error01_1,error01_2,error01_3,error01_4,error01_5,error01_6,...
        error12_1,error12_2,error12_3,error12_4,error12_5,error12_6,...
        error23_1,error23_2,error23_3,error23_4,error23_5,error23_6,...
        error34_1,error34_2,error34_3,error34_4,error34_5,error34_6},...
        {th1Val,th2Val,th3Val,errorB0(:,1)',errorB0(:,2)',errorB0(:,3)',errorB0(:,4)',errorB0(:,5)',errorB0(:,6)',...
        error01(:,1)',error01(:,2)',error01(:,3)',error01(:,4)',error01(:,5)',error01(:,6)',...
        error12(:,1)',error12(:,2)',error12(:,3)',error12(:,4)',error12(:,5)',error12(:,6)',...
        error23(:,1)',error23(:,2)',error23(:,3)',error23(:,4)',error23(:,5)',error23(:,6)',...
        error34(:,1)',error34(:,2)',error34(:,3)',error34(:,4)',error34(:,5)',error34(:,6)'}));
    PosX=Results(1,:);
    PosY=Results(2,:);
    PosZ=Results(3,:);
end
