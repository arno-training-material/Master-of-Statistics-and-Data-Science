function num_iterations = ex2(n,abs_tol)
    e = ones(n,1);
    A = spdiags([-e 2*e -e],-1:1,n,n);
    P = 2*speye(n);
    b = ones(n,1);
    x0 = zeros(size(A,2),1);
    [x,num_iterations] = defect_correction(A,b,P,x0,abs_tol);
end