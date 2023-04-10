function residual_norm = defect_correction_norm(A,b,P,x0,abs_tol)
    num_iterations  = 0;
    x = x0;
    r = b - A*x;
    residual_norm = norm(r);
    while norm(r) > abs_tol
        p = P\r; % massive speedup compared to p = invP*r
        x = x + p;
        r = r - A*p;
        residual_norm(end+1) = norm(r);
        num_iterations = num_iterations + 1;
    end
end