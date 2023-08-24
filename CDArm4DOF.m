function cinematica4DOF=CDArm4DOF(l1,l2,l3,l4,q)


q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

% hx = xu + a*cos(psi) - b*sin(psi) + cos(psi + q1)*(l3*cos(q2 + q3) + l2*cos(q2));
% hy = yu + a*sin(psi) + b*cos(psi) + sin(psi + q1)*(l3*cos(q2 + q3) + l2*cos(q2));
% hz = zu + c  - l1 - l3*sin(q2 + q3) - l2*sin(q2);

hx = cos(q1)*(l3*cos(q2 + q3) + l2*cos(q2) + l4*cos(q2 + q3 + q4));
hy = sin(q1)*(l3*cos(q2 + q3) + l2*cos(q2) + l4*cos(q2 + q3 + q4));
hz = l1 + l3*sin(q2 + q3) + l2*sin(q2) + l4*sin(q2 + q3 + q4);


cinematica4DOF = [hx;hy;hz];
return