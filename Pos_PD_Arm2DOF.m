% *************************************************************************
% *********************** CONTROLADOR PD **********************************
% ************************* ROBOT SCARA ***********************************
% *************************************************************************
clear all; clc; close all; warning off;

tfin = 10;        % Tiempo de simulaci�n  
ts = 1/30;        % Per�odo de muestreo
t = [0:ts:tfin];  % Representa la evoluci�n en cada To

%a) Condiciones iniciales h(0, 0.7, 0.32)
    q1 = 0;   %Posici�n articular del eslab�n 1
    q2 = 0;   %Posici�n articular del eslab�n 2
    
    q(:,1) = [q1(1); q2(1)]
 
    qp1 = 0;  %Velocidad articular del eslab�n 1
    qp2 = 0;  %Velocidad articular del eslab�n 2
    

qp(:,1) = [qp1(1); qp2(1)];
    z  = 0; %Altura del extremo operativo

%b) Par�metros del Robot BOSCH SR-800
    l1 = 0.4;   %Distancia del eslab�n 1
    l2 = 0.3;   %Distancia del eslab�n 2
    h = 0.42;   %Altura de la base fija - primer ealab�n
    d = 0.17; %Distancia desde la base fija hacia el primer eslab�n

%c) Valores deseados h(0.5, -0.4, 0.0)  
    q1d = [-1.5 -1.5  0.5  0.5 -1.5];   % Posici�n deseadas de la articular del eslab�n 1  
    q2d = [ 1.5  1.5 -0.5 -0.5 1.5];   % Posici�n deseadas de la articular del eslab�n 2
    
    hzd = [0 0.2 0.2 0 0.2];      % Posici�n deseadas del extremo operativo en el eje Z

%d)Cinem�tica Directa Robot - BOSCH SR-800
   %Posiciones inicial del extremo operativo
%     hx = l1*cos(q1)+l2*cos(q1+q2);  
%     hy = l1*sin(q1)+l2*sin(q1+q2);
%     hz = h-0.1-z;
%     

    
    %Posiciones deseadas del extremo operativo

    
% *************************************************************************
% ************************* CONTROLADOR ***********************************
% *************************************************************************
b=1;

m1 = 0.75*2;
m2 = 0.75*2;
l1 = 1;
l2 = 1;

q1d = -pi/4;
q2d = pi/8;


for k = 1:length(t)
%1)Errores de control
   %a)Errores de posici�n articular para q1 y q2
   q1e(k) = q1d - q(1,k);
   q2e(k) = q2d - q(2,k);
   qe = [q1e(k); q2e(k)]
%    
%    %b)Errores de velocidad articular para q1 y q2
   q1pe(k) = 0 - qp(1,k);
   q2pe(k) = 0 - qp(2,k);
   qpe = [q1pe(k); q2pe(k)]; 
% 
%    %c)Errores de posici�n en el eje Z  
%    hze(k) = hzd(b) - hz(k);
% 
% %2)Matrices de Ganancia
%    %a)Para errores de posici�n articular para q1 y q2
   K = 30*[1 0; 0 1];
   D = 30*[1 0; 0 1];
% 
%    %b)Para errores de posici�n en el eje Z
%    w = 0.5;
%    
% %3)Ley de Control
%    %a)Ley de Control para q1 y q2
    T_ref(:,k) = K*tanh(qe) + D*tanh(qpe);
   T_ref(:,k) = [0;0]; 
% 
%    %b)Ley de Control para z
%    vz = -w*tanh(.6*hze(k)); 
   
%4)Robot - BOSCH SR-800 (T=M*qpp+C*qp+f)
   
   %%
   
   M = Matrix_M_2DOF(m1,m2,l1,l2,q(1,k),q(2,k));
   C = Matrix_C_2DOF(m1,m2,l1,l2,q(1,k),q(2,k),qp(1,k),qp(2,k));
   G = Matrix_G_2DOF(m1,m2,l1,l2,q(1,k),q(2,k));
   
   f = [1*sign(qp(1,k));...
        1*sign(qp(2,k))];
   
   %qp = [qp1(k) qp2(k)]';
   
   qpp = inv(M)*(T_ref(:,k)-C*qp(:,k)-G-3*f); %Aceleraci�n articular de salida
   
   qp(:,k+1) = ts*qpp+qp(:,k);
   
   q(:,k+1) = ts*qp(:,k)+q(:,k);
   

%    qp1(k+1)= ts*qpp(1)+qp1(k);  %Velocidad articular de salida 
%    qp2(k+1)= ts*qpp(2)+qp2(k);
%    
%    q1(k+1) = ts*qp1(k+1)+q1(k); %Posici�n articular de salida 
%    q2(k+1) = ts*qp2(k+1)+q2(k);
% % 
%    z(k+1) = To*vz+z(k);         %Posici�n en el eje Z
%   
%5)Cinem�tica Directa Robot - BOSCH SR-800

   h1(:,k) = [0;0;l1]
   
   h2(:,k) = CD2_Brazo2DOF(l1,l2,q(1,k),q(2,k));
   
%    
%  %6)Cambio de posici�n deseada
%    rho(k)= norm([qe; hze(k)]);
%    aux = 0.03;
%    if rho(k) < aux && b<length(q1d)
%        b=b+1; 
%    end
   
end

% *************************************************************************
% ************************* ANIMACI�N *************************************
% *************************************************************************
%a)  Configuraci�n de la animaci�n del robot BOSCH-SR800 
     scene = figure;        % new figure
     tam = get(0,'ScreenSize');
  %   set(scene,'position',[10 50 1500 900]); % position and size figure in the screen
     xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]')
      axis([-0.15 1 -0.8 0.8 -0.45 0.6]); % Set axis limits 
      view(-15,15)
     axis equal;            % Set axis aspect ratios
     grid minor;            % Display axes grid lines   
     camlight('headlight'); % Iluminaci�n del robot
     material('dull');
     cameratoolbar          % Control de escena por teclado
     
 %b) Animaci�n de movimiento del ROBOT BOSCH-SR800
     scaleRobot = 1;
     %R1 = robotPlot(q1(1),q2(1),z(1),scaleRobot);hold on
     %D  = discoPlot(hxd(1),hyd(1),hzd(1),'g',scaleRobot);hold on
   %  H  = plot3(hx(1),hy(1),hz(1),'c','LineWidth',4);
     title('ANIMACI�N DE MOVIMIENTO - CONTROLADOR DIN�MICO PD')
P0=[0 0 0];      

%plot3(hxd,hyd,hzd,'*','LineWidth',4);
%line([hxd P0(1)] ,[hyd  P0(2)],[hzd P0(3)],'Color','blue','LineStyle','-','LineWidth',1); hold on

L2 = plot3(0,0,0); hold on
H1  = plot3(0,0,0);
H2  = plot3(0,0,0);
for n = 1:1:length(t)
    drawnow
     axis equal; 
          axis([-2 2 -2 2 -2 2]); % Set axis limits 
     % view(-15,15)
    delete(L2)
     
    delete(H1)   
    delete(H2)
    %R1 = robotPlot(q1(n),q2(n),z(n),scaleRobot);hx
    H1  = plot3(h1(1,n),h1(2,n),h1(3,n),'o','LineWidth',4,'Color','red');
    H2  = plot3(h2(1,n),h2(2,n),h2(3,n),'o','LineWidth',4,'Color','red');
    % H1  = plot3(hx(2:n),hy(2:n),hz(2:n),'--','LineWidth',1);
    L1 = line([h1(1,n) P0(1)] ,[h1(2,n)  P0(2)],[h1(3,n) P0(3)],'Color','red','LineStyle','-'); hold on
    L2 = line([h2(1,n) h1(1,n)] ,[h2(2,n)  h1(2,n)],[h2(3,n) h1(3,n)],'Color','blue','LineStyle','-'); hold on
    pause(ts)
end
  
% *************************************************************************
% *************************** GR�FICAS ************************************
%% ************************************************************************
figure
    subplot(2,1,1)
        plot(t,q1e,'r','lineWidth',2); hold on
        plot(t,q2e,'b','lineWidth',2); hold on ;
        grid minor
%        plot(t,hze,'r','lineWidth',3); 
        legend('q_1_e','q_2_e','h_z_e')
        xlabel('Time [s]');ylabel('[ m ]');
        title('Errores de Control')
    subplot(2,1,2)
        plot(h2(1,:),'g','lineWidth',2); hold on
        plot(h2(2,1:length(t)),'m','lineWidth',2); hold on
        plot(h2(3,1:length(t)),'c','lineWidth',2); hold on 
         
        grid minor
        legend('h_x','h_y','h_z','xd','yd','zd')
        xlabel('Time [s]');
        ylabel('[m]');
        title('Evolucion del Extremo Operativo')
        
      
    
    