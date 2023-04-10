function num_iterations = ex3(n,abs_tol)
    e = ones(n,1);
    B = spdiags([-e 2*e -e],-1:1,n,n);
    A = kron(B,speye(n)) + kron(speye(n),B);
    b = ones(size(A,2),1);
    P = 4*speye(size(A,2));
    x0 = zeros(size(A,2),1);
    [x,num_iterations] = defect_correction(A,b,P,x0,abs_tol);
end