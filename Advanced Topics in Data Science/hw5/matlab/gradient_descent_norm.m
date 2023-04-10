function [residual_norm,error_norm] = gradient_descent_norm(A,b,x0,abs_tol)
    true_x = A\b;
    num_iterations  = 0;
    x = x0;
    r = b - A*x;
    p = r;
    residual_norm = norm(r);
    error_norm = sqrt((true_x - x)'*A*(true_x - x));
    while norm(r) > abs_tol
        alpha = r'*r/(p'*A*p);
        x = x + alpha*p;
        r = r - alpha*A*p;
        p = r;
        residual_norm(end+1) = norm(r);
        error_norm(end+1) = sqrt((true_x - x)'*A*(true_x - x));
        num_iterations = num_iterations + 1;
    end
end