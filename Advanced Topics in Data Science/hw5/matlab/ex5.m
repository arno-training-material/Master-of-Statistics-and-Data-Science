function num_iterations = ex5(n,abs_tol)
    e = ones(n,1);
    B = spdiags([-e 2*e -e],-1:1,n,n);
    A = kron(B,speye(n)) + kron(speye(n),B);
    b = ones(size(A,2),1);
    BP = spdiags([-e 2*e],-1:0,n,n);
    P = kron(BP,speye(n)) + kron(speye(n),BP);
    x0 = zeros(size(A,2),1);
    [x,num_iterations] = defect_correction(A,b,P,x0,abs_tol);
end