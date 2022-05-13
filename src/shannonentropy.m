function se = shannonentropy(data)
%Calculate "Shannon Entropy" (¡ì - p(s) * log(p(s)) * ds)
%   shannonentropy(data)

pd = fitdist(data, 'Kernel');  % fit the kernel dendity function
p = @(s) min(max(pdf(pd, s), eps(0)), Inf);  % eps(0) <= p(s) <= Inf

integrand_func = @(s) p(s) .* log(p(s));  % integrand function: p(s) * log(p(s))
se = -1 * integral(integrand_func, min(data) - pd.BandWidth, max(data) + pd.BandWidth);
end
