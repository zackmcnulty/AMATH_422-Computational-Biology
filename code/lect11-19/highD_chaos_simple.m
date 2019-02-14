% highD_chaos.m
%
% A firing-rate model network with coupled excitatory and inhibitory units
% whose connections are strong and sparsely random, designed to be in the 
% regime that produces chaotic activity.
%
%   The circuit is simulated twice, with the only difference in the initial
%   conditions of a single unit shifted by 1 in 10^14 of a Hz.
%
%   This code was used to produce Figures 7.13 and 7.14 in the textbook:
%   An Introductory Course in Computational Neuroscience,
%   by Paul Miller (Brandeis University, 2017)
%
% ... edited by ESB to make into simple 'canonical' network
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;                      % clear all prior variables and parameters from memory

%% Set up the network parameters

% The next two lines set the random number generator to reproducibly use
% the same seed. This allows for regeneration of the identical circuit
% which is designated with random connectivity.
s = RandStream('mt19937ar','Seed',1)
RandStream.setGlobalStream(s);

N = 200;           % Number of units              
g = 2/sqrt(N);  %std dev of connection strength

W = g*randn(N);

eigs_of_W = eig(W);

figure(3)
subplot(211) 
imagesc(W)
title('W')
colorbar
axis square;

subplot(212)
plot(eigs_of_W,'o')
axis square
title('eigenvalues of W')


% firing rate curve  inline function
rate_fn = @(x) tanh(x);



%% Simulation parameters
dt = 0.01;                   
tmax = 300;                       % maximum simulation time
t = 0:dt:tmax;                  % vector of time points
Nt = length(t);                 % number of time points

tau = 1;                   % time constant
exp_dt_tau = exp(-dt/tau);    % used in the exponential Euler method

r= double(zeros(N,Nt));     % matrix of rates 

r(:,1) = 1-2/N*[0:N-1]'; % initialize units with uniform spread of rates between -1 and 1

%% Now simulate through time (first simulation)
for i = 2:Nt
    
    % Use the exponential Euler method for integration
    I = W*r(:,i-1);    % input current 
    rinf = rate_fn(I);                       % send input through f-I curve
    r(:,i) = rinf + (r(:,i-1) - rinf)*exp_dt_tau;    % update rates
    
    
end

%% Plot the results of the first simulation, selecting three units for visualization
figure(1)
clf
subplot(2,3,1)
plot(t,r(1,:),'k')
hold on
ylabel('Activity (Hz)')
title('unit #1')
subplot(2,3,2)
plot(t,r(50,:),'k')
title('unit #50')
hold on
subplot(2,3,3)
plot(t,r(100,:),'k')
hold on
title('unit #100')
drawnow

% %% Now repeat the process with a miniscule difference in initial conditions 
r2= double(zeros(N,Nt));     % matrix of rates 
r2(:,1) = 1-2/N*[0:N-1]'; % initialize units with uniform spread of rates between -1 and 1
r2(1,1) = 1e-3;       % This is the change in initial conditions from zero



%% Now simulate through time (second simulation)
for i = 2:Nt
    
    % Use the exponential Euler method for integration
    I = W*r2(:,i-1);    % input current 
    rinf = rate_fn(I);                       % send input through f-I curve
    r2(:,i) = rinf + (r2(:,i-1) - rinf)*exp_dt_tau;    % update rates
    
    
end

% %% Now plot results from the second simulation as black
figure(1)
subplot(2,3,4)
plot(t,r2(1,:),'k')
hold on
ylabel('Activity (Hz)')
title('unit #1')
subplot(2,3,5)
plot(t,r2(50,:),'k')
title('unit #50')
hold on
subplot(2,3,6)
plot(t,r2(100,:),'k')
hold on
title('unit #100')
drawnow
 hold on
 xlabel('Time (sec)')

 % 
% %% Finally produce Figure 7.14 in the textbook, by measuring the 
% %  time-evolution of the difference in firing rates due to the tiny change 
% %  in initial conditions.
figure(2)
clf
subplot('Position',[0.2 0.6 0.75 0.32])
plot(t,mean(abs(r2-r)),'k')      % absolute difference in rates
%axis([0 0.5 0 60])
ylabel('Mean abs(\Deltar)')

subplot('Position',[0.2 0.12 0.75 0.32])
plot(t,log(mean(abs(r2-r))),'k')   % plot on a log scale to see exponenital rise
ylabel('Log[Mean abs(\Deltar)]')
xlabel('Time (sec)')
%axis([0 0.5 -15 2.5])


