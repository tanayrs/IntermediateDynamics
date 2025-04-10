function A = A_matrix(Ig1,Ig2,d1,d2,l1,m1,m2,theta1,theta2)
%A_matrix
%    A = A_matrix(Ig1,Ig2,D1,D2,L1,M1,M2,THETA1,THETA2)

%    This function was generated by the Symbolic Math Toolbox version 25.1.
%    08-Apr-2025 13:59:50

A = reshape([d1.*m1.*cos(theta1),d1.*m1.*sin(theta1),l1.*m2.*cos(theta1),l1.*m2.*sin(theta1),Ig1,0.0,0.0,0.0,d2.*m2.*cos(theta2),d2.*m2.*sin(theta2),0.0,Ig2,-1.0,0.0,1.0,0.0,cos(theta1).*(d1-l1),-d2.*cos(theta2),0.0,-1.0,0.0,1.0,sin(theta1).*(d1-l1),-d2.*sin(theta2),-1.0,0.0,0.0,0.0,d1.*cos(theta1),0.0,0.0,-1.0,0.0,0.0,d1.*sin(theta1),0.0],[6,6]);
end
