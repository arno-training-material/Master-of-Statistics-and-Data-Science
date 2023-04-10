function resid_norm = ex2_norm(n,abs_tol)
    e = ones(n,1);
    A = spdiags([-e 2*e -e],-1:1,n,n);
    P = 2*speye(n);
    b = ones(n,1);
    x0 = zeros(size(A,2),1);
    resid_norm = defect_correction_norm(A,b,P,x0,abs_tol);
end