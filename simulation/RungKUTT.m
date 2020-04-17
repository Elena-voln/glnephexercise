function [RungKUTT ] = RungKUTT( t,dt,xa,ya,za,vxa,vya,vza, T )
 inp=[ xa,ya,za,vxa,vya,vza];
for i=1:length(t)-1
    
  %  inp=[ xa,ya,za,vxa,vya,vza];
    
 
    K0=F(inp(i,:),T);
  
    
    K1=F((inp(i,:)+0.5*dt.*K0), T);
    
    K2=F(inp(i,:)+0.5*dt.*K1, T);
    
    K3=F(inp(i,:)+dt.*K2, T);
    
    inp(i+1,:)=inp(i,:)+(dt/6)*(K0+2*K1+2*K2+K3);
    
end
[RungKUTT]=inp;
end

