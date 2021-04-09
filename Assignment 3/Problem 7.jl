using Distributions,Plots
OneSidedTail_normal(x) = quantile(Normal(),(100-x)/100)
OneSidedTail_TDist(x) = quantile(TDist(10),(100-x)/100)

D_n = Normal()
n_5 = OneSidedTail_normal(95)
println("5th Percentile for Normal() is ", n_5)

D_t = TDist(10)
t_5 = OneSidedTail_TDist(95);
println("5th Percentile for TDist(10) is ", t_5)

plt1 = plot(x->x, x->pdf(D_n, x), -5 * std(D_n),OneSidedTail_normal(95), fill=(0, :orange),fa=0.5, label="")
plot!(x->x, x->pdf(D_n, x), mean(D_n) - 5 * std(D_n), mean(D_n) + 5 * std(D_n), label="Standard Normal", line=4)
scatter!([n_5],[0],label="5th Percentile",markersize = 3)
display(plt1)

plt2 =  plot(x->x, x->pdf(D_t, x), -5 * std(D_t),OneSidedTail_TDist(95), fill=(0, :orange),fa=0.5, label="")
plot!(x->x, x->pdf(D_t, x), mean(D_t) - 5 * std(D_t), mean(D_t) + 5 * std(D_t), label="Student t-distribution, DOF = 10", line=4)
scatter!([t_5],[0],label="5th Percentile",markersize = 3)
display(plt2)


