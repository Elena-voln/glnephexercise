#include <math.h>
#include <iostream>
#include <iostream>
#include <vector>
#include <array>
#include <math.h>

struct coord
{
    double xa, ya, za,vxa,vya,vza;
};

coord  F(struct coord cor);

//t- длина всего безобразия. dt- шаг. tst- начальное время для интегрирования
void RungKUTT(coord res[], int t, int dt)
{

coord K0;
coord K1;
coord K2;
coord K3;
coord ink1, ink2, ink3, ink;
coord cyk;


for (int i=0; i<t; i++)
{
    cyk=res[i];
    K0=F(cyk);
    ink1={cyk.xa+0.5*dt*K0.xa,cyk.ya+0.5*dt*K0.ya,cyk.za+0.5*dt*K0.za,cyk.vxa+0.5*dt*K0.vxa,cyk.vya+0.5*dt*K0.vya,cyk.vza+0.5*dt*K0.vza};       //(result(i,:)+0.5*dt.*K0));
    K1=F(ink1);
    ink2={cyk.xa+0.5*dt*K1.xa,cyk.ya+0.5*dt*K1.ya,cyk.za+0.5*dt*K1.za,cyk.vxa+0.5*dt*K1.vxa,cyk.vya+0.5*dt*K1.vya,cyk.vza+0.5*dt*K1.vza};
    K2=F(ink2);
    ink3={(cyk.xa+dt*K2.xa),(cyk.ya+dt*K2.ya),(cyk.za+dt*K2.za),(cyk.vxa+dt*K2.vxa),(cyk.vya+dt*K2.vya),(cyk.vza+dt*K2.vza)};
    K3=F(ink3);
    ink={cyk.xa+(dt/6)*(K0.xa+2*K1.xa+2*K2.xa+K3.xa),cyk.ya+(dt/6)*(K0.ya+2*K1.ya+2*K2.ya+K3.ya),cyk.za+(dt/6)*(K0.za+2*K1.za+2*K2.za+K3.za),cyk.vxa+(dt/6)*(K0.vxa+2*K1.vxa+2*K2.vxa+K3.vxa),cyk.vya+(dt/6)*(K0.vya+2*K1.vya+2*K2.vya+K3.vya),cyk.vza+(dt/6)*(K0.vza+2*K1.vza+2*K2.vza+K3.vza)};
    //result(i+1,:)=result(i,:)+(dt/6)*(K0+2*K1+2*K2+K3);
res[i+1]=ink;
/*
std::cout <<"i    "<< i <<"\n";
std::cout <<"ink1    "<< ink1.vxa <<"\n";
std::cout <<"cyk    "<< cyk.vxa <<"\n";
std::cout <<"res[i]    "<< res[i].vxa <<"\n";
std::cout <<"res[i-1]    "<< res[i-1].vxa <<"\n";
*/
}

}
/*
function [RungKUTT ] = RungKUTT( t, result, dt)


for i=1:length(t)-1


    K0=F(result(i,:));


    K1=F((result(i,:)+0.5*dt.*K0));

    K2=F(result(i,:)+0.5*dt.*K1);

    K3=F(result(i,:)+dt.*K2);

    result(i+1,:)=result(i,:)+(dt/6)*(K0+2*K1+2*K2+K3);

end
[RungKUTT]=result;
end
*/


