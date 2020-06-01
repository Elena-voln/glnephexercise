#include <math.h>
#include <iostream>
#include <stdio.h>


using namespace std;
//константы
const double J02=1082625.75e-9;
const double GM=398600441.8e6;
const double ae=6378136;

struct coord
{
    double xa, ya, za,vxa,vya,vza;
};

coord  F(struct coord cor)
{
double xa=cor.xa;
double ya=cor.ya;
double za=cor.za;
double vxa=cor.vxa;
double vya=cor.vya;
double vza=cor.vza;



double r, GMrat, xarat, yarat, zarat, ro, Vxa, Vya, Vza ;
r=sqrt(pow(xa,2)+pow(ya,2)+pow(za,2));
GMrat=GM/(pow(r,2));
xarat=xa/r;
yarat=ya/r;
zarat=za/r;
ro=ae/r;

Vxa=-GMrat*xarat-(3/2)*J02*GMrat*xarat*(pow(ro,2))*(1-5*pow(zarat,2));//  %+Jxas+Jxam;
Vya=-GMrat*yarat-(3/2)*J02*GMrat*yarat*(pow(ro,2))*(1-5*pow(zarat,2));//%+Jyas+Jyam;
Vza=-GMrat*zarat-(3/2)*J02*GMrat*zarat*(pow(ro,2))*(3-5*pow(zarat,2));//%+Jzas+Jzam;
cor.xa=vxa;
cor.ya=vya;
cor.za=vza;
cor.vxa=Vxa;
cor.vya=Vya;
cor.vza=Vza;
return cor;
}
/*
function [ F ] = F( inp)

J02=1082625.75e-9;  %зональный гармонический коэффициент второй степени
GM=398600441.8e6;    %Ц геоцентрическа€ константа гравитационного пол€ «емли
ae=6378136;         %больша€ (экваториальна€) полуось общеземного эллипсоида

xa=inp(1);
ya=inp(2);
za=inp(3);
vxa=inp(4);
vya=inp(5);
vza=inp(6);

r=sqrt(xa^2+ya^2+za^2);
GMrat=GM/(r^2);
xarat=xa/r;
yarat=ya/r;
zarat=za/r;
ro=ae/r;


%вот это надо интегрировать –унге  утты 4 пор€дка
dxadt=vxa;
dyadt=vya;
dzadt=vza;
dvxadt=-GMrat*xarat-(3/2)*J02*GMrat*xarat*(ro^2)*(1-5*zarat^2);  %+Jxas+Jxam;
dvyadt=-GMrat*yarat-(3/2)*J02*GMrat*yarat*(ro^2)*(1-5*zarat^2);%+Jyas+Jyam;
dvzadt=-GMrat*zarat-(3/2)*J02*GMrat*zarat*(ro^2)*(3-5*zarat^2);%+Jzas+Jzam;
[F]=[dxadt,dyadt,dzadt,dvxadt,dvyadt,dvzadt];
end
*/


