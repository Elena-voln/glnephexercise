function [RungKUTT ] = RungKUTT( t,dt,xa,ya,za,vxa,vya,vza, T, )
for i=1:lenght(t)
    inp=[ xa,ya,za,vxa,vya,vza];
    
 
    K0=F(inp,const);
    
    K1=F(inp+0.5*dt.*K1, T);
    
    K2=F(inp+0.5*dt.*K2, T);
    
    K3=F(inp+dt.*K3, T);
    
    inp(i+1)=inp(i)+(dt/6)*(K0+2*K1+2*K2+K3);
    
end
[RungKUTT]=inp;
end

