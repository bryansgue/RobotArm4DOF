function [xp] = dynamic_arm(x, u, M, C, G, f)


%% Velocities
q_p = x(5:8);

%% Ceate vector
xp = zeros(8,1);

xp(1:4) = q_p;
xp(5:8) = inv(M)*(u-C*q_p-G-f);

end