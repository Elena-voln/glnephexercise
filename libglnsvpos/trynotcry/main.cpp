#include <iostream>
#include <vector>
#include <array>
#include <math.h>
//#include <golova.h>
const double pi=3.14159265359;
const double we=7.2921151467e-5; //earth's rotation rate

using namespace std;
//обявление всякого
struct coord
{
    double xa, ya, za,vxa,vya,vza;
};



coord  F(struct coord cor);
void RungKUTT(coord res[], int t, int dt);


int main()
{
double S,time_start,time_final,T,te,GMST,ERA,JD0, Tdel;
int N4,Nt,hour,minut,sec, h_st,h_fin ;
//Тут про время
{
N4=7;
 Nt=41;
 hour=13;
 minut=45;
 sec=0;
 h_st=12;  // %начало наблюдения, часов
 h_fin=24;  //%конец наблюдения, часов


te=(hour+3)*60*60+60*minut+sec;//+3UTC
time_start=(h_st+3)*60*60; //(+3 UTC)
time_final=(h_fin+3)*60*60;
JD0=1461*(N4-1)+Nt+2450082.5;//текущая юлианская дата на 0 часов шкалы МДВ
T=(JD0+(te -10800)/86400-2451545.0)/36525;
//расчеты времени всякие GMST и прочее (Приложение Л ИКД)

Tdel=(JD0-2451545.0)/36525;
ERA=2*pi*(0.7790572732640 + 1.00273781191135448*(JD0 - 2451545.0));//%угол поворота Земли, рад
GMST=ERA+0.0000000703270726+0.0223603658710194*Tdel+0.0000067465784654*Tdel*Tdel-0.0000000000021332*Tdel*Tdel*Tdel-0.0000000001452308*Tdel*Tdel*Tdel*Tdel-0.0000000000001784*Tdel*Tdel*Tdel*Tdel*Tdel;  // %истинное звездное время по Гринвичу (рад) (GST ИКД)
S=GMST+we*(te-10800);  //%10800 из ИКД
}

// Тут вводим данные эфемерид, пересчитываем все
{
 double x0, y0,z0,vx,vy,vz,ax,ay,az,Tau,Gamma;
x0=10192674.32;
y0=-12367565.43;
z0=19866879.39;
vx=2599.78676;
vy=-789.66141;
vz=-1827.75784;
ax=0.0000019;
ay=0.000009;
az=-0.0000028;
Tau=-38310; //%ns
Gamma=0.0018; //%ns

// Тут пересчитываем координаты в др.формат

double xa, ya, za, vxa,vya,vza,Jsm_x,Jsm_y,Jsm_z;
xa=x0*cos(S)-y0*sin(S);
ya=xa*sin(S)+y0*cos(S);
za=z0;
//%Velocity
vxa=vx*cos(S)-vy*sin(S)-we*ya;
vya=vx*sin(S)+vy*cos(S)+we*xa;
vza=vz;

Jsm_x=ax*cos(S)-ay*sin(S);
Jsm_y=ax*sin(S)+ay*cos(S);
Jsm_z=az;

}

    coord after[5];
    int leng_after=5;
    after[0]={6989278.06078926,-13666813.0335678, 19866879.39,3336.90254713637,-870.71023955184,-1827.75784};
    int dt=-1;
    RungKUTT(after, leng_after, dt);



    std::cout <<"after[0].vxa   "  << after[0].vxa <<"\n";
    std::cout <<"after[1].vxa   "  << after[1].vxa <<"\n";
    std::cout <<"after[2].vxa   "  << after[2].vxa <<"\n";
    std::cout <<"after[3].vxa   "  << after[3].vxa <<"\n";
}
