abs_tol1 = 1e-5;
abs_tol2 = 1e-8;
%% ex 2
ns = [10,25,50,100,250,500,1000];
its1 = arrayfun(@(x) ex2(x, abs_tol1), ns);
its2 = arrayfun(@(x) ex2(x, abs_tol2), ns);
(log10(its1(end))-log10(its1(1)))/(log10(ns(end))-log10(ns(1)))
(log10(its2(end))-log10(its2(1)))/(log10(ns(end))-log10(ns(1)))
loglog(ns,its1, ...
       ns,its2, ...
          LineStyle=":", Marker = ".", LineWidth=2, MarkerSize=25)
legend('Absolute tolerance = 1e-5','Absolute tolerance = 1e-8','Location','northwest')
xlabel("Size of tridiagonal matrix")
ylabel("Number of iterations to solve the linear system")
saveas(gcf,"ex2.png")

resid_norm = ex2_norm(100,abs_tol1);
semilogy(resid_norm, LineWidth=3)
xlabel("Iteration")
ylabel("Residual norm")
saveas(gcf,"ex2_norm.png")
%% ex 3
ns = 10:10:100;
its1 = arrayfun(@(x) ex3(x, abs_tol1), ns);
its2 = arrayfun(@(x) ex3(x, abs_tol2), ns);
(log10(its1(end))-log10(its1(1)))/(log10(ns(end)^2)-log10(ns(1)^2))
(log10(its2(end))-log10(its2(1)))/(log10(ns(end)^2)-log10(ns(1)^2))
loglog(ns.^2,its1, ...
       ns.^2,its2, ...
          LineStyle=":", Marker = ".", LineWidth=2, MarkerSize=25)
legend('Absolute tolerance = 1e-5','Absolute tolerance = 1e-8','Location','northwest')
xlabel("Size of Laplace matrix")
ylabel("Number of iterations to solve the linear system")
saveas(gcf,"ex3.png")

resid_norm = ex3_norm(100,abs_tol1);
semilogy(resid_norm, LineWidth=3)
xlabel("Iteration")
ylabel("Residual norm")
saveas(gcf,"ex3_norm.png")
%% ex 5
ns = 10:10:100;
its1 = arrayfun(@(x) ex5(x, abs_tol1), ns);
its2 = arrayfun(@(x) ex5(x, abs_tol2), ns);
(log10(its1(end))-log10(its1(1)))/(log10(ns(end)^2)-log10(ns(1)^2))
(log10(its2(end))-log10(its2(1)))/(log10(ns(end)^2)-log10(ns(1)^2))
loglog(ns.^2,its1, ...
       ns.^2,its2, ...
          LineStyle=":", Marker = ".", LineWidth=2, MarkerSize=25)
legend('Absolute tolerance = 1e-5','Absolute tolerance = 1e-8','Location','northwest')
xlabel("Size of Laplace matrix")
ylabel("Number of iterations to solve the linear system")
saveas(gcf,"ex5.png")

resid_norm = ex5_norm(100,abs_tol1);
semilogy(resid_norm, LineWidth=3)
xlabel("Iteration")
ylabel("Residual norm")
saveas(gcf,"ex5_norm.png")
%% ex 7
ns = 10:10:100;
its1 = arrayfun(@(x) ex7(x, abs_tol1), ns);
its2 = arrayfun(@(x) ex7(x, abs_tol2), ns);
(log10(its1(end))-log10(its1(1)))/(log10(ns(end)^2)-log10(ns(1)^2))
(log10(its2(end))-log10(its2(1)))/(log10(ns(end)^2)-log10(ns(1)^2))
loglog(ns.^2,its1, ...
       ns.^2,its2, ...
          LineStyle=":", Marker = ".", LineWidth=2, MarkerSize=25)
legend('Absolute tolerance = 1e-5','Absolute tolerance = 1e-8','Location','northwest')
xlabel("Size of Laplace matrix")
ylabel("Number of iterations to solve the linear system")
saveas(gcf,"ex7.png")


[resid_norm, error_norm] = ex7_norm(100,abs_tol1);
semilogy(resid_norm, LineWidth=3)
hold on
semilogy(error_norm, LineWidth=3)
legend('2 norm of residual','A norm of error','Location','northeast')
xlabel("Iteration")
ylabel("Norm")
saveas(gcf,"ex7_norm.png")
%% ex 8
ns = 10:10:100;
its1 = arrayfun(@(x) ex8(x, abs_tol1), ns);
its2 = arrayfun(@(x) ex8(x, abs_tol2), ns);
(log10(its1(end))-log10(its1(1)))/(log10(ns(end)^2)-log10(ns(1)^2))
(log10(its2(end))-log10(its2(1)))/(log10(ns(end)^2)-log10(ns(1)^2))     
loglog(ns.^2,its1, ...
       ns.^2,its2, ...
       LineStyle=":", Marker = ".", LineWidth=2, MarkerSize=25)
legend('Absolute tolerance = 1e-5','Absolute tolerance = 1e-8','Location','northwest')
xlabel("Size of Laplace matrix")
ylabel("Number of iterations to solve the linear system")
saveas(gcf,"ex8.png")

[resid_norm, error_norm, bound] = ex8_norm(100,abs_tol1);
semilogy(resid_norm, LineWidth=3)
hold on
semilogy(error_norm, LineWidth=3)
semilogy(bound, LineWidth=3)
legend('2 norm of residual','A norm of error','error A norm convergence bound','Location','northeast')
xlabel("Iteration")
ylabel("Norm")
saveas(gcf,"ex8_norm.png")
%% ex 9
ns = 10:10:100;
its1 = arrayfun(@(x) ex9(x, abs_tol1), ns);
its2 = arrayfun(@(x) ex9(x, abs_tol2), ns);
(log10(its1(end))-log10(its1(1)))/(log10(ns(end)^2)-log10(ns(1)^2))
(log10(its2(end))-log10(its2(1)))/(log10(ns(end)^2)-log10(ns(1)^2))     
loglog(ns.^2,its1, ...
       ns.^2,its2, ...
       LineStyle=":", Marker = ".", LineWidth=2, MarkerSize=25)
legend('Absolute tolerance = 1e-5','Absolute tolerance = 1e-8','Location','northwest')
xlabel("Size of Laplace matrix")
ylabel("Number of iterations to solve the linear system")
saveas(gcf,"ex9.png")


[resid_norm, error_norm, bound] = ex9_norm(100,abs_tol1);
semilogy(resid_norm, LineWidth=3)
hold on
semilogy(error_norm, LineWidth=3)
semilogy(bound, LineWidth=3)
legend('2 norm of residual','A norm of error','error A norm convergence bound','Location','northeast')
xlabel("Iteration")
ylabel("Norm")
saveas(gcf,"ex9_norm.png")
