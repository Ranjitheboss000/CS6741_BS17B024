using Random, Plots
Random.seed!(0)
N = 10^3
# 1000 trials in this experiment is sufficient enough to witness the convergence to zero;
suM = 0
experiment = []

for i in 1:N
    suM += rand(Int8)
    push!(experiment,suM/i)
end

plot(1:N,experiment,xlabel = "# Chosen Random integers",ylabel = "Average",title= "LLN for 100 samples",label = "Observed averages")
plot!(1:N,[0 for i in 1:N],label = "Theoretical mean")


