function [ F ] = F( inp,T)

J02=1082625.75e-9;  %��������� ������������� ����������� ������ �������
GM=398600441.8e6;;    %� ��������������� ��������� ��������������� ���� ����� 
ae=6378136;         %������� (��������������) ������� ����������� ����������

xa=inp(1);
ya=inp(2);
za=inp(3);
vxa=inp(4);
vya=inp(5);
vza=inp(6);

r=sqrt(xa^2+ya^2+za^2);
GMrat=GM/(r^2);
xarat=xa/r;
yarat=ya/r;
zarat=za/r;
ro=ae/r;


%��� ��� ���� ������������� ����� ����� 4 �������
dxadt=vxa;
dyadt=vya;
dzadt=vza;
dvxadt=-GMrat*xarat-(3/2)*J02*GMrat*xarat*(ro^2)*(1-5*zarat^2);  %+Jxas+Jxam;
dvyadt=-GMrat*yarat-(3/2)*J02*GMrat*yarat*(ro^2)*(1-5*zarat^2);%+Jyas+Jyam;
dvzadt=-GMrat*zarat-(3/2)*J02*GMrat*zarat*(ro^2)*(3-5*zarat^2);%+Jzas+Jzam;
[F]=[dxadt,dyadt,dzadt,dvxadt,dvyadt,dvzadt];
end

