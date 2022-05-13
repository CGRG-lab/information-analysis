clear; clc; close;

suite = {'test_informationanalysis'};
result = runtests(suite);
rt = table(result);
display(rt);