function [J] = jacobiana_Brazo4DOF(l2,l3,l4,q1,q2,q3,q4)
    
J = [-sin(q1)*(l3*cos(q2 + q3) + l2*cos(q2) + l4*cos(q2 + q3 + q4)), -cos(q1)*(l3*sin(q2 + q3) + l2*sin(q2) + l4*sin(q2 + q3 + q4)), -cos(q1)*(l3*sin(q2 + q3) + l4*sin(q2 + q3 + q4)), -l4*sin(q2 + q3 + q4)*cos(q1);...
    cos(q1)*(l3*cos(q2 + q3) + l2*cos(q2) + l4*cos(q2 + q3 + q4)), -sin(q1)*(l3*sin(q2 + q3) + l2*sin(q2) + l4*sin(q2 + q3 + q4)), -sin(q1)*(l3*sin(q2 + q3) + l4*sin(q2 + q3 + q4)), -l4*sin(q2 + q3 + q4)*sin(q1);...
    0,            l3*cos(q2 + q3) + l2*cos(q2) + l4*cos(q2 + q3 + q4),            l3*cos(q2 + q3) + l4*cos(q2 + q3 + q4),          l4*cos(q2 + q3 + q4)];
 
end

