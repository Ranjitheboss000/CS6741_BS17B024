using Plots;

f(p) = sum(binomial(20,k)*(p^k)*((1-p)^(20-k)) for k = 0:10);

atleast_10 = [f(p) for p = 0:0.01:1];
plot(0:0.01:1,atleast_10,ylabel = "Probability",xlabel = "p,  probability of losing Re1",legend = false)
