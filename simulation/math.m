function [math ] = math(xa,ya,za,vxa,vya,vza,Jsm_x,Jsm_y,Jsm_z,time_start,time_final, te,T)
%теперь надо раздеаться с временами, т.к. часть вычислений надо сделать на
%более раннее время, а часть на более позднее
%для раннего времени
dt=1;
if(te<=time_start&&te<time_final)
    t=time_start:dt:time_final-dt;
    result=nan(length(t),6);
    result(1,:)=[xa,ya,za,vxa,vya,vza];
    
    result=RungKUTT( t, result, T ); 
    ti=t;
elseif(te>time_start&&te<time_final)
    t1=te:dt:(time_final-dt);
    ti=t1;
    result=nan(length(t1),6);
    result(1,:)=[xa,ya,za,vxa,vya,vza];
    
    result=RungKUTT( t1,result, T ); 
%     %
%     t2=te:-dt:(time_start);
%     ti=t2;
%     result=nan(length(t2),7);
%     XA2=zeros(length(t2),1);
%     XA2(1,:)=xa;
%     YA2=zeros(length(t2),1);
%     YA2(1,:)=ya;
%     ZA2=zeros(length(t2),1);
%     ZA2(1,:)=za;
%     VXA2=zeros(length(t2),1);
%     VXA2(1,:)=vxa;
%     VYA2=zeros(length(t2),1);
%     VYA2(1,:)=vya;
%     VZA2=zeros(length(t2),1);
%     VZA2(1,:)=vza;
%     result=RungKUTT( t2,dt,XA2,YA2,ZA2,VXA2,VYA2,VZA2, T ); 
% %     %result2=[rot90(rot90(result2(:,1))); ...
% %                        rot90(rot90(result2(:,2))); ...
% %                        rot90(rot90(result2(:,3))); ...
% %                        rot90(rot90(result2(:,4))); ...
% %                        rot90(rot90(result2(:,5))); ...
% %                        rot90(rot90(result2(:,6)))];
% %                    size(result2)
% %                     size(result1(2:end,:))
    % result=[result2; result1(2:end,:)] ;             
elseif (te>=time_start&&te>time_final)
  t=te:-dt:time_final-dt;
    result=nan(length(t),6);
    result(1,:)=[xa,ya,za,vxa,vya,vza]
    result=RungKUTT( t,result, T ); 
    ti=t;
    elseif (te>=time_start&&te>time_final)
  t1=te:-dt:time_final-dt;
   result=nan(length(t),6);
    result(1,:)=[xa,ya,za,vxa,vya,vza]
    result=RungKUTT( t1,result, T ); 
    ti=t1;
end
%%поправка на небесные тела
tu=ti-te;
for i=1:length(tu   )
    tau(i,:)=tu(i);
    tpz(i,:)=ti(i);
end
NEB_TEL=sun_moon(T, xa,ya,za,vxa,vya,vza);

dx=(NEB_TEL(1)+(4))*0.5*tau.^2;
dy=(NEB_TEL(2)+(5))*0.5*tau.^2;
dz=(NEB_TEL(3)+(6))*0.5*tau.^2;

dvx=(NEB_TEL(1)+(4))*tau;
dvy=(NEB_TEL(2)+(5))*tau;
dvz=(NEB_TEL(3)+(6))*tau;

% 
% result(:,1)=result(:,1)+dvx;
% result(:,2)=result(:,2)+dvy;
% result(:,3)=result(:,3)+dvz;
% 
% result(:,4)=result(:,4)+dvx;
% result(:,5)=result(:,5)+dvy;
% result(:,6)=result(:,6)+dvz;
size(result)
size(tpz)
[math]=[result tpz];
end

