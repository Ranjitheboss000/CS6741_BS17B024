using Plots

atleast_10 = []
for p = 0:0.01:1
    val = vcat(repeat(-1:-1,Int(round(p*100))),repeat(1:1,Int(round((1-p)*100))))
    no_bankrupt = [];
    N = 10^5
    for _ = 1:N
        amount = 10
        coun = 0
        outcome = []
        for _ = 1:20
            k = rand(val)
            push!(outcome,k)
            amount += k
            if amount == 0
                coun += 1
            end
        end
        if coun == 0
            push!(no_bankrupt,sum(outcome))
        end
    end
    if length(no_bankrupt) != 0
        push!(atleast_10,sum(no_bankrupt.>=0)/length(no_bankrupt))
    else
        push!(atleast_10,0)
    end
end
        

plot(0:0.01:1,atleast_10,ylabel = "Probability", xlabel = "p",label = false)
