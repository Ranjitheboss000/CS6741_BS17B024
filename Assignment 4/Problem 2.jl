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
plot(0.55:0.001:0.65,f.(0.55:0.001:0.65),label = "f vs p")
scatter!([0.59],[0],markersize = 3,label = "@ p = 0.59")


