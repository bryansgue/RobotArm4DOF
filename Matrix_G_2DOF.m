function G = Matrix_G(m1,m2,l1,l2,q1,q2)
 
g = 9.8;

G = [              0;
    g*l2*m2*cos(q2)];
end