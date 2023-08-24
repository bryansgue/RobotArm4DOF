function M = D_H(q,d,a,alpha)
% R1= cos(alpha)
% R1 = 
   


H = [cos(q) -cos(sym(alpha))*sin(q) sin(sym(alpha))*sin(q) a*cos(q);
     sin(q) cos(sym(alpha))*cos(q) -sin(sym(alpha))*cos(q) a*sin(q);
     0 sin(sym(alpha)) cos(sym(alpha)) d;
     0 0 0 1]   ;
 
 

% M = Rotz*TrasZ*TrasX*Rotx;

M = H;