function [E_tot1, E_tot2] = energy_check(solution, p)
    m1 = p.m1; m2 = p.m2; Ig1 = p.Ig1; Ig2 = p.Ig2; d1 = p.d1; d2 = p.d2;
    l1 = p.l1; g = p.g;
    
    % Initial %
    tstart = solution.x(1);
    tend = solution.x(end);

    z = deval(solution,tstart);
    theta1 = z(1); theta2 = z(2); theta1dot = z(3); theta2dot = z(4);
    
    i = [1; 0; 0];
    j = [0; 1; 0];
    k = [0; 0; 1];
    
    er1 = (sin(theta1)*i) - (cos(theta1)*j);
    etheta1 = cross(k,er1);
    
    er2 = (sin(theta2)*i) - (cos(theta2)*j);
    etheta2 = cross(k,er2);
    
    r_g1_o = d1*er1;
    r_e_o = l1*er1;
    r_g2_e = d2*er2;
    r_g2_o = r_e_o + r_g2_e;
    
    v1 = d1*theta1dot*etheta1;
    v2 = (l1*theta1dot*etheta1) + (d2*theta2dot*etheta2);
    
    Ek = (0.5*m1*dot(v1,v1)) + (0.5*m2*dot(v2,v2)) + ...
        (0.5*Ig1*(theta1dot^2)) + (0.5*Ig2*(theta2dot^2));
    
    Ep = (m1*g*r_g1_o(2)) + (m2*g*r_g2_o(2));
    
    E_tot1 = Ek + Ep;

    % Final
    z = deval(solution,tend);
    theta1 = z(1); theta2 = z(2); theta1dot = z(3); theta2dot = z(4);
    
    i = [1; 0; 0];
    j = [0; 1; 0];
    k = [0; 0; 1];
    
    er1 = (sin(theta1)*i) - (cos(theta1)*j);
    etheta1 = cross(k,er1);
    
    er2 = (sin(theta2)*i) - (cos(theta2)*j);
    etheta2 = cross(k,er2);
    
    r_g1_o = d1*er1;
    r_e_o = l1*er1;
    r_g2_e = d2*er2;
    r_g2_o = r_e_o + r_g2_e;
    
    v1 = d1*theta1dot*etheta1;
    v2 = (l1*theta1dot*etheta1) + (d2*theta2dot*etheta2);
    
    Ek = (0.5*m1*dot(v1,v1)) + (0.5*m2*dot(v2,v2)) + ...
        (0.5*Ig1*(theta1dot^2)) + (0.5*Ig2*(theta2dot^2));
    
    Ep = (m1*g*r_g1_o(2)) + (m2*g*r_g2_o(2));
    
    E_tot2 = Ek + Ep;
end