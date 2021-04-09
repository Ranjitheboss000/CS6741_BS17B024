using DataFrames,CSV,Dates,PrettyTables,FreqTables,StatsPlots,StatsBase,Statistics
backend(:plotly)

weeky(d) = Dates.week(d)

state = DataFrame(CSV.File("states.csv"));
state = transform(state,:Date => ByRow(weeky) => :Week);

z = findlast(x-> x == maximum(state[:,:Week]), state[:,:Week]);
m = maximum(state[:,:Week]);
y = state[1,:Week] - 1;

for i = 1:size(state)[1]
    state[i,:Week] -= y
    if i > z
        state[i,:Week] += m
    end 
end

gdf = groupby(state, [:State,:Week]);
cdf = combine(gdf,:Confirmed => sum);

g = groupby(cdf,:State);
statewise = [DataFrame(g[i]) for i = 1:38];

rdf = DataFrame(Week = Int[],Kerala = Int[],India = Int[],Delhi = Int[],Telangana = Int[],Rajasthan = Int[],
                Haryana = Int[],UttarPradesh = Int[],Ladakh = Int[],TamilNadu = Int[],JammuKashmir = Int[],
                Karnataka = Int[],Maharashtra = Int[],Punjab = Int[],AndhraPradesh = Int[],HimachalPradesh = Int[],
                Uttarakhand = Int[],Odisha = Int[],Puducherry = Int[],WestBengal = Int[],Chandigarh = Int[],
                Chhattisgarh = Int[],Gujarat = Int[],MadhyaPradesh = Int[],Bihar = Int[],Manipur = Int[],Goa = Int[],
                Mizoram = Int[],AndamanNicobar = Int[],Assam = Int[],Jharkhand = Int[],ArunachalPradesh = Int[],
                Nagaland = Int[],Tripura = Int[],DadraandNagarHaveliandDamanandDiu = Int[],Meghalaya = Int[],
                Sikkim = Int[],StateUnassigned = Int[],Lakshadweep = Int[]);

for w = 1:62
    arr = []
    for s = 1:38
        item = statewise[s][statewise[s].Week.== w,:Confirmed_sum]
        if length(item) == 0
            push!(arr,0)
        else
            push!(arr,item[1])
        end
    end
    push!(rdf,vcat(w,arr))

end

rdf = rdf[:,vcat("Week",sort(deleteat!(names(rdf), findfirst(x->x=="Week", names(rdf)))))];
show(rdf,allrows = true,show_row_number = false)

findpos(arr) = [indexin(arr[i], sort(arr))[1] for i in 1:length(arr)]
cor_s(x, y) = cor(findpos(x), findpos(y))

coV,spearman,pearson = zeros(38,38),zeros(38,38),zeros(38,38);
for i = 1:38
    for j = 1:38
        coV[i,j],pearson[i,j],spearman[i,j]= cov(rdf[:,i+1],rdf[:,j+1]),cor(rdf[:,i+1],rdf[:,j+1]),cor_s(rdf[:,i+1],rdf[:,j+1])
    end
end
        
plt1 = heatmap(coV,c = :thermal,title = "Heatmap - COVARIANCE");
display(plt1)

plt2 = heatmap(pearson,c = :thermal,title = "Heatmap - PEARSON CORRELATION");
display(plt2)

plt3 = heatmap(spearman,c = :thermal,title = "Heatmap - SPEARMAN CORRELATION");
display(plt3)