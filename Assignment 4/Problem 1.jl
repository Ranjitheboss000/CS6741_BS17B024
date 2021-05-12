N = 10^6
n = 50
p = q = 0.5

# Estimation from Monte-Carlo simulation
mc_estimate = sum([sum(wsample(["H", "T"], [p,q], n).=="H") for _ = 1:N].>=30)/N
display("Monte Carlo estimate:"); 
display(mc_estimate)

# Estimation from Binomial Distribution
binomial_estimate = sum([pdf(Binomial(50),s) for s = 30:50])
display("Binominal estimate: ");
display(binomial_estimate)

# Normal approximation of Binomial(n,p)
#ccf, continuity correction factor
ccf  = -0.5
normal_approx = 1-cdf(Normal(n*p,sqrt(n*p*q)),30+ccf)
display("Normal approximation estimate:");
display(normal_approx)
