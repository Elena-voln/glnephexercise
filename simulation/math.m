function [math ] = math(xa,ya,za,vxa,vya,vza,Jsm_x,Jsm_y,Jsm_z,time_start,time_final, te,T)
%теперь надо раздеаться с временами, т.к. часть вычислений надо сделать на
%более раннее время, а часть на более позднее
%для раннего времени
dt=1;
if(te<=time_start&&te<time_final)
    t=time_start:dt:time_final-dt;
    %result=nan(length(t),6);
    XA=zeros(length(t),1);
    XA(1,:)=xa;
    YA=zeros(length(t),1);
    YA(1,:)=ya;
    ZA=zeros(length(t),1);
    ZA(1,:)=za;
    VXA=zeros(length(t),1);
    VXA(1,:)=vxa;
    VYA=zeros(length(t),1);
    VYA(1,:)=vya;
    VZA=zeros(length(t),1);
    VZA(1,:)=vza;
    result=RungKUTT( t,dt,XA,YA,ZA,VXA,VYA,VZA, T ); 
elseif(te>time_start&&te<time_final)
    t1=te:dt:time_final-dt;
    %result=nan(length(t1),6);
    XA=zeros(length(t1),1);
    XA(1,:)=xa;
    YA=zeros(length(t1),1);
    YA(1,:)=ya;
    ZA=zeros(length(t1),1);
    ZA(1,:)=za;
    VXA=zeros(length(t1),1);
    VXA(1,:)=vxa;
    VYA=zeros(length(t1),1);
    VYA(1,:)=vya;
    VZA=zeros(length(t1),1);
    VZA(1,:)=vza;
    result=RungKUTT( t1,dt,XA,YA,ZA,VXA,VYA,VZA, T ); 
end

[math]=result;
end

