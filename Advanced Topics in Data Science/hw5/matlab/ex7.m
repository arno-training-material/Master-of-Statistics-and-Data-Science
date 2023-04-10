function num_iterations = ex7(n,abs_tol)
    e = ones(n,1);
    B = spdiags([-e 2*e -e],-1:1,n,n);
    A = kron(B,speye(n)) + kron(speye(n),B);
    b = ones(size(A,2),1);
    x0 = zeros(size(A,2),1);
    [x,num_iterations] = gradient_descent(A,b,x0,abs_tol);
end