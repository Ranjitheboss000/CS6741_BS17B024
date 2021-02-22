function p_r(n::Int)
    n >= 0 || error("n must be non-negative")
    binomial(5,n)*((1/13)^n)*((12/13)^(5-n))
end

theoretical_Prob_replacement = [p_r(i) for i = 0:5]

println("\nWITH REPLACEMENT\n")
for n = 1:6
    println("Theoretical probability of picking $(n-1) Jacks (of any suit) when drawing 5 random cards is $(theoretical_Prob_replacement[n])")
end

function p_wr(x::Int)
    x >= 0 || error("n must be non-negative")
    x < 5 || error("n must not exceed 4")
    (binomial(4,x)*binomial(52-4,5-x))/(binomial(52,5))
end

theoretical_Prob_without_replacement= [p_wr(i) for i in 0:4]

println("\nWITHOUT REPLACEMENT\n")
for n = 1:5
    println("Theoretical probability of picking $(n-1) Jacks (of any suit) when drawing 5 random cards is $(theoretical_Prob_without_replacement[n])")
end
