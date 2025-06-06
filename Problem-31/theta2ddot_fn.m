function theta2ddot = theta2ddot_fn(Ig1,Ig2,d1,d2,g,l1,m1,m2,theta1,theta2,theta1dot,theta2dot)
%THETA2DDOT_FN
%    THETA2DDOT = THETA2DDOT_FN(Ig1,Ig2,D1,D2,G,L1,M1,M2,THETA1,THETA2,THETA1DOT,THETA2DOT)

%    This function was generated by the Symbolic Math Toolbox version 25.1.
%    08-Apr-2025 13:37:30

et1 = (d2.*m2)./(Ig1.*Ig2.*2.0+d2.^2.*l1.^2.*m2.^2+Ig2.*d1.^2.*m1.*2.0+Ig1.*d2.^2.*m2.*2.0+Ig2.*l1.^2.*m2.*2.0-d2.^2.*l1.^2.*m2.^2.*cos(theta1.*2.0-theta2.*2.0)+d1.^2.*d2.^2.*m1.*m2.*2.0);
et2 = Ig1.*g.*sin(theta2).*-2.0+Ig1.*l1.*theta1dot.^2.*sin(theta1-theta2).*2.0+g.*l1.^2.*m2.*sin(theta1.*2.0-theta2)+l1.^3.*m2.*theta1dot.^2.*sin(theta1-theta2).*2.0-d1.^2.*g.*m1.*sin(theta2).*2.0-g.*l1.^2.*m2.*sin(theta2)+d2.*l1.^2.*m2.*theta2dot.^2.*sin(theta1.*2.0-theta2.*2.0)+d1.*g.*l1.*m1.*sin(theta1.*2.0-theta2)+d1.^2.*l1.*m1.*theta1dot.^2.*sin(theta1-theta2).*2.0+d1.*g.*l1.*m1.*sin(theta2);
theta2ddot = et1.*et2;
end
