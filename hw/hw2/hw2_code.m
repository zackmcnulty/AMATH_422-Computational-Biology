clear all; close all; clc;
% Problem 3: Simulating Markov Chains and Dwell times
% Part 2)
A = [0.98 0.1 0;
    0.02 0.7  0.05;
    0 0.2 0.95];


numsteps = 100000; %number of timesteps simulated
 
%list of states on this realization. xlist(k)=1 means in state 1 at
%timestep k, etc
states=zeros(1,numsteps);  

%initial state
states(1)=1;

for k=1:numsteps-1

    %uniformly distributed random number - will use for transitions from
    %timestep k to current timestep k+1
    rd=rand ;
    
    % take the column corresponding to our current state
    probs = A(:, states(k));
    intervals = cumsum(probs);
    
    new_state = 1;
    while rd > intervals(new_state)
       new_state = new_state + 1; 
    end

    states(k+1) = new_state;
end

%---- Plots state over time
figure(1)
set(gca,'FontSize',18)
plot(1:numsteps,states,'.','MarkerSize',20)
xlabel('timestep','FontSize',16)
ylabel('state','FontSize',16)


% Part 3)
% 1 corresponds to open, 0 corresponds to closed
reduced_states = (states == 3);

% Part 4): Calculate Dwell times
% dwell time = number of steps where you stay in same state
start_state = reduced_states(1);

% what indices do I swap states in?
swap_indices = [1, find(diff(reduced_states)), numsteps];

% number of indices between the times I swap states
dwell_times = diff(swap_indices);

% Since there are only two overall states, open/closed, every state change
% is either open -> closed or vice versa.
if start_state == 0
    closed_dwell_times = dwell_times(1:2:end);
else
    closed_dwell_times = dwell_times(2:2:end);
end

num_bins = 40;

figure(2)
hist(closed_dwell_times, num_bins)
xlabel("Dwell Times");
ylabel("Frequency");
title('Ion Channel Dwell Times');



figure(3)
[N, X] = hist(closed_dwell_times, num_bins);
expfit = fit(X.', N.', 'exp1'); % fit to first degree exponential
expfit2 = fit(X.', N.', 'exp2'); % fit to second degree exponential

plot(X, N, 'r.', 'markersize', 20), hold on;
plot(expfit, 'b-'), hold on;
plot(expfit2, 'g-')
ylim([0,1.1*max(N)])
legend({'dwell times', 'single exponential fit', 'two exponential fit'})
set(gca, 'fontsize', 20);
title("Fitting Exponential Curves to our dwell times");
xlabel("Dwell times");
ylabel("Frequency");

%% Problem 4: Simulating Markov Chains and Neural Spiking
clear all; close all; clc;
IN = [0.98 0.1 0;
    0.02 0.7  0.05;
    0 0.2 0.95];

OUT = [0.9 0.1 0;
       0.1 0.6 0.1; 
        0 0.3 0.9]; 
    
N_in = 100;
N_out = 50;
T_range = 0:100;



[V_in, D_in] = eig(IN)

% we see third eigenvalue = 1, so our stable distribution is third column
% of V, normalized so it sums to one.
pi_in = V_in(:,3)/sum(V_in(:,3))

[V_out, D_out] = eig(OUT)

% We see third eigenvalue = 1, so our stable distribution is the third
% column of V, normalized so it sums to one.
pi_out = V_out(:,3) / sum(V_out(:,3))

p_in = pi_in(3);
p_out = pi_out(3);


% Calculating using math
probs = zeros(1, length(T_range));

for index = 1:length(T_range)
    T = T_range(index);
    probs(index) = sum(binopdf(T+1+(0:N_in-T-1), N_in, p_in) ...
        .*binocdf(0:N_in-T-1, N_out, p_out));
end

% Calculating using coin tosses

% T_range = 0:100
trials = 10000;
probs2 = zeros(1,length(T_range));
for index = 1:length(T_range)
    T = T_range(index);
    
    n_ins = sum(rand(N_in,trials) <= p_in);
    n_outs = sum(rand(N_out,trials) <= p_out);
    
    probs2(index) = sum(n_ins - n_outs > T) / trials;
end


figure(4)
plot(T_range, probs, 'r-', 'linewidth', 3), hold on;
plot(T_range, probs2, 'b.', 'markersize', 12), hold off;
legend({'calculated', 'coin flip simulation'})

ylim([0,1])
xlabel('Threshold (T)');
ylabel('Probability of Spike');
set(gca, 'fontsize', 20);
title(strcat('N_{in} = ', num2str(N_in), ' and N_{out} = ', num2str(N_out)));

% simulation verifies our mathematical results


% Repeat this for Ninward = 10, Noutward = 5 and for Ninward = 1000, Noutward = 500, 
% and for any other combinations of values you wish 
