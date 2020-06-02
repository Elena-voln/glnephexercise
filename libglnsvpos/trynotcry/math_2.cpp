#include <iostream>
#include <vector>
#include <array>
#include <math.h>

struct coord
{
    double xa, ya, za,vxa,vya,vza;
};
coord  F(struct coord cor, double xa ,double ya,double za,double vxa,double vya,double vza);
void RungKUTT(coord res[], double t, double dt);

void math_2(coord result[],int delt, int time_start,int time_final,int te,
            double xa, double ya,double za,double vxa, double vya, double vza, double Jsm_x, double Jsm_y,double Jsm_z)

{
    int long_bef, long_aft;
    long_bef=te-time_start;
    long_aft=time_final-te;
    coord after[long_aft];
    coord bef[long_bef];

    after[0]={xa,ya, za,vxa,vya,vza};
    double dt=1;
    RungKUTT(after, long_aft, dt);
    bef[0]={xa,ya, za,vxa,vya,vza};
     dt=-1;
    RungKUTT(bef, long_bef, dt);

for(int i=0; i<delt;i++)
{
    if(i<long_bef)

    result[i]=bef[long_bef-i-1];
    else
    result[i]=after[i-long_bef];
}

double ti=time_start;
double dx,dy,dz,dvx,dvy,dvz,tau;
for(int i=0; i<delt;i++)
{
    tau=ti-te;
    dx=Jsm_x*0.5*tau*tau;
    dy=Jsm_y*0.5*tau*tau;
    dz=Jsm_z*0.5*tau*tau;

    dvx=Jsm_x*tau;
    dvy=Jsm_y*tau;
    dvz=Jsm_z*tau;

    result[i]={result[i].xa+dx,result[i].ya+dy,-(result[i].za+dz),result[i].vxa+dvx,result[i].vya+dvy,result[i].vza+dvz };
    ti=ti+1;
}


}


// простой пример
/*
    coord after[5];
    int leng_after=5;
    after[0]={6989278.06078926,-13666813.0335678, 19866879.39,3336.90254713637,-870.71023955184,-1827.75784};
    double dt=1;
    RungKUTT(after, leng_after, dt);

*/

