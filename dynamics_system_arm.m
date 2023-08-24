function [x] = dynamics_system_arm(x, u, ts, M, C, G, f)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
k1 = dynamic_arm(x, u, M, C, G, f);
k2 = dynamic_arm(x + ts/2*k1, u, M, C, G, f); % new
k3 = dynamic_arm(x + ts/2*k2, u, M, C, G, f); % new
k4 = dynamic_arm(x + ts*k3,  u, M, C, G, f); % new

x = x +ts/6*(k1 +2*k2 +2*k3 +k4); % new
end