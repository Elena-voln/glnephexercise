clear all; clc; close all;
format long g
%time
%
%���������
% pi=3.14159265359;
% J02=1082625.75*10^-9;  %��������� ������������� ����������� ������ �������
% ae=6378136;         %������� (��������������) ������� ����������� ����������
% GM=398600441.8*10^6;    %� ��������������� ��������� ��������������� ���� ����� 
% J20=1082625.75*10^-9;    %��������� ������������� ����������� ������ �������, ��������������� �������� ������ �����
% we=0.7292115*10^-4;        %earth's rotation rate
%������ �� RTKNAVI
te=0;   %2020.04.11 13.45.18
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
 %2020.02.10 13.45.18           !!!!���������!!!!!
 N4=7;
 Nt=41;
 te=(13+3)*60*60+45*60+18;
 
% ������ � ����� ������� ����������
time_start=(12+3)*60*60; %(+3 UTC)
time_final=(24+3)*60*60;

C1=0;%use after 2119 year
C2=0;%use after 2239 year
JD0=1461*(N4-1)+Nt+2450082.5-(Nt-3)/25+C1+C2; %������� ��������� ���� �� 0 ����� ����� ���
T=(JD0+(te -10800)/86400-2451545.0)/36525;

%������� ������� ������ GMST � ������ (���������� � ���)
JDN=JD0+0.5;
a=JDN+32044;
b=(4*a+3)/146097;
c=a-(146097*b)/4;
d=(4*c+3)/1461;
e=c-(1461*d)/4;
m=(5*e+2)/153;
Day=e-(153*m+2)+1;
Month=m+3-12*(m/10);
Year=100*b+d-4800+m/10;
Tdel=(JD0-2451545.0)/36525;
ERA=2*pi*(0.7790572732640+1.00273781191135448*(JD0-2451545.0));%���� �������� �����, ���
GMST=ERA+0.0000000703270726+0.0223603658710194*Tdel+0.0000067465784654*Tdel^2-0.0000000000021332*Tdel^3-0.0000000001452308*Tdel^4-0.0000000000001784*Tdel^5;   %�������� �������� ����� �� �������� (���) (GST ���)
we=0.7292115*10^-4; %earth's rotation rate
S=GMST+we*(te-10800);  %10800 �� ���
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
%��������

