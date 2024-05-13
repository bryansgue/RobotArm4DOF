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
    q3 = 0;
    q4 = 0;
    
    q(:,1) = [q1(1); q2(1); q3(1); q4(1)]
 
    qp1 = 0;  %Velocidad articular del eslab�n 1
    qp2 = 0;  %Velocidad articular del eslab�n 2
    qp3 = 0;
    qp4 = 0;
    

    qp(:,1) = [qp1(1); qp2(1);qp3(1);qp4(1)];
    z  = 0; %Altura del extremo operativo

    x(:,1) = [q(:,1);qp(:,1)]


      % Posici�n deseadas del extremo operativo en el eje Z

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


masas = 1*[1;1;1;1]
m1 = masas(1);
m2 = masas(2);
m3 = masas(3);
m4 = masas(4);
l1 =0.07;
l2 =0.071;            
l3 =0.071;          
l4 =0.15;

q1d = 45 * pi/180;
q2d = 60 * pi/180;
q3d = -30 * pi/180;
q4d = -30 * pi/180;

I1 = 0.1;
I2 = 0.1;
I3 = 0.1;
I4 = 0.1;

G = Matrix_G_4DOF(m1,m2,m3,m4,I1,I2,I3,I4,l1,l2,l3,l4,q(1,1),q(2,1),q(3,1),q(4,1));



%%
for k = 1:length(t)
%1)Errores de control
   %a)Errores de posici�n articular para q1 y q2
   q1e(k) = q1d - q(1,k);
   q2e(k) = q2d - q(2,k);
   q3e(k) = q3d - q(3,k);
   q4e(k) = q4d - q(4,k);
   qe = [q1e(k); q2e(k);q3e(k);q4e(k)]
%    
%    %b)Errores de velocidad articular para q1 y q2
   q1pe(k) = 0 - qp(1,k);
   q2pe(k) = 0 - qp(2,k);
   q3pe(k) = 0 - qp(3,k);
   q4pe(k) = 0 - qp(4,k);
   qpe = [q1pe(k); q2pe(k); q3pe(k); q4pe(k)]; 
% 

   K = 4*eye(4);
   D = 1*eye(4);
% 

   T_ref(:,k) = K*tanh(qe) + D*tanh(qpe) + G;
   %T_ref(:,k) = [0;0;0;0]; 
% 

   M = Matrix_M_4DOF(m1,m2,m3,m4,I1,I2,I3,I4,l1,l2,l3,l4,q(1,k),q(2,k),q(3,k),q(4,k));
   C = Matrix_C_4DOF(m1,m2,m3,m4,I1,I2,I3,I4,l1,l2,l3,l4,q(1,k),q(2,k),q(3,k),q(4,k),qp(1,k),qp(2,k),qp(3,k),qp(4,k));
   G = Matrix_G_4DOF(m1,m2,m3,m4,I1,I2,I3,I4,l1,l2,l3,l4,q(1,k),q(2,k),q(3,k),q(4,k));
   
   f = [1*sign(qp(1,k));...
        1*sign(qp(2,k));
        1*sign(qp(3,k));
        1*sign(qp(4,k))];
   
   %qp = [qp1(k) qp2(k)]';

   
   x(:,k+1) = dynamics_system_arm(x(:,k), T_ref(:, k), ts, M, C, G, 0.5*f);
   
   %qpp = inv(M)*(T_ref(:,k)-C*qp(:,k)-G-0.5*f); %Aceleraci�n articular de salida
   
   q(:,k+1) = x(1:4,k+1);
   qp(:,k+1) = x(5:8,k+1);
   

   
   h(:,k+1) = CDArm4DOF(l1,l2,l3,l4,q(:,k+1));
   
   
   
end

% % *************************************************************************
% % ************************* ANIMACI�N *************************************
% % *************************************************************************
% %a)  Configuraci�n de la animaci�n del robot BOSCH-SR800 
%      scene = figure;        % new figure
%      tam = get(0,'ScreenSize');
%   %   set(scene,'position',[10 50 1500 900]); % position and size figure in the screen
%      xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]')
%       axis([-0.15 1 -0.8 0.8 -0.45 0.6]); % Set axis limits 
%       view(-15,15)
%      axis equal;            % Set axis aspect ratios
%      grid minor;            % Display axes grid lines   
%      camlight('headlight'); % Iluminaci�n del robot
%      material('dull');
%      cameratoolbar          % Control de escena por teclado
%      
%  %b) Animaci�n de movimiento del ROBOT BOSCH-SR800
%      scaleRobot = 1;
%      %R1 = robotPlot(q1(1),q2(1),z(1),scaleRobot);hold on
%      %D  = discoPlot(hxd(1),hyd(1),hzd(1),'g',scaleRobot);hold on
%    %  H  = plot3(hx(1),hy(1),hz(1),'c','LineWidth',4);
%      title('ANIMACI�N DE MOVIMIENTO - CONTROLADOR DIN�MICO PD')
% P0=[0 0 0];      
% 
% %plot3(hxd,hyd,hzd,'*','LineWidth',4);
% %line([hxd P0(1)] ,[hyd  P0(2)],[hzd P0(3)],'Color','blue','LineStyle','-','LineWidth',1); hold on
% 
% L2 = plot3(0,0,0); hold on
% L3 = plot3(0,0,0); hold on
% L4 = plot3(0,0,0); hold on
% H1  = plot3(0,0,0);
% H2  = plot3(0,0,0);
% H3  = plot3(0,0,0);
% H4  = plot3(0,0,0);
% for n = 1:1:length(t)
%     drawnow
%     axis equal; 
%     axis([-4 4 -4 4 -4 4]); % Set axis limits 
%     % view(-15,15)
%     delete(L2)
%     delete(L3)
%     delete(L4)
%      
%     delete(H1)   
%     delete(H2)
%     delete(H3)
%     delete(H4)
%     %R1 = robotPlot(q1(n),q2(n),z(n),scaleRobot);hx
%     H1  = plot3(h1(1,n),h1(2,n),h1(3,n),'o','LineWidth',4,'Color','red');
%     H2  = plot3(h2(1,n),h2(2,n),h2(3,n),'o','LineWidth',4,'Color','red');
%     H3  = plot3(h3(1,n),h3(2,n),h3(3,n),'o','LineWidth',4,'Color','red');
%     H4  = plot3(h(1,n),h(2,n),h(3,n),'o','LineWidth',4,'Color','red');
%     % H1  = plot3(hx(2:n),hy(2:n),hz(2:n),'--','LineWidth',1);
%     L1 = line([h1(1,n) P0(1)] ,[h1(2,n)  P0(2)],[h1(3,n) P0(3)],'Color','red','LineStyle','-'); hold on
%     L2 = line([h2(1,n) h1(1,n)] ,[h2(2,n)  h1(2,n)],[h2(3,n) h1(3,n)],'Color','blue','LineStyle','-'); hold on
%     L3 = line([h3(1,n) h2(1,n)] ,[h3(2,n)  h2(2,n)],[h3(3,n) h2(3,n)],'Color','blue','LineStyle','-'); hold on
%     L4 = line([h(1,n) h3(1,n)] ,[h(2,n)  h3(2,n)],[h(3,n) h3(3,n)],'Color','blue','LineStyle','-'); hold on
%     pause(ts)
% end


%%
%% ANIMACION
figure(2)
axis equal
 DimensionesManipulador_i(0,l1,l2,l3,l4,1);
h1=Manipulador3D(0,0,0,q1(1),q2(1),q3(1),q4(1));
h2=plot3(h(1,1),h(2,1),h(3,1),'*r'); hold on

view(3)
axis equal 
pause=1;

% ANIMACION FOR
for i=1:pause:length(t)
  drawnow;
  delete(h1);
  delete(h2);
  h1=Manipulador3D(0,0,0,q(1,i),q(2,i),q(3,i),q(4,i));hold on
  h2=plot3(h(1,1:i),h(2,1:i),h(3,1:i)); hold on  
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
        
      
    
    