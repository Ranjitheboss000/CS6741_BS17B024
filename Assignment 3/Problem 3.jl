using QuadGK,Distributions,Plots,PrettyTables,DataFrames,StatsBase,StatsPlots,FreqTables

dataset = vcat(repeat([1],1050),repeat([2],1450),repeat([3],300),repeat([4],70),repeat([5],12));

freq = [freqtable(dataset)[i] for i = 1:length(freqtable(dataset))];
plt1 = plot(freq,reuse = false,line=:stem,marker = :dot,label = "Counts",color = :black,title = "Violating Tailor-made,Right Skewed Dataset; \n Mean is left of the median and mode",titlefontsize = 10)
scatter!([mean(dataset)], [0], label="Mean", line=(4, :dash, :green))
scatter!([mode(dataset)], [50], label="Mode", line=(1, :red))
scatter!([median(dataset)], [0], label="Median", line=(3, :dot, :blue))
display(plt1)

#Also the following famous discrete distribution exhibit violations
d_P = Poisson(0.75)
poiss(x) = pdf(d_P,x)

plt2 = plot(0:4,poiss.(0:4),label = false,reuse = false,titlefontsize = 11,line=:stem,marker =:dot,color = :black,title = "Poisson Distribution with rate = 0.75; \n The skew is to the right, yet the mean is left of the median.")
scatter!([mean(d_P)], [0], label="Mean", line=(4, :dash, :green))
scatter!([mode(d_P)], [0], label="Mode", line=(1, :red))
scatter!([median(d_P)], [0], label="Median", line=(3, :dot, :blue))
display(plt2)