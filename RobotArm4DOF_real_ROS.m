
%**********************************************************************************************************
%*******************************CONTROL DE POSICION SCARA***************************************************
%**********************************************************************************************************
clc; clear all; close all; warning off;
tfin = 30;
f = 30;
ts   = 1/f;
t    = 0:ts:tfin;


% POSICIONES DESEADAS DE LOS ESLABONES PARA AHORRAR ENERGIA
q1d = 30*pi/180;               
q2d = -40*pi/180;               
q3d = -25*pi/180;               
q4d = 20*pi/180;

%% DISTANCIAS DE LOS ESLABONES

l1 =0.07;
l2 =0.071;            
l3 =0.071;          
l4 =0.15;


   
%% TRAYECTORIA DESEADA GRIPPER
value  = 9;
hxd =  0.025 * sin(value*0.08*t)  + 0.15;
hyd = 0.1 * sin(value*0.04*t);
hzd = 0.05 * sin(value*0.08*t)  + 0.125;

hd = [hxd; hyd; hzd];
% %% VELOCIDAD DESEADA
hxdp=  0.025 * value* 0.08 * cos(value*0.08*t);
hydp= 0.1 * value * 0.04 * cos(value*0.04*t);
hzdp= 0.05 * value* 0.08 * cos(value*0.08*t);


%% Lectura de posiciones del brazo for ROS

rosshutdown
setenv('ROS_MASTER_URI','http://192.168.88.252:11311')
% setenv('ROS_IP','192.168.88.104')
rosinit

[velControl_topic, velControl_msg] = rospublisher('/joy','sensor_msgs/Joy');
axe = [0.0 0 0 0];
% Establecer los valores de axe en el mensaje
velControl_msg.Axes = axe;
% Publicar el mensaje en el tópico '/joy'
send(velControl_topic, velControl_msg);


armSub = rossubscriber('/dynamixel_workbench/joint_states');
[pos_arm,ver_arm,current_arm] = dynamixeldata(armSub);


    q1(1) = pos_arm(1);
    q2(1) = pos_arm(2);
    q3(1) = pos_arm(3);
    q4(1) = pos_arm(4);

    q(:,1) = [q1,q2,q3,q4];
    
%% CINEMATICA DIRECTA 
h = CDArm4DOF(l1,l2,l3,l4,q(:,1));
hx=h(1);
hy=h(2);
hz=h(3);

%% CONTROL

for k=1:length(t)
    tic
    
    %% VECTOR DE ERRORES
    he(:,k)= hd(:,k)-h(:,k);   
    
    %% VECTOR DE VELOCIDADES DESEADAS
    hdp(:,k)=[hxdp(k) hydp(k) hzdp(k)]';
    
    %% Controlador Jacobiano
    qpref = Controler(l2,l3,l4,q(:,k),he(:,k),hdp(:,k));
    
%     q(:,k+1) = ts*qpref+q(:,k);
    
    [pos_arm,ver_arm,current_arm] = dynamixeldata(armSub);

    q(:,k+1) = [pos_arm(1) pos_arm(2) pos_arm(3) pos_arm(4)];
    
    %% CINEMATICA DIRECTA
    
    
    h(:,k+1) = CDArm4DOF(l1,l2,l3,l4,q(:,k+1));
    
    axe = [qpref(1) qpref(2) qpref(3) qpref(4)];
    % Establecer los valores de axe en el mensaje
    velControl_msg.Axes = axe;
    % Publicar el mensaje en el tópico '/joy'
    send(velControl_topic, velControl_msg);
    
    
    
     while toc<ts   
     end
        
   
    toc
    
    
    %%
end


velControl_msg.Axes = [0.0 0 0 0];

send(velControl_topic, velControl_msg);
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
h2=plot3(hx(1),hy(1),hz(1),'*r'); hold on
h3=plot3(hxd,hyd,hzd,'*b');
view(3)
axis equal 
pause=10;

%% ANIMACION FOR
for i=1:pause:length(t)
  drawnow;
  delete(h1);
  delete(h2);
  h1=Manipulador3D(0,0,0,q(1,i),q(2,i),q(3,i),q(4,i));hold on
  h2=plot3(h(1,1:i),h(2,1:i),h(3,1:i),'*r'); hold on  
  
%   pause(5)
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
