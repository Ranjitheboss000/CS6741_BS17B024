using Plots

out = []
for p = 0:0.01:1
    val = vcat(repeat(-1:-1,Int(round(p*100))),repeat(1:1,Int(round((1-p)*100))))
    bankrupt = 0;
    N = 10^5
    for _ = 1:N
        amount = 10
        coun = 0
        for _ = 1:20
            amount += rand(val)
            if amount == 0
                coun += 1
            end
        end
        if coun >= 1
            bankrupt += 1
        end
    end
    push!(out,bankrupt/N)
end
        

plot(0:0.01:1,out,label= false,ylabel= "Probability",xlabel= "p")
