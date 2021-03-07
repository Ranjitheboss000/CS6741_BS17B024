using DataFrames,Dates,PrettyTables

untidyData = DataFrame(
    id = repeat(["MX17004"],outer = 10),
    year = repeat(["2010"],outer = 10),
    month = repeat([1,2,3,4,5],inner = 2),
    element = repeat(["tmax","tmin"],inner = 5),
    d1 = missings(10),
    d2 = [missing,missing,27.3,14.4,missing,missing,missing,missing,29,14.6],
    d3 = [missing,missing,27,14.6,missing,missing,28.8,14.2,missing,missing],
    d4 = [30,16,missing,missing,27,14.6,missing,missing,29,14.6],
    d5 = [24,13,26,15,missing,missing,missing,missing,missing,missing],
    d6 = [missing,missing,missing,missing,missing,missing,23.5,15,28,18],
    d7 = [missing,missing,missing,missing,27,16,26,13.9,missing,missing],
    d8 = missings(10),
    d9 = [missing,missing,27.3,14.4,missing,missing,missing,missing,29,14.6],
    d10 = [missing,missing,27,14.6,missing,missing,28.8,14.2,missing,missing],
    d11 = [30,16,missing,missing,27,14.6,missing,missing,29,14.6],
    d12 = [24,13,26,15,missing,missing,missing,missing,missing,missing],
    d13 = [missing,missing,missing,missing,missing,missing,23.5,15,28,18],
    d14 = [missing,missing,missing,missing,27,16,26,13.9,missing,missing],
    d15 = missings(10),
    d16 = [missing,missing,27.3,14.4,missing,missing,missing,missing,29,14.6],
    d17 = [missing,missing,27,14.6,missing,missing,28.8,14.2,missing,missing],
    d18 = [30,16,missing,missing,27,14.6,missing,missing,29,14.6],
    d19 = [24,13,26,15,missing,missing,missing,missing,missing,missing],
    d20 = [missing,missing,missing,missing,missing,missing,23.5,15,28,18],
    d21 = [missing,missing,missing,missing,27,16,26,13.9,missing,missing],
    d22 = [missing,missing,27.3,14.4,missing,missing,missing,missing,29,14.6],
    d23 = [missing,missing,27,14.6,missing,missing,28.8,14.2,missing,missing],
    d24 = [30,16,missing,missing,27,14.6,missing,missing,29,14.6],
    d25 = [24,13,26,15,missing,missing,missing,missing,missing,missing],
    d26 = [missing,missing,missing,missing,missing,missing,23.5,15,28,18],
    d27 = [missing,missing,missing,missing,27,16,26,13.9,missing,missing],
    d28 = [30,16,missing,missing,27,14.6,missing,missing,29,14.6],
    d29 = [24,13,missing,missing,26.3,14.4,missing,missing,missing,missing],
    d30 = [missing,missing,missing,missing,missing,missing,missing,missing,missing,missing],
    d31 = [missing,missing,missing,missing,missing,missing,missing,missing,missing,missing],

);

show(untidyData,allrows=true)

days = names(untidyData)[5:35];
dayD = Dict(d => untidyData[:,d].!== missing  for d in days);

tidyData = DataFrame(id = String[],date = Date[],tmax = Float64[],tmin = Float64[]);

for r = 1:2:9
    for d = 1:31
        if dayD[days[d]][r]
            push!(tidyData,("MX17004",Date(2010,(r+1)/2,d),untidyData[r,days[d]],untidyData[r+1,days[d]]))
        end
    end
end
println("\n")
pretty_table(tidyData)
