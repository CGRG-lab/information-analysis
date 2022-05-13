function tests = test_informationanalysis
tests = functiontests(localfunctions);
end

function test_fisherinformation(testCase)
fprintf('    Running test_fisherinformation\n');

num_points = 10000;
standard_deviation = 1;
theoretical_fim = 1 / standard_deviation.^2;
relative_tolerance = 0.03;
data = randn(num_points, 1);
fim = fisherinformation(data);

fprintf('    relative error with theoretical fim: %f\n', abs(fim - theoretical_fim) / abs(theoretical_fim))
verifyLessThanOrEqual(testCase, abs(fim - theoretical_fim) / abs(theoretical_fim), relative_tolerance)
end

function test_shannonentropy(testCase)
fprintf('    Running test_shannonentropy\n');

num_points = 10000;
standard_deviation = 1;
theoretical_se = 1 / 2 * log(2 * pi * exp(1) * standard_deviation^2);
relative_tolerance = 0.03;
data = randn(num_points, 1);
se = shannonentropy(data);

fprintf('    relative error with theoretical se: %f\n', abs(se - theoretical_se) / abs(theoretical_se))
verifyLessThanOrEqual(testCase, abs(se - theoretical_se) / abs(theoretical_se), relative_tolerance)
end

