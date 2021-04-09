using QuadGK,Distributions,Plots,PrettyTables,DataFrames,Distances

function kl_div(p,q,d)
    f(x) = p(x,d)*(log(p(x,d)/q(x)))
    return quadgk(f,-37,37)
end

q(x)= pdf(Normal(0,1),x)
p(x,d) = pdf(TDist(d),x)

kl_tab = DataFrame(DOF = Int[], KL_Divergence = Float64[])

for d =1:5
    push!(kl_tab,(d,kl_div(p,q,d)[1]))
end
pretty_table(kl_tab)