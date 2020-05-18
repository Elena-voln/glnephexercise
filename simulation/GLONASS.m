clear; close all; clc;
 format long g

%���������
ae=6378136;         %������� (��������������) ������� ����������� ����������
we=7.2921151467e-5; %earth's rotation rate
pi=3.14159265359;

%������ �� RTKNAVI

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
% x0 = 10584969.2383; % ���������� � � ������� ��_90 [m]
% y0 = 2721713.86719; % ���������� Y � ������� ��_90 [m]
% z0 = 23027096.6797; % ���������� Z � ������� ��_90 [m]
% vx = -788.876533508; % �������� �� � � ������� ��_90 [m/s]
% vy = 3058.68911743; % �������� �� Y � ������� ��_90 [m/s]
% vz = 1.50871276855; % �������� �� Z � ������� ��_90 [m/s]
% ax = 0; % ��������� �� � � ������� ��_90 [m/s^2]
% ay = 0; % ��������� �� Y � ������� ��_90 [m/s^2]
% az = -372.529029846e-9; % ��������� �� Z � ������� ��_90 [m/s^2]
%%
%time format
 %2020.02.10 13.45.18           !!!!���������!!!!!
 N4=7;
 Nt=41;
 hour=13;
 min=45;
 sec=0;
 h_st=12;   %������ ����������, �����
 h_fin=24;  %����� ����������, �����
 
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
ya=xa*sin(S)+y0*cos(S);
za=z0;
%Velocity
vxa=vx*cos(S)-vy*sin(S)-we*ya;
vya=vx*sin(S)+vy*cos(S)+we*xa;
vza=vz;

Jsm_x=ax*cos(S)-ay*sin(S);
Jsm_y=ax*sin(S)+ay*cos(S);
Jsm_z=az;

%%
%��������

coordinat=math_2(xa,ya,za,vxa,vya,vza,Jsm_x,Jsm_y,Jsm_z,time_start,time_final, te,T);

%������ �����

[EAR_x,EAR_y,EAR_z] = sphere(20);
EAR_x=ae.*EAR_x;
EAR_y=ae.*EAR_y;
EAR_z=ae.*EAR_z;
%�������
figure (1)
surf(EAR_x,EAR_y,EAR_z)
hold on
grid on
plot3(coordinat(:,1),coordinat(:,2),coordinat(:,3))
title('���������� �� � ������������ ��')
xlabel('x,km')
ylabel('y,km')
zlabel('z,km')

% ��� �������� � �� 90.11
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
title('���������� �� � �� ��-90')
xlabel('x,km')
ylabel('y,km')
zlabel('z,km')


%%
%������ � SkyView

PZ90=[x_pz;y_pz;z_pz];
a=[1 -0.9696*10^-6 0;-0.9696*10^-6 1 0; 0 0 1];
b=[-1.10;-0.30;-0.90];

for i=1: length(x_pz)
    WGS84_x(i)=(1-0.12*10^-6)*(x_pz(i)*1+y_pz(i)*-0.9696*10^-6+z_pz(i)*0)+b(1);
     WGS84_y(i)=(1-0.12*10^-6)*(x_pz(i)*-0.9696*10^-6+y_pz(i)*1+z_pz(i)*0)+b(2);
      WGS84_z(i)=(1-0.12*10^-6)*(x_pz(i)*0+y_pz(i)*0+z_pz(i)*1)+b(3);
     
end
figure (3)
surf(EAR_x,EAR_y,EAR_z)
hold on
grid on
plot3(WGS84_x,WGS84_y,WGS84_z)
title('���������� �� � �� WGS84')
xlabel('x,km')
ylabel('y,km')
zlabel('z,km')

% %���������� �������� ���
% %55.756610, 37.703544
% Lat_MPEI=55.756610;
% Long_MPEI=37.703544;
% H_MPEI=150;
% for i=length(coordinat(:,1))
%     %�������� � �� ��������� � ���
%      [x(i) y(i) z(i)] = ecef2enu(WGS84_x(i),WGS84_y(i),WGS84_z(i),Lat_MPEI,Long_MPEI,H_MPEI,wgs84Ellipsoid,'radians');
%      %������� � �����������  ��
%      [TET(i),phi(i),r(i)]=cart2sph(x(i),y(i),z(i));
% %      r(i)=sqrt(x(i)^2+y(i)^2+z(i)^2);
% %      TET(i)=acos(z(i)/r(i));
% %      phi(i)=atan2(y(i),z(i));
%      
% end
% 
% figure(4);
% polar(phi,(TET*180-pi)/pi,'r')
% title('SkyVeiw ')
% 
N_gr = 55;
N_min = 45;
N_sec = 23.6675;
E_gr = 37;
E_min = 42;
E_sec = 12.3895;
H = 150;% ������ � ������
N = N_gr*pi/180 + N_min/3437.747 + N_sec/206264.8; % ������ � ��������
E = E_gr*pi/180 + E_min/3437.747 + E_sec/206264.8; % ������� � ��������
llh = [N E H];
%PRM_coor = llh2xyz(llh)';

coor=[N;E;H];
for i=1:length(WGS84_x)
    [x(i) y(i) z(i)] = ecef2enu(WGS84_x(i),WGS84_y(i),WGS84_z(i),N,E,H,wgs84Ellipsoid,'radians');
    if z(i) > 0
     teta(i) = atan2(sqrt(x(i)^2 + y(i)^2),z(i));
     r(i) = sqrt(x(i)^2 + y(i)^2 + z(i)^2);
     phi(i) = atan2(y(i),x(i));
     else teta(i) = NaN;
     r(i) = NaN;
     phi(i) = NaN;
    end
end

figure(4);
polar(phi,(teta*180-pi)/pi,'r')
title('SkyVeiw ')
