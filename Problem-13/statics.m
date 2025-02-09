function sol = statics(p)
    m = p.m; g = p.g; ka = p.ka; kb = p.kb; la = p.la; lb = p.lb; 
    ca = p.ca; cb = p.cb; ra = p.ra; rb = p.rb; 

    syms x y;
    z = [x y 0 0]';
    r = z(1:2);
    v = z(3:4);

    Fsa = -ka*(norm(r-ra)-la)*((r-ra)/norm(r-ra));
    Fsb = -kb*(norm(r-rb)-lb)*((r-rb)/norm(r-rb));
    Fda = -ca*norm(v)*((r-ra)/norm(r-ra));
    Fdb = -cb*norm(v)*((r-rb)/norm(r-rb));
    
    jhat = [0;1];

    Ftot = Fsa + Fsb + Fda + Fdb - (g*jhat);

    eqn = 0 == Ftot;

    sol = solve(eqn,[x, y]);

    sol
end