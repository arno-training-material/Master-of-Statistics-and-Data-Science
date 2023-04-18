function [EImax, indX] = next_sample(X,Y,X_cand_rem, theta, lb, ub)
    Ymin = min(Y);
    [dmodel, ~] = dacefit(X,Y, @regpoly0, @corrgauss, theta, lb, ub);
    [Ycand, MSEcand] = predictor(X_cand_rem, dmodel);
    EI  = (Ymin - Ycand).*normcdf((Ymin - Ycand)./sqrt(MSEcand)) + sqrt(MSEcand).*normpdf((Ymin - Ycand)./sqrt(MSEcand));
    [EImax, indX] = max(EI);
end