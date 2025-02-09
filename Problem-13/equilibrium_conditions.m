function F = equilibrium_conditions(r, p)
    % Force due to gravity
    Fg = [0; -p.m * p.g];
    
    % Force due to springs (assuming linear spring forces)
    Fa = -p.ka * (norm(r - p.ra) - p.la) * (r - p.ra) / norm(r - p.ra);
    Fb = -p.kb * (norm(r - p.rb) - p.lb) * (r - p.rb) / norm(r - p.rb);
    
    % Force due to damping (aligned with velocity direction)
    v = [0; 0]; % Velocity is zero at equilibrium
    Fda = -p.ca * norm(v) * (-v / norm(v + eps));
    Fdb = -p.cb * norm(v) * (-v / norm(v + eps));
    
    % Sum of forces must be zero at equilibrium
    F = Fg + Fa + Fb + Fda + Fdb;
end