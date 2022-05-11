# information-analysis
Implementation of Shannon entropy and Fisher information with Matlab.

## Matlab and toolbox version
- MATLAB 9.7 (MATLAB R2019b)
- Statistics and Machine Learning Toolbox 11.6

## Develop
1. Open `information-analysis.prj` in the Matlab IDE, this will open a new environment for information-analysis project (i.e. add new search paths when opening `prj` file, remove paths when closing `prj` file)
1. Modify source code in `src` directory.
1. Modify m-files in `test` directory to fit your test cases.
1. Run `run_all_tests` located in the `test` directory to run the tests

## Note
Since some functions are not supported by automatic differentiation, and finite difference increase round-off error (but decrease truncation error) when using small step size, we use complex step differentiation.

## References:
- https://blogs.mathworks.com/cleve/2013/10/14/complex-step-differentiation/
