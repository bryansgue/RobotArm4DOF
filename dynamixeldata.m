function [pos,vel,eff] = dynamixeldata(dynamixelSub)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


dynadata = receive(dynamixelSub,1); 


pos = dynadata.Position;
vel = dynadata.Velocity;
eff = dynadata.Effort;


end

