function [x,num_iterations] = defect_correction(A,b,P,x0,abs_tol)
    num_iterations  = 0;
    x = x0;
    r = b - A*x;
    while norm(r) > abs_tol
        p = P\r; % massive speedup compared to p = invP*r
        x = x + p;
        r = r - A*p;
        num_iterations = num_iterations + 1;
    end
end