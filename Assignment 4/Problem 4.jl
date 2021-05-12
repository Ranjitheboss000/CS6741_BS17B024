function sample_size(D)
    """Given a distribution 'D', this function returns smallest sample size at which the approximation 
       made to the normal distribution derived from CLT matches the first four moments within 5% (wrt the Normal distribution).
    """
    n = 1
    flag = true
    if_suffice(D,m_N,v_N) = maximum([abs(mean(D)- m_N)/m_N, abs(var(D)- v_N)/v_N,abs(skewness(D)),abs(kurtosis(D))]) > 0.1
    # or simply  if_suffice(D) = maximum([abs(skewness(D)),abs(kurtosis))] 
    # anyway the mean and standard deviation will match by definition
    
    track_skew = [skewness(D)]
    track_kurtosis = [skewness(D)]
    
    while flag
        n += 1
        m_N = n*mean(D)
        v_N = n*var(D)
        
        if typeof(D) == Binomial{Float64}
            # Sum of n iid RV from Binomial(1,p) ~ Binomial(n,p)
            # In other words, Binomial(1,p) convolved n times ~ Binomial(n,p)
            n_convol = Binomial(n,succprob(D))
            
        elseif typeof(D) == Uniform{Float64}
            n_convol = [sum(rand(Uniform(),n)) for i = 1:10^6] # random sampling of size n
            
        elseif typeof(D) == Chisq{Float64}
            # Sum of n iid RV from Chisq(k) ~ Chisq(nk)
            # In other words, Chisq(k) convolved n times ~ Chisq(nk)
            k = params(D)[1]*n
            n_convol = Chisq(k)     
        end
        
        
        push!(track_skew,skewness(n_convol))
        push!(track_kurtosis,kurtosis(n_convol))
        flag = if_suffice(n_convol,m_N,v_N)
    end
    
    r = 1:n 
    if typeof(D) == Binomial{Float64}
        if succprob(D) == 0.01
            r = 50:n
        end 
    end
    
    plot(r,track_skew[r],label = "Skewness approaching 0.1 with increasing n",title = typeof(D))
    hline!([-0.1,0.1],line = :dash,label = "")
    display(plot!(r,track_kurtosis[r],label = "Kurtosis approaching 0.1 with increasing n"))
    
    return n
end

unif = sample_size(Uniform())
display("The smallest sample size for Uniform()")
display(unif)
chisq_3 = sample_size(Chisq(3))
display("The smallest sample size for Chisq(3)")
display(chisq_3)
binom_1 = sample_size(Binomial(1,0.01))
display("The smallest sample size for Binomial(1,0.01)")
display(binom_1)
binom_2 = sample_size(Binomial(1,0.5))
display("The smallest sample size for Binomial(1,0.5)")
display(binom_2)

