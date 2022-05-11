function tests = test_informationanalysis
tests = functiontests(localfunctions);
end

function test_fisherinformation(testCase)
num_points = 10000;

standard_deviation = 1;
theoretical_fim = 1 / standard_deviation.^2;
relative_tolerance = 0.03;
data = randn(num_points, 1);

tic;
fim = fisherinformation(data);
toc;

fprintf('relative error with theoretical fim: %f\n', abs(fim - theoretical_fim) / abs(theoretical_fim))
verifyLessThanOrEqual(testCase, abs(fim - theoretical_fim) / abs(theoretical_fim), relative_tolerance)
end
