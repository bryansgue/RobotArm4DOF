function CD2 = CD2_Brazo2DOF(l1,l2,q1,q2)

%q1 = -q1;
hx = l2*cos(q1)*cos(q2);
hy =  l2*cos(q2)*sin(q1);
hz = l1 + l2*sin(q2);


CD2 = [hx;hy;hz];
return