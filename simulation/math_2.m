function [res] = math_2(xa,ya,za,vxa,vya,vza,Jsm_x,Jsm_y,Jsm_z,time_start,time_final, te,T)
%���� ����������� ��� ������: ����� ���������� ���� �� ������ ������, �
%����� ��� ���� ����� ������. �� ������ ������ ������ ����������� �� 2
%�����: ����� ��������� �� ������ �� ���������� � �� ���������� �� ������.
dt=1;
if(te<=time_start&&te<time_final)
   t=time_start:dt:(time_final-1);
    result=nan(length(t),6);
    result(1,:)=[xa,ya,za,vxa,vya,vza]; 
    result=RungKUTT( t, result, T ); 
   
    
elseif(te>time_start&&te<time_final)
    t_bef=te:-dt:time_start; %��-�� ���� ��� � ���� ������� ������� ������������ ��� �� ��������, ������� �������!!!!
    t_after=te:dt:(time_final-1);
    %before
      
        result_before=nan(length(t_bef),6);
        result_before(1,:)=[xa,ya,za,vxa,vya,vza]; 
        result_before=RungKUTT( t_bef, result_before, -dt ); 
        t_before=rot90(t_bef,2);
        %result_bef=RungKUTT( t_bef,result_bef, T ); 
        %��� ��� �������, � ����� ����! ������ ��� ����� ����� [te t-1 t-2
        %... t_start], � ��� ��������� �� ��������! � ��� ���� [t_start
        %t_start+1 ... te] ��� ����� ������������ ������ ������� �� 180
        %��������!
        
        
               result_before = [rot90(rot90(result_before(:,1))) ...
                      rot90(rot90(result_before(:,2))) ...
                      rot90(rot90(result_before(:,3))) ...
                      rot90(rot90(result_before(:,4))) ...
                      rot90(rot90(result_before(:,5))) ...  
                      rot90(rot90(result_before(:,6)))];
    %after
        
        result_after=nan(length(t_after),6);
        result_after(1,:)=[xa,ya,za,vxa,vya,vza]; 
        result_after=RungKUTT( t_after, result_after, dt ); 
   
       
    %���������
       result=[result_before;result_after];
%         result = [rot90(rot90(result(:,1))) ...
%                       rot90(rot90(result(:,2))) ...
%                       rot90(rot90(result(:,3))) ...
%                       rot90(rot90(result(:,4))) ...
%                       rot90(rot90(result(:,5))) ...  
%                       rot90(rot90(result(:,6)))];
        t=[t_before t_after];


end
%%�������� �� �������� ����
% tau=t-te;
% tau=rot90(tau);
% NEB_TEL=sun_moon(T, xa,ya,za,vxa,vya,vza);
% 
% dx=(NEB_TEL(1)+NEB_TEL(4))*0.5*tau.^2;
% dy=(NEB_TEL(2)+NEB_TEL(5))*0.5*tau.^2;
% dz=(NEB_TEL(3)+NEB_TEL(6))*0.5*tau.^2;
% 
% dvx=(NEB_TEL(1)+NEB_TEL(4))*tau;
% dvy=(NEB_TEL(2)+NEB_TEL(5))*tau;
% dvz=(NEB_TEL(3)+NEB_TEL(6))*tau;
% 
% 
% result(:,1)=result(:,1)+dvx;
% result(:,2)=result(:,2)+dvy;
% result(:,3)=-1*result(:,3)+dvz;
% 
% result(:,4)=result(:,4)+dvx;
% result(:,5)=result(:,5)+dvy;
% result(:,6)=result(:,6)+dvz;
res = [result rot90(t,3)];
end

