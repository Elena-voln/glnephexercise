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

void math_2(coord result[], int time_start,int time_final,int te,
            double xa, double ya,double za,double vxa, double vya, double vza, double Jsm_x, double Jsm_y,double Jsm_z)

{
    int long_bef, long_aft;
    long_bef=te-time_start;
    long_aft=time_final-te;
    coord after[6300];
    coord bef[32];
    std::cout <<"after[0].vxa   "  << after[0].vxa <<"\n";
    std::cout <<"after[1].vxa   "  << after[1].vxa <<"\n";
    std::cout <<"after[2].vxa   "  << after[2].vxa <<"\n";
    std::cout <<"after[3].vxa   "  << after[3].vxa <<"\n";

/*
    after[0]={xa,ya, za,vxa,vya,vza};
    //bef[0]={xa,ya, za,vxa,vya,vza};
    double dt_aft=1;
    RungKUTT(after, long_aft, dt_aft);
    //double dt_bef=-1;
    RungKUTT(bef, long_bef, dt_bef);

    */
    //coord after[5];
    int leng_after=6300;
    after[0]={xa,ya, za,vxa,vya,vza};
    double dt=1;
    RungKUTT(after, leng_after, dt);

    std::cout <<"after[0].vxa   "  << after[0].vxa <<"\n";
    std::cout <<"after[1].vxa   "  << after[1].vxa <<"\n";
    std::cout <<"after[2].vxa   "  << after[2].vxa <<"\n";
    std::cout <<"after[3].vxa   "  << after[3].vxa <<"\n";
 int TE=te;

for (int i=0; i<6300;i++)
{/*
    if(i<32)
    result[i]=bef[TE-i];    //типа инвертируем пакет

    else
        */
    result[i]=after[i];
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

