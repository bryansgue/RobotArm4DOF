function M = Matrix_M_2DOF(m1,m2,l1,l2,q1,q2)
 
M = [-l2^2*m2*(sin(q2)^2 - 1),       0;
                           0, l2^2*m2];


end
