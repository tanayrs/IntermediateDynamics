function zdot = myrhs(z,t,p)
    m = p.m; g = p.g;
    
    r = z(1:2);
    v = z(3:4);

    x = r(1);
    y = r(2);

    xdot = v(1);
    ydot = v(2);
    
    denom = norm(r);
    
    if denom == 0
        denom = eps;
    end

    A = A_matrix(m, x, y);

    b = B_matrix(g, m, xdot, ydot);

    acc_vec = A \ b;

    zdot = [ v; acc_vec(1:2)];
end