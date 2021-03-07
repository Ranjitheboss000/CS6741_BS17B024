using DataFrames,PrettyTables

#Column headers are values, not variable names
untidyData = DataFrame([ 
    :religion           => ["Agnostic","Atheist","Buddhist","Catholic","Don't know/refused","Evangelical Prot","Hindu","Historically Black Prot","Jehovah's Witness","Jewish"], 
    Symbol("<\$10k")    => [27,12,27,418,15,575,1,228,20,19], 
    Symbol("\$10-20k")  => [34,27,21,617,14,869,9,244,27,19], 
    Symbol("\$20-30k")  => [60,37,30,732,15,1064,7,236,24,25],
    Symbol("\$30-40k")  => [81,52,34,670,11,982,9,238,24,25],
    Symbol("\$40-50k")  => [76,35,33,638,10,881,11,197,21,30],
    Symbol("\$50-75k")  => [137,70,58,1116,35,1486,34,223,30,95],
    Symbol("\$75-100k") => [27,12,27,418,15,575,1,228,20,19],
    Symbol("\$100-150k")=> [34,27,21,617,14,869,9,244,27,19],
    Symbol(">\$150k")   => [81,52,34,670,11,982,9,238,24,25]
]);

pretty_table(untidyData)

#Melting untidyData with religion as the colvar

tidyData = DataFrame(religion = String[],income = String[],freq = Int[]);
inc_var = names(untidyData)[2:10];
rel = untidyData[:,1];
n = nrow(untidyData)
m = length(inc_var)

for i = 1:n
    for j = 1:m
        push!(tidyData,(untidyData[i,1],inc_var[j],untidyData[i,j+1]))
    end
end

println("\n")
pretty_table(tidyData)


