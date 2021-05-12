# ANALYTICAL COMPUTATION

#p,probability of a toss coming up as Heads    # n, number of trials

# Let g(p) = cdf(Normal(n*p,sqrt(n*p*(1-p))),30-0.5)
# 1 - g(p) ≥ 0.5
# g(p) ≤ 0.5

# For increasing p, g(p) decreases.
# Hence p should be minimum to let g(p) attain its maximum value (0.5).

# Minimum value of p is then the solution of 
# 0.5 - cdf(Normal(n*p,sqrt(n*p*(1-p))),30-0.5)=0

n=50;
f(p) = 0.5 - cdf(Normal(n*p,sqrt(n*p*(1-p))),30-0.5)
r = 0.55:0.001:0.65
p_ = r[(f.(0.55:0.001:0.65)).==0][1]
plot(r,f.(r),label = "f vs p")
scatter!([p_],[0],markersize = 3,label = "@ p = 0.59")
display("Estimated value of p for the given requirement")
display(p_)
#Checking solution with Monte Carlo simulations - (Julia code)

p = 0.59; q=1-p; N = 10^6;n = 50;
mc_estimate = sum([sum(wsample(["H", "T"], [p,q], n).=="H") for _ = 1:N].>=30)/N
display("Monte Carlo estimate")
display(mc_estimate)

# Checking solution with Binomial distribution - analytical formula
binomial_estimate = sum([pdf(Binomial(50,p),s) for s = 30:50])
display("Binomial estimate")
display(binomial_estimate)



