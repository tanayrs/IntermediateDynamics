function zdot = myrhs(z,t,p)
    % m = p.m; g = p.g; ka = p.ka; kb = p.kb; la = p.la; lb = p.lb; 
    % ca = p.ca; cb = p.cb; ra = p.ra; rb = p.rb;

    m = p.m; g = p.g; ka = p.kA; kb = p.kB; la = p.LA; lb = p.LB;
    ca = p.cA; cb = p.cB; ra = p.rA; rb = p.rB;

    r = z(1:2);
    v = z(3:4);

    r_ac = r - ra; l_ac = norm(r_ac); lambda_ac = r_ac/l_ac;
    r_bc = r - rb; l_bc = norm(r_bc); lambda_bc = r_bc/l_bc;


    Fsa = -ka*(l_ac-la)*lambda_ac;
    Fsb = -kb*(l_bc-lb)*lambda_bc;
    Fda = -ca*dot(v,lambda_ac)*lambda_ac;
    Fdb = -cb*dot(v,lambda_bc)*lambda_bc;
    
    jhat = [0;1];

    Ftot = Fsa + Fsb + Fda + Fdb - (g*jhat);

    rddot = Ftot/m;

    zdot = [v; rddot];
end