
%**********************************************************************************************************
%*******************************CONTROL DE POSICION SCARA***************************************************
%**********************************************************************************************************
clc; clear all; close all; warning off;
tfin = 60; 
f = 30
ts   = 1/f;
t    = 0:ts:tfin;
%% CONDICIONES INICIALES
q1(1) = 0*pi/180;               %ESLABON1
q2(1) = 45*pi/180;               %Posición articulacion dos
q3(1) = -30*pi/180;               %Posición articulacion tres
q4(1) = -15*pi/180;


q(:,1) = [q1,q2,q3,q4];

l1 =0.07;
l2 =0.071;            
l3 =0.071;          
l4 =0.15;


%%Configuracion de ROS
% Cerrar el nodo de ROS
rosshutdown;
rosinit;

%% CONFIGURACION PUBLICADOR
[state_topic, state_msg] = rospublisher('/states','sensor_msgs/Joy');
axe = zeros(1, 8);
% Establecer los valores de axe en el mensaje
state_msg.Axes = axe;
% Publicar el mensaje en el tópico '/states'
send(state_topic, state_msg);


%% CONFIGURACION SUSCRIPTOR
% Crear el suscriptor para el mensaje de Odometría
  control_sub = rossubscriber('/control');

%% CONTROL
tic
for k=1:length(t)
    tic
    
    
    %% Controlador Jacobiano
    msg_control = receive(control_sub, 1); % Espera hasta 10 segundos por un mensaje
    qpref = msg_control.Axes
    
    q(:,k+1) = ts*qpref+q(:,k);
    %% CINEMATICA DIRECTA
    
    state_msg.Axes = [q(:,k+1) [0,0,0,0]'];
    send(state_topic, state_msg);

        
    h(:,k+1) = CDArm4DOF(l1,l2,l3,l4,q(:,k+1));
    
    while toc < ts
    end
    
    
    %%
end
toc
%% GRAFICAS DE ERROR
% figure(1)
% subplot(1,2,1)
% plot(t,hxe,'g');hold on;grid on
% plot(t,hye,'r');hold on
% plot(t,hze,'b')
% legend('Ex','Ey','Ez');
% xlabel('Tiempo [s]');
% ylabel('Error [m]');
% title('ERRORES DE CONTROL');

%% VELOCIDADES DE ESLABONES
% subplot(1,2,2)
% plot(t,q1p,'g');hold on;grid on
% plot(t,q2p,'r');hold on
% plot(t,q3p,'b');hold on
% plot(t,q4p,'c');
% legend('q1_p','q2_p','q3_p','q4_p');
% xlabel('Tiempo [s]');
% ylabel('Velocidad [rad/s]');
% title('VELOCIDADES');

%% ANIMACION
figure(2)
axis equal


 DimensionesManipulador_i(0,l1,l2,l3,l4,1);
h1=Manipulador3D(0,0,0,q1(1),q2(1),q3(1),q4(1));
h2=plot3(0,0,0,'*r'); hold on
h3=plot3(0,00,00,'*b');
view(3)
axis equal 
pause=10;

%% ANIMACION FOR
for i=1:2:length(t)
  drawnow;
  delete(h1);
  delete(h2);
  h1=Manipulador3D(0,0,0,q(1,i),q(2,i),q(3,i),q(4,i));hold on
  h2=plot3(h(1,1:i),h(2,1:i),h(3,1:i),'*r'); hold on  
end



%%
% %%
% close all
% DimensionesManipulador();
% q1 = 0*pi/180;               %ESLABON1
% q2 = 45*pi/180;               %Posición articulacion dos
% q3 = -30*pi/180;               %Posición articulacion tres
% q4 = -15*pi/180;
% 
% l1=1;
% l2=1;
% l3=1;
% l4=1;
% 
% l1 =0.125;
% l2 =0.275;            
% l3 =0.275;          
% l4 =0.15;
% 
% hx=cos(q1)*(l3*cos(q2 + q3) + l2*cos(q2) + l4*cos(q2 + q3 + q4))
% hy=sin(q1)*(l3*cos(q2 + q3) + l2*cos(q2) + l4*cos(q2 + q3 + q4))
% hz=l1 + l3*sin(q2 + q3) + l2*sin(q2) + l4*sin(q2 + q3 + q4)
% % 
% 
% 
% % hx=l2*cos(q1)*cos(q2)+l3*cos(q1)*cos(q2+q3)+l4*cos(q1)*cos(q2+q3+q4)
% % hy=l2*sin(q1)*cos(q2)+l3*sin(q1)*cos(q2+q3)+l4*sin(q1)*cos(q2+q3+q4)
% % hz=l1+l2*sin(q2)+l3*sin(q2+q3)+l4*sin(q2+q3+q4)
% plot3(hx,hy,hz,'*r')
% Manipulador3D(0,0,0,q1,q2,q3,q4);
% axis equal
