%% Nonlinear Cell Reproduction Workshop

%% Task 1
p = 0.75;
n0 = 1000;
tsteps = 10000;
K = 2000;

n_t = zeros(1,tsteps + 1);
n_t(1) = n0;

for i = 2:length(n_t)
   n_t(i) = 4*p*n_t(i-1)*(1-n_t(i-1) / K);
end

plot(n_t, 'r.');
xlabel("time/generation number");
ylabel("Population Size");

% all times that n_t is > 1400
result = find(n_t > 1400);

%% Task 2 & 3
close all; clc;

npoints = 100;

for p = linspace(0,1,1000)
    n0 = 1000;
    tsteps = 1000;
    K = 2000;

    n_t = zeros(1,tsteps + 1);
    n_t(1) = n0;

    for i = 2:length(n_t)
        n_t(i) = 4*p*n_t(i-1)*(1-n_t(i-1) / K);
    end
    
    nvals = n_t(end - npoints+1:end);
    
    % checks for periodicity

    
    % the ~= 1 condition filters out constant solutions which are
    % technically periodic, but not the periodicity we are interested in
    if length(nvals) ~= length(unique(nvals))
        color = 'r';
    else
        color = 'k';
    end
    
    plot(p*ones(1,npoints), nvals, 'k.', 'Color', color);
    hold on;
end

xlabel("p");
ylabel("n");

%% Task 3

% A solution f(t) is periodic in time if there exists a period tau such that
% f(t) = f(t + tau) for all values of t.

% Thus to check for periodic solutions, I will check if there are f(t)
% values that are repeated, and if the time period separating these
% repeated values remains consistent.
