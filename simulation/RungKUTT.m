function [RungKUTT ] = RungKUTT( t, result, dt)

T=1;
for i=1:length(t)-1
    
  %  inp=[ xa,ya,za,vxa,vya,vza];
    
 
    K0=F(result(i,:),T);
  
    
    K1=F((result(i,:)+0.5*dt.*K0), T);
    
    K2=F(result(i,:)+0.5*dt.*K1, T);
    
    K3=F(result(i,:)+dt.*K2, T);
    
    result(i+1,:)=result(i,:)+(dt/6)*(K0+2*K1+2*K2+K3);
    
end
[RungKUTT]=result;
end

