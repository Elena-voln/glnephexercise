clear all; clc; close all;
format long g

%константы
ae=6378136;         %большая (экваториальная) полуось общеземного эллипсоида
we=0.7292115*10^-4; %earth's rotation rate
%данные из RTKNAVI

x0=10192674.32;
y0=-12367565.43;
z0=19866879.39;
vx=2599.78676;
vy=-789.66141;
vz=-1827.75784;
ax=0.0000019;
ay=0.000009;
az=-0.0000028;
Tau=-38310; %ns
Gamma=0.0018; %ns
%%
%time format
 %2020.02.10 13.45.18           !!!!Проверить!!!!!
 N4=7;
 Nt=41;
 hour=13;
 min=45;
 sec=18;
 h_st=12;   %начало наблюдения, часов
 h_fin=24;  %конец наблюдения, часов
 
TIME=time(N4,Nt,hour,min,sec, h_st,h_fin);
S=TIME(1);
    time_start=TIME(2);
    time_final=TIME(3);
T=TIME(4);
te=TIME(5);
GMST=TIME(6);


%%
%Coordinates transformation to an inertial reference frame:

%Position
xa=x0*cos(S)-y0*sin(S);
ya=x0*sin(S)+y0*cos(S);
za=z0;
%Velocity
vxa=vx*cos(S)-vy*sin(S)-we*ya;
vya=vx*sin(S)+vy*cos(S)+we*xa;
vza=vz;

Jsm_x=ax*cos(S)-ay*sin(S);
Jsm_y=ax*sin(S)+ay*cos(S);
Jsm_z=az;

%%
%веселуха

coordinat=math(xa,ya,za,vxa,vya,vza,Jsm_x,Jsm_y,Jsm_z,time_start,time_final, te,T);

%Строим Землю

[EAR_x,EAR_y,EAR_z] = sphere(20);
EAR_x=ae.*EAR_x;
EAR_y=ae.*EAR_y;
EAR_z=ae.*EAR_z;
%Графики
figure (1)
surf(EAR_x,EAR_y,EAR_z)
hold on
grid on
plot3(coordinat(:,1),coordinat(:,2),coordinat(:,3))
title('Траектория КА в инерциальной СК')
xlabel('x,km')
ylabel('y,km')
zlabel('z,km')

% Для перевода в ПЗ 90.11
ti=coordinat(:,7);
S_pz=GMST+we*(ti-10800);
x_pz=coordinat(:,1).*cos(S_pz)+coordinat(:,2).*sin(S_pz);
y_pz=-coordinat(:,1).*sin(S_pz)+coordinat(:,2).*cos(S_pz);
z_pz=-coordinat(:,3);

vx_pz=coordinat(:,4).*cos(S_pz)+coordinat(:,5).*sin(S_pz)+we*coordinat(:,2);
vy_pz=-coordinat(:,4).*sin(S_pz)+coordinat(:,5).*cos(S_pz)+we*coordinat(:,1);
vz_pz=-coordinat(:,6);
figure (2)
surf(EAR_x,EAR_y,EAR_z)
hold on
grid on
plot3(x_pz,y_pz,z_pz)
title('Траектория КА в СК ПЗ-90')
xlabel('x,km')
ylabel('y,km')
zlabel('z,km')

