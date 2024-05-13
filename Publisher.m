
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


%% Programa principal

f = 5;
ts = 1/f; % Tiempo de muestreo (segundos)
tiempo_simulacion = 60; % Tiempo total de simulación (segundos)

% Calcular el número de iteraciones necesario
num_iteraciones = tiempo_simulacion / ts;

% Bucle for para publicar múltiples mensajes
for i = 1:num_iteraciones
    tic
    
    x = round(randn(1, 4), 2);
    x_p = round(randn(1, 4), 2);

    state_msg.Axes = [x x_p];
    send(state_topic, state_msg);
 
    
    % Leer el mensaje de Odometría
    msg_control = receive(control_sub, 2); % Espera hasta 10 segundos por un mensaje
    control_actions = msg_control.Axes;
    
    disp(control_actions)

    while toc<ts
    end
    
    disp(toc)

end

% Cerrar el nodo de ROS
rosshutdown;
