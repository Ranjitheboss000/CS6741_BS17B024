using Plots,DataFrames,CSV,Dates,PrettyTables,FreqTables,Statistics,HTTP,JSON,JSON3

p = HTTP.get("https://api.covid19india.org/data.json");
j = JSON.Parser.parse(String(p.body));
j = j["cases_time_series"];
covid = vcat(DataFrame.(j)...);

show(covid,allcols=true,show_row_number = false)

mon(x) = x[4:end]

transform!(covid,:date => ByRow(mon) => :month);

cols = ["dailyconfirmed","dailydeceased","dailyrecovered"];
for c in cols
    covid[!,c] = parse.(Int,covid[!,c])
end

gTab = groupby(covid, :month);

println("\n")
pretty_table(combine(gTab,cols .=> sum .=> cols))

#First six values are assigned zero in the dataframe during moving average computation
rows = nrow(covid);
for c in cols
    col = "mov_avg_"*c[1]*c[6]
    covid[:,col] = zeros(rows)
    for i in 7:rows
        covid[i,col] = sum(covid[i-6:i,c])/7
    end
end

#plot(1:rows,covid[:,:dailyconfirmed],label = "Non-smoothened \ndailyconfirmed")

#plot(1:rows,covid[:,:mov_avg_dc],label = "Smoothened \ndailyconfirmed",linecolor = "red")

#plot(1:rows,covid[:,:dailydeceased],label = "Non-smoothened \ndailydeceased")

#plot(1:rows,covid[:,:mov_avg_dd],label = "Smoothened \ndailydeceased",linecolor = "red")

#plot(1:rows,covid[:,:dailyrecovered],label = "non-smoothened \ndailyrecovered")

#plot(1:rows,covid[:,:mov_avg_dr],label = "Smoothened \ndailyrecovered",linecolor = "red")

#plot(1:rows,hcat(covid[:,:dailyconfirmed],covid[:,:mov_avg_dc]),label = ["dailyconfirmed" "Smoothened dc"])

#plot(1:rows,hcat(covid[:,:dailydeceased],covid[:,:mov_avg_dd]),label = ["dailydeceased" "Smoothened dd"])

#plot(1:rows,hcat(covid[:,:dailyrecovered],covid[:,:mov_avg_dr]),label = ["dailyrecovered" "Smoothened dr"])
