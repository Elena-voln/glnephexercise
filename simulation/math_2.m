function [res] = math_2(xa,ya,za,vxa,vya,vza,Jsm_x,Jsm_y,Jsm_z,time_start,time_final, te,T)
%надо рассмотреть два случая: когда наблюдения есть до начала старта, и
%когда они есть после старта. Во втором случае задача разбивается на 2
%части: поиск координат от старта до наблюдений и от наблюдений до финала.
dt=1;
if(te<=time_start&&te<time_final)
   t=time_start:dt:(time_final-1);
    result=nan(length(t),6);
    result(1,:)=[xa,ya,za,vxa,vya,vza]; 
    result=RungKUTT( t, result, T ); 
   
    
elseif(te>time_start&&te<time_final)
    t_bef=te:-dt:time_start; %из-за того что в этом времени матрица записывается как бы наоборот, вращаем столбцы!!!!
    t_after=te:dt:(time_final-1);
    %before
        
        result_before=nan(length(t_bef),6);
        result_bef(1,:)=[xa,ya,za,vxa,vya,vza]; 
        result_bef=RungKUTT( t_bef, result_before, T ); 
   
        result_bef=RungKUTT( t_bef,result_bef, T ); 
        %вот тут вращаем, и время тоже! потому что иначе будет [te t-1 t-2
        %... t_start], и это нормально не скоеитть! а нам надо [t_start
        %t_start+1 ... te] для этого поворачиваем каждый столбец на 180
        %градусов!
        result_before=rot90(result_bef,2);
        t_before=rot90(t_bef,2);
    %after
        
        result_after=nan(length(t_after),6);
        result_after(1,:)=[xa,ya,za,vxa,vya,vza]; 
        result_after=RungKUTT( t_after, result_after, T ); 
   
       
    %соединяем
       result=[result_before;result_after];
        
        t=[t_before t_after];



end

res = [result rot90(t)];
end

