using QuadGK,Distributions,Plots,PrettyTables,DataFrames,StatsBase,StatsPlots,FreqTables

n = 30
mini(x) = n*((1-x)^(n-1))
maxi(x) = n*(x^(n-1))
rangy(x) = (1-x)*(x^(n-2))*(n-1)*n

data = [rand(Uniform(),30) for _= 1:10000];
mins = [minimum(d) for d in data];
maxs = [maximum(d) for d in data];
ranges = [(maximum(d)-minimum(d)) for d in data];

plt1 = plot(0:0.01:1,mini.(0:0.01:1),xlims = (0,0.25),line=(3,:dash,:red),label = "Theoretical Distribution for Minimum",legendfontcolor = "blue");
histogram!(mins,fa = 0.5,normalize = true,label = "Simulation for minimum")
display(plt1)

plt2 = plot(0:0.01:1,maxi.(0:0.01:1),xlims = (0.7,1),line=(3,:dash,:blue),label = "Theoretical Distribution for Maximum");
histogram!(maxs,fa = 0.5,normalize = true,label = "Simulation for minimum")
display(plt2)

beta_fit = fit(Beta,ranges)
range_Beta(x) = pdf(beta_fit,x)
d_mean = mean(beta_fit)
d_mode = mode(beta_fit)
d_median = median(beta_fit);

plt3 = plot(0:0.01:1,rangy.(0:0.01:1),xlims = (0.6,1.3),line=(4, :blue),label = "Theoretical Distribution for Range",legendfontcolor = "red",legendfontsize = 6);
histogram!(ranges,fa = 0,normalize = true,label = "Simulation for Range")
plot!(0:0.01:1,range_Beta.(0:0.01:1),label = "Fitted Beta",line=(3, :dash, :red))
plot!([d_mean, d_mean], [0, pdf(beta_fit, d_mean)], label="Mean", line=(4, :dash, :green))
plot!([d_mode, d_mode], [0, pdf(beta_fit, d_mode)], label="Mode", line=(1, :red))
plot!([d_median, d_median], [0, pdf(beta_fit, d_median)], label="Median", line=(3, :dot, :blue))
display(plt3)

plt4 = plot(0:0.001:1,range_Beta.(0:0.001:1),xlims = (0.6,1.2),label = "Fitted Beta for Range",line = (4,:black));
d_mean = mean(beta_fit)
d_mode = mode(beta_fit)
d_median = median(beta_fit)
plot!([d_mean, d_mean], [0, pdf(beta_fit, d_mean)], label="Mean", line=(4, :dash, :green))
plot!([d_mode, d_mode], [0, pdf(beta_fit, d_mode)], label="Mode", line=(1, :red))
plot!([d_median, d_median], [0, pdf(beta_fit, d_median)], label="Median", line=(3, :dot, :blue))
display(plt4)