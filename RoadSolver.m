function Road = RoadSolver (IRI, IRI_last, z_last)
k_1 = 653;
k_2 = 63.3;
c = 6;
mu = 0.15;  
L = 250;
syms  R
syms z_s_prime z_s_dot_prime z_u_prime z_u_dot_prime 
z_u_prime = L*(IRI - z_last(2));
iri_z = [L*IRI 
         (IRI - IRI_last)*L
         L*IRI
         (IRI - IRI_last)*L];
z_jacobian =[0 0 -1 0
             0 0 0 -1
             1 0 0 0
             0 1 0 0];
 z_X = [z_s_prime, z_s_dot_prime,z_u_prime, z_u_dot_prime]';
 
 z = iri_z +(z_jacobian * z_X);
 
 A = [0 1 0 0
     -k_2 -c k_2 c
     0 0 0 1
     (k_2/mu) (c/mu) ((k_2 + k_1)/mu) -(c/mu)];
X = z_last;

B = [0
     0
     0
     (-k_1/mu)];
 eq = z == (A*X) + (B*R);
 Road_solve = solve(eq);
 Road = [vpa(Road_solve.R)
          vpa(Road_solve.z_s_prime)
          vpa(Road_solve.z_s_dot_prime)
          vpa(Road_solve.z_u_dot_prime)];
end