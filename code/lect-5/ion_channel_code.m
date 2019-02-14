data = load("SequenceOfCurrentsDatamatrix.dat");

means = mean(data,2);
variance = var(data, 0, 2);

% polynomial of form Var(I)/Mean(I) = i - mean(I) / N

VoverM = variance./means;
coeff = polyfit(means, VoverM,1);

i = coeff(2)
N = -1/coeff(1) 