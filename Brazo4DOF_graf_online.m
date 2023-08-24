clc, clear all, close all
%load('Cinematica.mat')
xu = 0; 
yu = 0; 
zu = 0;
psi= 0* (pi/180);

%Priemra Brazo
q1 = 15 * (pi/180);
q2 = 0 * (pi/180);
q3 = -30 * (pi/180);
q4 = -15 * (pi/180);

l1 =0.07;
l2 =0.071;            
l3 =0.071;          
l4 =0.15;

% Desplazamientos
a=0; 
b=0; 
c=0;

rosshutdown
setenv('ROS_MASTER_URI','http://192.168.88.223:11311')
setenv('ROS_IP','192.168.88.104')
rosinit

  
%% Lectura de posiciones del brazo

armSub = rossubscriber('/dynamixel_workbench/joint_states');
[pos_arm,ver_arm,current_arm] = dynamixeldata(armSub);




%%



%%
%% ******************************************************************************************************************
disp('Play Animacion de Simulacion ')
figure(1)
axis equal
% view(-15,15) % Angulo de vista
cameratoolbar


%q1 = 0;

DimensionesManipulador_i(0,l1,l2,l3,l4,1); 
M_1=Manipulador3D(0,0,0,q1(1),q2(1),q3(1),q4(1));

  
M_2 = plot3(0,0,0,'*');

while 1
tic
drawnow

delete(M_1);
delete(M_2);

[pos_arm,ver_arm,current_arm] = dynamixeldata(armSub);
q1 = pos_arm(1);
q2 = pos_arm(2);
q3 = pos_arm(3);
q4 = pos_arm(4);   


M_1=Manipulador3D(0,0,0,q1,q2,q3,q4);



h = CDArm4DOF(l1,l2,l3,l4,[q1,q2,q3,q4]);
M_2 = plot3(h(1),h(2),h(3),'*');  hold on

toc
pause(0.1)
 
end
%%
%   plot3(x,y,z,'o');
  

 