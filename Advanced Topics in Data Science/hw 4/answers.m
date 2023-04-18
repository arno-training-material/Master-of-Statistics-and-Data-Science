% initialization
addpath('dace') 
camelback = @(x1,x2) 4*x1.^2 - 2.1*x1.^4 + 1/3*x1.^6 + x1.*x2 - 4*x2.^2 + 4*x2.^4;
x_opt_true = [0.0977, -0.6973];
y_opt_true = camelback(x_opt_true(1),x_opt_true(2));
x1_max = 2;
x1_min = -2;
x2_max = 1;
x2_min = -1;
xmin = [x1_min, x2_min];
xmax = [x1_max, x2_max];
scaler1 = @(x1) x1*(x1_max-x1_min)+x1_min;
scaler2 = @(x2) x2*(x2_max-x2_min)+x2_min;
rng(4)
%% a; initial design and candidate set
n_ini = 20;
n_candidate = 100;
X_ini_helper = lhsamp(n_ini,2);
X_ini_1 = scaler1(X_ini_helper(:,1));
X_ini_2 = scaler2(X_ini_helper(:,2));
X_ini = [X_ini_1, X_ini_2];
X_cand_helper = lhsamp(n_candidate,2);
X_cand_1 = scaler1(X_cand_helper(:,1));
X_cand_2 = scaler2(X_cand_helper(:,2));
X_cand = [X_cand_1 X_cand_2];
scatter(X_ini_1,X_ini_2,[],'og')
hold on
scatter(X_cand_1,X_cand_2 ,[],'diamondr')
legend('Initial design','Candidate set','Location','bestoutside')
xlabel("x1")
ylabel("x2")
saveas(gcf,"a.png")
hold off
%% initial fit
Y_ini = camelback(X_ini(:,1),X_ini(:,2));
theta = ones(1,2); % chosen somewhat ad hoc
lb = theta/10;
ub = theta*10;
[dmodel, ~] = dacefit(X_ini,Y_ini, @regpoly0, @corrgauss, theta, lb, ub)
[Ygpcand, ~] = predictor(X_cand, dmodel);

n_plot = 100;
Xplot = gridsamp([xmin;xmax], n_plot);
[Ygpplot, ~] = predictor(Xplot, dmodel);

Xplot1 = reshape(Xplot(:,1)',n_plot,n_plot );
Xplot2 = reshape(Xplot(:,2),n_plot,n_plot );
Ytrueplot = camelback(Xplot1,Xplot2);
Ygpplot= reshape(Ygpplot,size(Xplot1)); 

mesh(Xplot1, Xplot2, Ygpplot,'edgecolor','none','FaceColor','cyan','FaceAlpha','0.5') 
hold on 
mesh(Xplot1, Xplot2, Ytrueplot,'edgecolor','none','FaceColor','yellow','FaceAlpha','0.5') 
plot3(X_ini_1,X_ini_2,Y_ini,'o', 'MarkerSize',5,MarkerFaceColor='green')
plot3(X_cand_1,X_cand_2,Ygpcand,'diamond', 'MarkerSize',5,MarkerFaceColor='red')

[Ymin, min_index] = min(Y_ini);
[Ycand, MSEcand] = predictor(X_cand, dmodel);
EI  = (Ymin - Ycand).*normcdf((Ymin - Ycand)./sqrt(MSEcand)) + sqrt(MSEcand).*normpdf((Ymin - Ycand)./sqrt(MSEcand));
[EImax, EIindex] = max(EI);

plot3(X_cand_1(EIindex),X_cand_2(EIindex),Ygpcand(EIindex),'diamond', 'MarkerSize',10,MarkerFaceColor='black')

legend('Fitted GP','Camelback function', 'Initial sample','Candidate set', 'Next sample' ,'Location','bestoutside')
xlabel("x1")
ylabel("x2")
zlabel("y")
saveas(gcf,"extra1.png")
hold off
%% Bayesian optimization
n_sample = 10;
X = X_ini;
Y = Y_ini;
X_cand_rem = X_cand;
EImax_plot = [];
for i = 1:n_sample
    [EImax, indX] = next_sample(X,Y,X_cand_rem, theta, lb, ub);
    Xnew = X_cand_rem(indX,:);
    X = [X; Xnew];
    Y = [Y; camelback(Xnew(1),Xnew(2))];
    X_cand_rem = X_cand_rem([1:indX-1,indX+1:end],:);
    EImax_plot = [EImax_plot; EImax];
end
[y_opt_algo , ind_algo] = min(Y);
x_opt_algo = X(ind_algo,:);

Y_cand = camelback(X_cand(:,1),X_cand(:,2));
X_ini_cand = [X_ini; X_cand];
Y_ini_cand = [Y_ini; Y_cand];
[y_opt_ini_cand , ind_cand_ini]  = min(Y_ini_cand);
x_opt_ini_cand = X_ini_cand(ind_cand_ini,:);
%% b + c
scatter(X(1:n_ini,1),X(1:n_ini,2),[],'og')
hold on
scatter(X(n_ini+1:end,1),X(n_ini+1:end,2),[],'ok')
scatter(X_cand_rem(:,1),X_cand_rem(:,2),[],'diamondr')
scatter(x_opt_true(1),x_opt_true(2),[],'squareb')
scatter(x_opt_ini_cand(1),x_opt_ini_cand(2),[],'^b')
scatter(x_opt_algo(1),x_opt_algo(2),[],'*b')
legend('Initial design', ...
       'Used candidate set', ...
       'Unused candidate set', ...
       'True minimum', ...
       'Minimum considered points', ...
       'Minimum found by BO', ...
       'Location','bestoutside')
xlabel("x1")
ylabel("x2")
saveas(gcf,"bc.png")
hold off
camelback(x_opt_ini_cand(1),x_opt_ini_cand(2)) % -0.9367
camelback(x_opt_algo(1),x_opt_algo(2)) % -0.9367
camelback(x_opt_true(1),x_opt_true(2)) % -1.0294
%% d
plot(1:n_sample,EImax_plot)
xlabel("Iteration")
ylabel("Maximum expected improvement")
saveas(gcf,"d.png")
%% e
Ymin = min(Y);
[dmodel, ~] = dacefit(X,Y, @regpoly0, @corrgauss, theta, lb, ub);
[Yini_cand_pred, MSEini_cand] = predictor(X_ini_cand, dmodel);
1e-12 > min(MSEini_cand)
min(MSEini_cand) > 0.0 % MSE of zero would give NaN in EI calculation
EI  = (Ymin - Yini_cand_pred).*normcdf((Ymin - Yini_cand_pred)./sqrt(MSEini_cand)) + sqrt(MSEini_cand).*normpdf((Ymin - Yini_cand_pred)./sqrt(MSEini_cand));
scatter3(X_ini_cand(:,1),X_ini_cand(:,2),EI)

[Ypredused, MSEpredused] = predictor(X, dmodel);
EIused  = (Ymin - Ypredused).*normcdf((Ymin - Ypredused)./sqrt(MSEpredused)) + sqrt(MSEpredused).*normpdf((Ymin - Ypredused)./sqrt(MSEpredused));
scatter3(X(:,1),X(:,2),EIused,'o')
hold on
[Ypredunused, MSEpredunused] = predictor(X_cand_rem, dmodel);
EIunused  = (Ymin - Ypredunused).*normcdf((Ymin - Ypredunused)./sqrt(MSEpredunused)) + sqrt(MSEpredunused).*normpdf((Ymin - Ypredunused)./sqrt(MSEpredunused));
scatter3(X_cand_rem(:,1),X_cand_rem(:,2),EIunused,'diamond')
legend('Initial and used candidate points','Unused candidate points','Location','bestoutside')
xlabel("x1")
ylabel("x2")
zlabel("Expected improvement")
saveas(gcf,"e.png")
hold off
%% final fit plot
[Ygpplot, ~] = predictor(Xplot, dmodel);
Ygpplot= reshape(Ygpplot,size(Xplot1)); 

mesh(Xplot1, Xplot2, Ygpplot,'edgecolor','none','FaceColor','cyan','FaceAlpha','0.5') 
hold on 
mesh(Xplot1, Xplot2, Ytrueplot,'edgecolor','none','FaceColor','yellow','FaceAlpha','0.5') 

legend('Fitted GP','Camelback function','Location','bestoutside')
xlabel("x1")
ylabel("x2")
zlabel("y")
saveas(gcf,"extra2.png")
hold off