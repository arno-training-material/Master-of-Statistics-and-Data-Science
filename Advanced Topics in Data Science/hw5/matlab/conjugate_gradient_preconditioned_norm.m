function [residual_norm,error_norm,error_norm_bound] = conjugate_gradient_preconditioned_norm(A,b,P,x0,abs_tol)
    invP = inv(P);
    A = invP*A;
    b = invP*b;
    [residual_norm,error_norm,error_norm_bound]= conjugate_gradient_norm(A,b,x0,abs_tol);
end