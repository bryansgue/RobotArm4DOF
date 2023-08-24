function [Vref]=Controler(l2,l3,l4,q,he,hdp)
%% JACOBIANO
q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

J = jacobiana_Brazo4DOF(l2,l3,l4,q1,q2,q3,q4);

%% MATRIZ DE GANANCIA
K = 1*eye(3);

%% POSICIONES DESEADAS DE LOS ESLABONES PARA AHORRAR ENERGIA
q1d = 0*pi/180;
q2d = 60*pi/180;
q3d = -15*pi/180;
q4d = -15*pi/180;

%% VECTOR n
hq1 = q1d-q1;
hq2 = q2d-q2;
hq3 = q3d-q3;
hq4 = q4d-q4;

n=[hq1 hq2 hq3 hq4]';

%% MATRIZ GANANCIA D
D = 0.1*eye(4);

%% MATRIZ IDENTIDAD I
I = eye(4);

%% TAREA SECUNDARIA PARA EL ROBOT
TAREA_S = (I-pinv(J)*J)*D*n ;

%%CONTROLADOR
% Vref=pinv(J)*(hdp+K.*tanh(0.5*he))+TAREA_S;
Vref=pinv(J)*(hdp + K*tanh(0.5*he))+TAREA_S;

end