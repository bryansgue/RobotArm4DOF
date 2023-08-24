function CD2 = CD3_Brazo3DOF(l1,l2,l3,q1,q2,q3)

%q1 = -q1;
hx = cos(q1)*(l3*cos(q2 + q3) + l2*cos(q2));
hy =  sin(q1)*(l3*cos(q2 + q3) + l2*cos(q2));
hz = l1 + l3*sin(q2 + q3) + l2*sin(q2);


CD2 = [hx;hy;hz];
return