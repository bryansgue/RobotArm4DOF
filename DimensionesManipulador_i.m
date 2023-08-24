function DimensionesManipulador_i(a,L1,L2,L3,L4,escala)
if nargin<5
   escala=1;    
end
global R Dim

Dim.h2=0;
Dim.a=a;

%BRAZO
%%Dimensiones Base L1
lm1=0.05/2;
Dim.lh1=L1; % L1 de afuera es la suma de lm1 y esta
%Ancho de todos los eslabones-motores
Dim.lm2=0.05/2;

%Largo motor base
Dim.lh2=0.0;

%largo del motor 234
lh3=0.075/2;
lh4=0.025/2;
%


R.Tapa1Motor1=[[1 1 -1 -1]*lm1/2+Dim.a;[-1 1 1 -1]*lm1/2;Dim.h2 Dim.h2 Dim.h2 Dim.h2]*escala;
R.Tapa2Motor1=[[1 1 1 1 -1 -1]*lm1/2+Dim.a;[-1 1 1 -1 -1 -1]*lm1/2;
    Dim.h2 Dim.h2 Dim.h2+Dim.lh1 Dim.h2+Dim.lh1 Dim.h2+Dim.lh1 Dim.h2]*escala;
R.Tapa3Motor1=[[-1 -1 1 1 -1 -1]*lm1/2+Dim.a;[-1 1 1 1 1 -1]*lm1/2;
    Dim.h2 Dim.h2 Dim.h2 Dim.h2+Dim.lh1 Dim.h2+Dim.lh1 Dim.h2+Dim.lh1]*escala;
R.Tapa4Motor1=[[lm1/2*cosd(0:10:180) lm1/2*cosd(180:-10:0)]+Dim.a;
    lm1/2*sind(0:10:180) lm1/2*sind(180:-10:0);
    sind(0:10:180)*0+Dim.h2+Dim.lh1 sind(0:10:180)*0+Dim.h2+Dim.lh1+Dim.lh2]*escala;
R.Tapa5Motor1=[[lm1/2*cosd(180:10:360) lm1/2*cosd(360:-10:180)]+Dim.a;
    lm1/2*sind(180:10:360) lm1/2*sind(360:-10:180);
    sind(0:10:180)*0+Dim.h2+Dim.lh1 sind(0:10:180)*0+Dim.h2+Dim.lh1+Dim.lh2]*escala;

R.Tapa1Motor2=[[1 1 -1 -1]*Dim.lm2/2;[-1 -1 -1 -1]*2*lh3/3;
    Dim.h2+Dim.lh1+Dim.lh2 Dim.h2+Dim.lh1+Dim.lh2+Dim.lm2 Dim.h2+Dim.lh1+Dim.lh2+Dim.lm2 Dim.h2+Dim.lh1+Dim.lh2]*escala;
R.Tapa2Motor2=[[1 1 1 1 -1 -1]*Dim.lm2/2;[-2*lh3/3 -2*lh3/3 lh3/3 lh3/3 lh3/3 -2*lh3/3];
    Dim.h2+Dim.lh1+Dim.lh2 Dim.h2+Dim.lh1+Dim.lh2+Dim.lm2 Dim.h2+Dim.lh1+Dim.lh2+Dim.lm2 Dim.h2+Dim.lh1+Dim.lh2 Dim.h2+Dim.lh1+Dim.lh2 Dim.h2+Dim.lh1+Dim.lh2]*escala;
R.Tapa3Motor2=[[-1 -1 -1 1 1 -1]*Dim.lm2/2;[-2*lh3/3 lh3/3 lh3/3 lh3/3 -2*lh3/3 -2*lh3/3];
    Dim.h2+Dim.lh1+Dim.lh2 Dim.h2+Dim.lh1+Dim.lh2 Dim.h2+Dim.lh1+Dim.lh2+Dim.lm2 Dim.h2+Dim.lh1+Dim.lh2+Dim.lm2 Dim.h2+Dim.lh1+Dim.lh2+Dim.lm2 Dim.h2+Dim.lh1+Dim.lh2+Dim.lm2]*escala;
R.Tapa4Motor2=[[Dim.lm2/2*cosd(0:10:180) Dim.lm2/2*cosd(180:-10:0)];
    sind(0:10:180)*0+lh3/3 sind(0:10:180)*0+lh3/3+lh4;
    Dim.lm2/2*sind(0:10:180)+Dim.h2+Dim.lh1+Dim.lh2+Dim.lm2/2 Dim.lm2/2*sind(180:-10:0)+Dim.h2+Dim.lh1+Dim.lh2+Dim.lm2/2]*escala;
R.Tapa5Motor2=[[Dim.lm2/2*cosd(180:10:360) Dim.lm2/2*cosd(360:-10:180)];
    sind(0:10:180)*0+lh3/3 sind(0:10:180)*0+lh3/3+lh4;
    Dim.lm2/2*sind(180:10:360)+Dim.h2+Dim.lh1+Dim.lh2+Dim.lm2/2 Dim.lm2/2*sind(360:-10:180)+Dim.h2+Dim.lh1+Dim.lh2+Dim.lm2/2]*escala;

R.Frame1_1=[[Dim.lm2/2*sind(180:10:360) Dim.lm2 Dim.lm2];
    sind(0:10:180)*0-2*lh3/3 -2*lh3/3 -2*lh3/3;
    Dim.lm2/2*cosd(180:10:360) Dim.lm2/2 -Dim.lm2/2]*escala;

R.Frame1_2=[[Dim.lm2/2*sind(180:10:360) Dim.lm2 Dim.lm2];
    sind(0:10:180)*0+lh3/3+lh4 lh3/3+lh4 lh3/3+lh4;
    Dim.lm2/2*cosd(180:10:360) Dim.lm2/2 -Dim.lm2/2]*escala;

R.Frame1_3=[[1 1 1 1]*Dim.lm2;-2*lh3/3 lh3/3+lh4 lh3/3+lh4 -2*lh3/3;[-1 -1 1 1]*Dim.lm2/2]*escala;

Dim.sl1=L2-1.75*Dim.lm2;    
R.Slabon1_1=[[Dim.sl1 Dim.sl1 0 0 0 Dim.sl1]+Dim.lm2;[-1 1 1 -1 -1 -1]*Dim.lm2/2;[-1 -1 -1 -1 1 1]*Dim.lm2/2]*escala;

R.Slabon1_2=[[Dim.sl1 Dim.sl1 0 0 0 Dim.sl1]+Dim.lm2;[1 -1 -1 1 1 1]*Dim.lm2/2;[1 1 1 1 -1 -1]*Dim.lm2/2]*escala;

% Dim.sl2=L3-1.5*Dim.lm2;    
% R.Slabon2_1=[[Dim.sl2 Dim.sl2 0 0 0 Dim.sl2]+Dim.lm2;[-1 1 1 -1 -1 -1]*Dim.lm2/2;[-1 -1 -1 -1 1 1]*Dim.lm2/2]*escala;
% R.Slabon2_2=[[Dim.sl2 Dim.sl2 0 0 0 Dim.sl2]+Dim.lm2;[1 -1 -1 1 1 1]*Dim.lm2/2;[1 1 1 1 -1 -1]*Dim.lm2/2]*escala;

lm3=0.05/2.5;
%lh5=0.06+1;
lh5=L4-0.075;
lh6=0;
% R.Tapa1Motor5=[[1 1 1 1]*Dim.lm2;[-1 1 1 -1]*lm3/2;[-1 -1 1 1]*lm3/2]*escala;
% R.Tapa2Motor5=[[1 1 0 0 0 1]*lh5+Dim.lm2;[-1 -1 -1 -1 1 1]*lm3/2;[-1 1 1 -1 -1 -1]*lm3/2]*escala;
% R.Tapa3Motor5=[[1 1 1 0 0 0]*lh5+Dim.lm2;[1 1 -1 -1 1 1]*lm3/2;[-1 1 1 1 1 -1]*lm3/2]*escala;
% R.Tapa4Motor5=[sind(0:10:180)*0+Dim.lm2+lh5 sind(0:10:180)*0+Dim.lm2+lh5+lh6;lm3/2*sind(0:10:180) lm3/2*sind(180:-10:0);lm3/2*cosd(0:10:180) lm3/2*cosd(180:-10:0)]*escala;
% R.Tapa5Motor5=[sind(0:10:180)*0+Dim.lm2+lh5 sind(0:10:180)*0+Dim.lm2+lh5+lh6;lm3/2*sind(180:10:360) lm3/2*sind(360:-10:180);lm3/2*cosd(180:10:360) lm3/2*cosd(360:-10:180)]*escala;

R.Tapa1Motor5=[[1 1 1 1]*Dim.lm2;[-1 1 1 -1]*lm3/2;[-1 -1 1 1]*lm3/2]*escala;
R.Tapa2Motor5=[[1 1 0 0 0 1]*lh5+Dim.lm2;[-1 -1 -1 -1 1 1]*lm3/2;[-1 1 1 -1 -1 -1]*lm3/2]*escala;
R.Tapa3Motor5=[[1 1 1 0 0 0]*lh5+Dim.lm2;[1 1 -1 -1 1 1]*lm3/2;[-1 1 1 1 1 -1]*lm3/2]*escala;
R.Tapa4Motor5=[sind(0:10:180)*0+Dim.lm2+lh5 sind(0:10:180)*0+Dim.lm2+lh5+lh6;lm3/2*sind(0:10:180) lm3/2*sind(180:-10:0);lm3/2*cosd(0:10:180) lm3/2*cosd(180:-10:0)]*escala;
R.Tapa5Motor5=[sind(0:10:180)*0+Dim.lm2+lh5 sind(0:10:180)*0+Dim.lm2+lh5+lh6;lm3/2*sind(180:10:360) lm3/2*sind(360:-10:180);lm3/2*cosd(180:10:360) lm3/2*cosd(360:-10:180)]*escala;


%garra
lg1=.02/1.5;lg2=.03/1.5;lg3=0.05/1.5;
%escala = 5*escala;
R.Garra1=[[0 0 lg2*cosd(60) lg2*cosd(60)+lg3 lg2*cosd(60)+lg2*cosd(30)+lg3 lg2*cosd(60)+lg2*cosd(30)+lg3 lg2*cosd(60)+lg3 lg2*cosd(60)]+lh5+lh6+Dim.lm2;
           [-1 1 1 1 1 -1 -1 -1]*lg1/2 ;[0 0 lg2*sind(60) lg2*sind(60) lg2*sind(60)-lg2*sind(30) lg2*sind(60)-lg2*sind(30) lg2*sind(60) lg2*sind(60)]+lm3/2]*escala;
R.Garra2=[[0 0 lg2*cosd(60) lg2*cosd(60)+lg3 lg2*cosd(60)+lg2*cosd(30)+lg3 lg2*cosd(60)+lg2*cosd(30)+lg3 lg2*cosd(60)+lg3 lg2*cosd(60)]+lh5+lh6+Dim.lm2;
           [-1 1 1 1 1 -1 -1 -1]*lg1/2 ;[0 0 lg2*sind(60) lg2*sind(60) lg2*sind(60)-lg2*sind(30) lg2*sind(60)-lg2*sind(30) lg2*sind(60) lg2*sind(60)]+lm3/2-lg1*2/3]*escala;
R.Garra3=[[0 lg2*cosd(60) lg2*cosd(60)+lg3 lg2*cosd(60)+lg2*cosd(30)+lg3 lg2*cosd(60)+lg2*cosd(30)+lg3 lg2*cosd(60)+lg3 lg2*cosd(60) 0]+lh5+lh6+Dim.lm2;
            [-1 -1 -1 -1 -1 -1 -1 -1]*lg1/2;[0 lg2*sind(60) lg2*sind(60) lg2*sind(60)-lg2*sind(30) lg2*sind(60)-lg2*sind(30)-2*lg1/3 lg2*sind(60)-2*lg1/3 lg2*sind(60)-2*lg1/3 -2*lg1/3]+lm3/2]*escala;
R.Garra4=[[0 lg2*cosd(60) lg2*cosd(60)+lg3 lg2*cosd(60)+lg2*cosd(30)+lg3 lg2*cosd(60)+lg2*cosd(30)+lg3 lg2*cosd(60)+lg3 lg2*cosd(60) 0]+lh5+lh6+Dim.lm2;
            [1 1 1 1 1 1 1 1]*lg1/2;[0 lg2*sind(60) lg2*sind(60) lg2*sind(60)-lg2*sind(30) lg2*sind(60)-lg2*sind(30)-2*lg1/3 lg2*sind(60)-2*lg1/3 lg2*sind(60)-2*lg1/3 -2*lg1/3]+lm3/2]*escala;
R.Garra5=[[1 1 1 1]*(lg2*cosd(60)+lg2*cosd(30))+lg3+lh5+lh6+Dim.lm2;
            [-1 -1 1 1]*lg1/2;[-2*lg1/3 0 0 -2*lg1/3]+lg2*sind(60)-lg2*sind(30)+lm3/2]*escala;
Rot=[1 0 0;0 cosd(120) -sind(120);0 sind(120) cosd(120)];

R.Garra6=Rot*R.Garra1;
R.Garra7=Rot*R.Garra2;
R.Garra8=Rot*R.Garra3;
R.Garra9=Rot*R.Garra4;
R.Garra10=Rot*R.Garra5;
Rot=[1 0 0;0 cosd(-120) -sind(-120);0 sind(-120) cosd(-120)];
R.Garra11=Rot*R.Garra1;
R.Garra12=Rot*R.Garra2;
R.Garra13=Rot*R.Garra3;
R.Garra14=Rot*R.Garra4;
R.Garra15=Rot*R.Garra5;

Dim.h2=Dim.h2*escala;

Dim.a=Dim.a*escala;
Dim.lm2=Dim.lm2*escala;
Dim.sl1=Dim.sl1*escala;
