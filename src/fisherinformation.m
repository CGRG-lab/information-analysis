function fim = fisherinformation(data)
%Calculate "Fisher Information" (¡ì [dp(s)/ds]^2 * ds/p(s))
%   fisherinformation(data)

pd = fitdist(data, 'Kernel');  % fit the kernel dendity function
p = @(s) min(max(pdf(pd, s), eps(0)), Inf);  % eps(0) <= p(s) <= Inf

STEP_SIZE = 1e-15;
dpds = @(s) imag(p(s + 1i * STEP_SIZE)) / STEP_SIZE;  % dp(s)/ds

% FIXME: The integral result is not stable

% 'ArrayValued' == false may be faster than 'ArrayValued' == true when number of data point > 30000
% integrand_func = @(s) (dpds(s).^2) ./ p(s);  % integrand function: [dp(s)/ds]^2 / p(s)
% fim = integral(integrand_func, min(data) - pd.BandWidth, max(data) + pd.BandWidth);

% `quadgk` is faster than `integral(..., 'ArrayValued', false)`
integrand_func = @(s) (dpds(s).^2) ./ p(s);  % integrand function: [dp(s)/ds]^2 / p(s)
fim = quadgk(integrand_func, min(data) - pd.BandWidth, max(data) + pd.BandWidth, 'MaxIntervalCount', 1000);

% Causes long execution time when number of data point > 30000 and 'ArrayValued' == true
% integrand_func = @(s) (dpds(s)^2) / p(s);  % integrand function: [dp(s)/ds]^2 / p(s)
% fim = integral(integrand_func, min(data) - pd.BandWidth, max(data) + pd.BandWidth, 'ArrayValued', true);


end
