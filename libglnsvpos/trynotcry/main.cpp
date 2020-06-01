#include <iostream>
#include <vector>
#include <array>
#include <math.h>
//#include <golova.h>
using namespace std;
struct coord
{
    double xa, ya, za,vxa,vya,vza;
};
coord  F(struct coord cor);
void RungKUTT(coord res[], int t, int dt);

int main()
{
    coord after[5];
    int leng_after=5;
    after[0]={6989278.06078926,-13666813.0335678, 19866879.39,3336.90254713637,-870.71023955184,-1827.75784};
    int dt=1;
    RungKUTT(after, leng_after, dt);



    std::cout << after[1].xa<< endl;
}
