function C = Matrix_C_2DOF(m1,m2,l1,l2,q1,q2,q1_p,q2_p)
 
C = [-(l2^2*m2*q2_p*sin(2*q2))/2, -(l2^2*m2*q1_p*sin(2*q2))/2;
     (l2^2*m2*q1_p*sin(2*q2))/2,                           0];
end