using Plots,DataFrames,CSV,Dates,PrettyTables,FreqTables,Statistics,HTTP,JSON,JSON3

p = HTTP.get("https://api.covid19india.org/data.json");
j = JSON.Parser.parse(String(p.body));
j = j["cases_time_series"];
covid = vcat(DataFrame.(j)...);

show(covid,allcols=true,show_row_number = false)

calendar = Dict("01" => "January", "02" => "February", "03" => "March","04" => "April", "05" => "May", "06"=> "June",
                "07" => "July", "08"=> "August", "09"=> "September","10"=> "October","11" => "November", "12" => "December");

monY(x) = calendar[x[6:7]]*" "*x[1:4]

transform!(covid,:dateymd => ByRow(monY) => :monthYear);

cols = ["dailyconfirmed","dailydeceased","dailyrecovered"];
for c in cols
    covid[!,c] = parse.(Int,covid[!,c])
end

gTab = groupby(covid, :monthYear);

println("\n")
pretty_table(combine(gTab,cols .=> sum .=> ["monthly_"*g[6:end] for g in cols ]))

#First six values are assigned zero in the dataframe during moving average computation
rows = nrow(covid);
for c in cols
    col = "mov_avg_"*c[1]*c[6]
    covid[:,col] = zeros(rows)
    for i in 7:rows
        covid[i,col] = sum(covid[i-6:i,c])/7
    end
end

# plot(1:rows,covid[:,:dailyconfirmed],label = "Non-smoothened \ndailyconfirmed",xlabel = "Days",ylabel = "Counts")

# plot(1:rows,covid[:,:mov_avg_dc],label = "Smoothened \ndailyconfirmed",linecolor = "red",xlabel = "Days",ylabel = "Counts")

# plot(1:rows,covid[:,:dailydeceased],label = "Non-smoothened \ndailydeceased",xlabel = "Days",ylabel = "Counts")

# plot(1:rows,covid[:,:mov_avg_dd],label = "Smoothened \ndailydeceased",linecolor = "red",xlabel = "Days",ylabel = "Counts")

# plot(1:rows,covid[:,:dailyrecovered],label = "non-smoothened \ndailyrecovered",xlabel = "Days",ylabel = "Counts")

# plot(1:rows,covid[:,:mov_avg_dr],label = "Smoothened \ndailyrecovered",linecolor = "red",xlabel = "Days",ylabel = "Counts")

# plot(1:rows,hcat(covid[:,:dailyconfirmed],covid[:,:mov_avg_dc]),label = ["dailyconfirmed" "Smoothened dc"],xlabel = "Days",ylabel = "Counts")

# plot(1:rows,hcat(covid[:,:dailydeceased],covid[:,:mov_avg_dd]),label = ["dailydeceased" "Smoothened dd"],xlabel = "Days",ylabel = "Counts")

# plot(1:rows,hcat(covid[:,:dailyrecovered],covid[:,:mov_avg_dr]),label = ["dailyrecovered" "Smoothened dr"],xlabel = "Days",ylabel = "Counts")
