using QuadGK,Distributions,Plots,PrettyTables,DataFrames,Distances

#Inspired from R´enyi formulation
function convolve_uniform(x,a,b,n)
    if n*a <= x <= n*b
        return (1/(factorial(n-1)*((b-a)^n)))*sum([((-1)^i)*binomial(n,Int(i))*(x-n*a-i*(b-a))^(n-1) for i = 0:floor((x-n*a)/(b-a))])
    else
        return 0
    end
end         

# function normal_approx(a,b,n)
#     w(x,sigma) = pdf(Normal(n/2,sigma),x)
#     convf(x) = convolve_uniform(x,a,b,n)
#     sig = 0:0.001:2
#     range = 0:0.01:n
#     X = convf.(range)
#     Y(sigma) = w.(range,sigma)
#     err = [sum((Y(i).-X).^2) for i = sig]
#     return Normal(n/2,sig[findall(x->x==minimum(err), err)][1])
# end
# The above method is a naive method

function normal_approx(a,b,n)
    # By CLT
    return Normal(n/2,sqrt(n)*std(Uniform()))
end

f(x,n) = convolve_uniform(x,0,1,n)*log(convolve_uniform(x,0,1,n)/pdf(normal_approx(0,1,n),x))

a,b = 0,1

distances = DataFrame(numberofConvolutions = Int[], KL_Divergence = Float64[])
for n = 2:10
    g(x) = f(x,n)
    if n < 6
        push!(distances,(n,quadgk(g,0,n)[1]))
    else
        push!(distances,(n,quadgk(g,0.25,n-0.25)[1]))
    end
    range = 0:0.01:n
    C(x) = convolve_uniform(x,0,1,n)
    plt = plot(range,[C.(range),pdf(normal_approx(0,1,n),range)],reuse = false,label = ["P-"*string(n)*" times convoluted U(0,1)" "Q- Approximated Normal"]);
    display(plt)  
end

pretty_table(distances)  

plt = plot(2:10,distances[:,:KL_Divergence],marker = :dot,linecolor = :red,label = false,title = "KL Divergence with n ranging from 2 to 10",reuse = false);
display(plt)
    
