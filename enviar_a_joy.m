function enviar_a_joy(axe)


    % Crear publicador para el tópico '/joy'
     pub = rospublisher('/my_joy_topic', 'sensor_msgs/Joy');

    % Definir la frecuencia de publicación
    rate = rosrate(10); % 10 Hz

    % Bucle para publicar los valores
    for i = 1:length(axe)
        % Crear mensaje
        msg = rosmessage(pub);
        
        % Construir el mensaje con el valor actual de axe
        msg.Data = sprintf('axe[%d]: %d', i-1, axe(i));
        
        % Publicar el mensaje
        send(pub, msg);
        
        % Esperar para mantener la frecuencia
        waitfor(rate);
    end


end