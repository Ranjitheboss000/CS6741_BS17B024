using Random, Plots

deck = ["K♠","Q♠","J♠","A♠","2♠","3♠","4♠","5♠","6♠","7♠","8♠","9♠","10♠",
        "K♥","Q♥","J♥","A♥","2♥","3♥","4♥","5♥","6♥","7♥","8♥","9♥","10♥",
        "K♦","Q♦","J♦","A♦","2♦","3♦","4♦","5♦","6♦","7♦","8♦","9♦","10♦",
        "K♣","Q♣","J♣","A♣","2♣","3♣","4♣","5♣","6♣","7♣","8♣","9♣","10♣"];


Random.seed!(0)
N = 10^(parse(Int,readline()));

experimental_replacement = [sum([sum([occursin("J",rand(deck)) for i in 1:5])==n for i in 1:N])/N for n = 0:4];

println("\nWITH REPLACEMENT\n")
for n = 1:5
    println("Experimentally computated probability of picking $(n-1) Jacks (of any suit) when drawing 5 random cards is $(experimental_replacement[n])")
end

function exp_wr(y)
    counter = 0
    for i in 1:N
        temp_deck = copy(deck)
        picked = []
        counter_1 = 0
        for i in 1:5
            card = rand(temp_deck)
            if occursin("J",card)
                counter_1 += 1
            end
            deleteat!(temp_deck, findfirst(x-> x == card, temp_deck))
        end
        if counter_1 == y
            counter += 1
        end
    end
    return counter/N
end
    


experimental_without_replacement = [exp_wr(i) for i in 0:4];

println("\nWITHOUT REPLACEMENT\n")
for n = 1:5
    println("Experimentally computated probability of picking $(n-1) Jacks (of any suit) when drawing 5 random cards is $(experimental_without_replacement[n])")
end


