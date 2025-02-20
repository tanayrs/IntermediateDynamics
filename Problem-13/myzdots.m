function zdots = myzdots(z, rA,rB, kA,LA, cA, kB,LB,cB,m,g,c);
    i  = [1 0]';   j = [0 1]'; 
    rC = z(1:2);  vC = z(3:4);
    rAC = rC - rA;  LAC = norm(rAC); lambdaAC = rAC/LAC;
    rBC = rC - rB;  LBC = norm(rBC); lambdaBC = rBC/LBC;
    
    LACdot = dot(vC,lambdaAC);
    LBCdot = dot(vC,lambdaBC);
    
    %Sum of all forces on the mass
    F      =  -kA * ( LAC-LA) * lambdaAC ...% spring  A
              -cA  *  LACdot  * lambdaAC ...% dashpot A
              -kB  * (LBC-LB) * lambdaBC ...% spring  B
              -cB  *  LBCdot  * lambdaBC ...% dashpot B
              -c   *  vC                 ...% viscous drag c
              -m*g *               j    ;   % gravity
     rCdot = vC;  vCdot = F/m;
     zdots = [rCdot; vCdot]; 
end
