function G = Matrix_G_4DOF(m1,m2,m3,m4,I1,I2,I3,I4,l1,l2,l3,l4,q1,q2,q3,q4)

g = 9.8;

G = [0;...
    g*m4*(l3*cos(q2 + q3) + l2*cos(q2) + l4*cos(q2 + q3 + q4)) + g*m3*(l3*cos(q2 + q3) + l2*cos(q2)) + g*l2*m2*cos(q2);...
    g*m4*(l3*cos(q2 + q3) + l4*cos(q2 + q3 + q4)) + g*l3*m3*cos(q2 + q3);...
    g*l4*m4*cos(q2 + q3 + q4)];

end