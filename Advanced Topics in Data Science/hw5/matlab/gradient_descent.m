function [x,num_iterations] = gradient_descent(A,b,x0,abs_tol)
    num_iterations  = 0;
    x = x0;
    r = b - A*x;
    p = r;
    while norm(r) > abs_tol
        alpha = r'*r/(p'*A*p);
        x = x + alpha*p;
        r = r - alpha*A*p;
        p = r;
        num_iterations = num_iterations + 1;
    end
end