function [x,num_iterations] = conjugate_gradient_preconditioned(A,b,P,x0,abs_tol)
    invP = inv(P);
    A = invP*A;
    b = invP*b;
    [x,num_iterations] = conjugate_gradient(A,b,x0,abs_tol);
end