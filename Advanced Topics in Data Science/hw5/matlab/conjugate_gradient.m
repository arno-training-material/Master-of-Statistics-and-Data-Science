function [x,num_iterations] = conjugate_gradient(A,b,x0,abs_tol)
    num_iterations  = 0;
    x = x0;
    r = b - A*x;
    p = r;
    beta_denominator = r'*r;
    while norm(r) > abs_tol
        alpha = r'*r/(p'*A*p);
        x = x + alpha*p;
        r = r - alpha*A*p;
        beta_numerator = r'*r;
        beta = beta_numerator/beta_denominator;
        p = r + beta*p;
        beta_denominator = beta_numerator;
        num_iterations = num_iterations + 1;
    end
end