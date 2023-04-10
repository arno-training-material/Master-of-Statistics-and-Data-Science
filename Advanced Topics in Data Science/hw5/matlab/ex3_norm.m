function resid_norm = ex3_norm(n,abs_tol)
    e = ones(n,1);
    B = spdiags([-e 2*e -e],-1:1,n,n);
    A = kron(B,speye(n)) + kron(speye(n),B);
    b = ones(size(A,2),1);
    P = 4*speye(size(A,2));
    x0 = zeros(size(A,2),1);
    resid_norm = defect_correction_norm(A,b,P,x0,abs_tol);
end