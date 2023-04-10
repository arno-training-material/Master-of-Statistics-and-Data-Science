function [residual_norm,error_norm,error_norm_bound] = conjugate_gradient_norm(A,b,x0,abs_tol)
    true_x = A\b;
    num_iterations  = 0;
    x = x0;
    r = b - A*x;
    p = r;
    beta_denominator = r'*r;
    residual_norm = norm(r);
    error_norm_initial = sqrt((true_x - x)'*A*(true_x - x));
    error_norm = error_norm_initial;
    K = condest(A);
    error_norm_bound = 2*(((sqrt(K)-1)/(sqrt(K)+1))^num_iterations)*error_norm_initial;
    while norm(r) > abs_tol
        alpha = r'*r/(p'*A*p);
        x = x + alpha*p;
        r = r - alpha*A*p;
        beta_numerator = r'*r;
        beta = beta_numerator/beta_denominator;
        p = r + beta*p;
        beta_denominator = beta_numerator;
        residual_norm(end+1) = norm(r);
        error_norm(end+1) = sqrt((true_x - x)'*A*(true_x - x));
        num_iterations = num_iterations + 1;
        error_norm_bound(end+1) = 2*(((sqrt(K)-1)/(sqrt(K)+1))^num_iterations)*error_norm_initial;
    end
end