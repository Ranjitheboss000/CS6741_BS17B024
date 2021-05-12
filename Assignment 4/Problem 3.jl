""" 
In the limiting condition of n⟶∞, sum of random samples from a population with mean 100, and finite standard deviation 30, will converge to N (100n,30√n).
Taking advantage of the above statement, let’s approximate the X1 + X2 + … + Xn ≃  N (100n,30√n) where X ~ D(100,30), D is some distribution.
The objective is to find the  minimum number of space suits you have to pack in your luggage to last 3000 days with a probability of at least 95%.
In other words, we are looking for the minimum value of  “n” for which cdf(Normal(100n,30√n),3000) ≤ 0.05 
"""

v(a) = cdf(Normal(100*a,30*sqrt(a)),3000)
suits = [v(s) for s = 30:40]
min_space_suits = 30 + findfirst(suits.<=0.05) - 1
display("Minimum Number of Suits required")
display(min_space_suits)

plot(30:40,suits,xlim = (29,35),label = "CDF at 3000 varying with n",xlabel = "n,Number of space suits",ylabel = "cdf(Normal(100*n,30*sqrt(n)),3000)")
plot!([min_space_suits],[v(min_space_suits)],marker =:star,linetype =:stem,label = "The minimum number of space suits required")
plot!([30],[0.05],marker =:dot,linetype =:hline,label = "cdf = 0.05",yticks = 0:0.05:0.5)
