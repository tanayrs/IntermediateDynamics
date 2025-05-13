function [E_tot1, E_tot2] = energy_check(solution, p, type)
    m1 = p.m1; m2 = p.m2; m3 = p.m3; Ig1 = p.Ig1; Ig2 = p.Ig2; Ig3 = p.Ig3;
    d1 = p.d1; d2 = p.d2; d3 = p.d3; l1 = p.l1; l2 = p.l2; g = p.g;
    
    % Initial %
    tstart = solution.x(1);
    tend = solution.x(end);

    z = deval(solution,tstart);
    theta1 = z(1); theta2 = z(2); theta3 = z(3);
    if type == 'DAE'
        theta1dot = z(10); theta2dot = z(11); theta3dot = z(12);
    else
        theta1dot = z(4); theta2dot = z(5); theta3dot = z(6);
    end
    
    i = [1; 0; 0];
    j = [0; 1; 0];
    k = [0; 0; 1];
    
    er1 = (sin(theta1)*i) - (cos(theta1)*j);
    etheta1 = cross(k,er1);
    
    er2 = (sin(theta2)*i) - (cos(theta2)*j);
    etheta2 = cross(k,er2);
    
    er3 = (sin(theta3)*i) - (cos(theta3)*j);
    etheta3 = cross(k,er3);

    r_g1_o = d1*er1;
    r_e_o = l1*er1;
    r_g2_e = d2*er2;
    r_g2_o = r_e_o + r_g2_e;

    r_f_e = l2*er2;

    r_g3_f = d3*er3;
    r_g3_e = r_f_e + r_g3_f;
    r_g3_o = r_g3_e + r_e_o;
    
    v1 = d1*theta1dot*etheta1;
    v2 = (l1*theta1dot*etheta1) + (d2*theta2dot*etheta2);
    v3 = (l1*theta1dot*etheta1) + (l2*theta2dot*etheta2) + (d3*theta3dot*etheta3);
    
    Ek = (0.5*m1*dot(v1,v1)) + (0.5*m2*dot(v2,v2)) + (0.5*m3*dot(v3,v3)) + ...
         (0.5*Ig1*(theta1dot^2)) + (0.5*Ig2*(theta2dot^2)) + (0.5*Ig3*(theta3dot^2));
    
    Ep = (m1*g*r_g1_o(2)) + (m2*g*r_g2_o(2)) + (m3*g*r_g3_o(2));
    
    E_tot1 = Ek + Ep;

    % Final
    z = deval(solution,tend);
    theta1 = z(1); theta2 = z(2); theta3 = z(3);
    if type == "DAE"
        theta1dot = z(10); theta2dot = z(11); theta3dot = z(12);
    else
        theta1dot = z(4); theta2dot = z(5); theta3dot = z(6);
    end
    
    i = [1; 0; 0];
    j = [0; 1; 0];
    k = [0; 0; 1];
    
    er1 = (sin(theta1)*i) - (cos(theta1)*j);
    etheta1 = cross(k,er1);
    
    er2 = (sin(theta2)*i) - (cos(theta2)*j);
    etheta2 = cross(k,er2);
    
    er3 = (sin(theta3)*i) - (cos(theta3)*j);
    etheta3 = cross(k,er3);

    r_g1_o = d1*er1;
    r_e_o = l1*er1;
    r_g2_e = d2*er2;
    r_g2_o = r_e_o + r_g2_e;

    r_f_e = l2*er2;

    r_g3_f = d3*er3;
    r_g3_e = r_f_e + r_g3_f;
    r_g3_o = r_g3_e + r_e_o;
    
    v1 = d1*theta1dot*etheta1;
    v2 = (l1*theta1dot*etheta1) + (d2*theta2dot*etheta2);
    v3 = (l1*theta1dot*etheta1) + (l2*theta2dot*etheta2) + (d3*theta3dot*etheta3);
    
    Ek = (0.5*m1*dot(v1,v1)) + (0.5*m2*dot(v2,v2)) + (0.5*m3*dot(v3,v3)) + ...
         (0.5*Ig1*(theta1dot^2)) + (0.5*Ig2*(theta2dot^2)) + (0.5*Ig3*(theta3dot^2));
    
    Ep = (m1*g*r_g1_o(2)) + (m2*g*r_g2_o(2)) + (m3*g*r_g3_o(2));
    
    E_tot2 = Ek + Ep;
end