% data has to be column vector (N by 1)
% Modify 'MaxIntervalCount' or 'AbsoluteTolerance' (maybe
% 'RelativeTolerance' in quadgk) if it is too slow.
function fim = fisherinformation(data)
%Calculate "Fisher Information" (¡ì [dp(s)/ds]^2 * ds/p(s))
%   fisherinformation(data)

pd = fitdist(data, 'Kernel');  % fit the kernel dendity function
p = @(s) min(max(pdf(pd, s), eps(0)), Inf);  % eps(0) <= p(s) <= Inf

STEP_SIZE = sqrt(8*eps());  % http://www.johnlapeyre.com/posts/complex-step-differentiation/
dpds = @(s) (p(s + STEP_SIZE) - p(s - STEP_SIZE)) / (2 * STEP_SIZE);  % dp(s)/ds

% 'ArrayValued' == false may be faster than 'ArrayValued' == true when number of data point > 30000
% integrand_func = @(s) (dpds(s).^2) ./ p(s);  % integrand function: [dp(s)/ds]^2 / p(s)
% fim = integral(integrand_func, min(data) - pd.BandWidth, max(data) + pd.BandWidth);

% `quadgk` is faster than `integral(..., 'ArrayValued', false)`

integrand_func = @(s) (dpds(s).^2) ./ p(s);  % integrand function: [dp(s)/ds]^2 / p(s)
warning('off','MATLAB:quadgk:MaxIntervalCountReached');
fim = quadgk(integrand_func, min(data) - pd.BandWidth, max(data) + pd.BandWidth, 'MaxIntervalCount', 1000);
warning('on','MATLAB:quadgk:MaxIntervalCountReached'); % if 'MaxIntervalCount' 
% is reached but accepted tolerance has not been reached, then warning.
% Warning disabled here.

% Causes long execution time when number of data point > 30000 and 'ArrayValued' == true
% integrand_func = @(s) (dpds(s)^2) / p(s);  % integrand function: [dp(s)/ds]^2 / p(s)
% fim = integral(integrand_func, min(data) - pd.BandWidth, max(data) + pd.BandWidth, 'ArrayValued', true);
end
