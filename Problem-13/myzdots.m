function zdots = myzdots(z, p)
    rA = p.rA ; rB = p.rB;
    kA = p.kA; LA = p.LA; cA = p.cA;
    kB = p.kB; LB = p.LB; cB = p.cB;
    m = p.m; g = p.g; c = p.c;

    i  = [1 0]';   j = [0 1]'; 

    rC = z(1:2);  vC = z(3:4);
    rAC = rC - rA;  LAC = norm(rAC); lambdaAC = rAC/LAC;
    rBC = rC - rB;  LBC = norm(rBC); lambdaBC = rBC/LBC;
    
    LACdot = dot(vC,lambdaAC);
    LBCdot = dot(vC,lambdaBC);
    
    F =  - (kA * ( LAC-LA) * lambdaAC) - (cA  *  LACdot  * lambdaAC) ...
         - (kB  * (LBC-LB) * lambdaBC) - (cB  *  LBCdot  * lambdaBC) ...
         - (c*vC) - (m*g*j)    ;
     rCdot = vC;  vCdot = F/m;
     zdots = [rCdot; vCdot]; 
end
