n = 2;
alpha = 20;
alpha0 = 0.5;
Beta = 1;
gamma = -0.1;  % interesting values are -0.1, 0, 0.1

Tmax = 100;

SIZE = 12;

mn = @(x,i,j) -x(2*i - 1) + alpha ./ (1 + x(2*j).^n) + alpha0;
pn = @(x,i) -Beta*(x(2*i) - x(2*i-1)) + ...
                    gamma * (x( mod(2*i+SIZE/2 - 1,SIZE) + 1) - x(2*i));

%index 1    2   3   4  5    6   7   8   9  10  11  12
% x = [m1; p1; m2; p2; m3; p3; n1; q1; n2; q2; n3; q3]
% i/j = 1   1   2   2   3   3   4   4   5   5   6   6
cup_osc = @(t,x) [
       % repressilator one
       mn(x, 1,2);
       pn(x, 1);
       mn(x,2,3);
       pn(x,2);
       mn(x,3,1);
       pn(x,3);
       
       % repressilator two
       mn(x,4,5);
       pn(x,4);
       mn(x,5,6);
       pn(x,5);
       mn(x,6,4);
       pn(x,6);
];

x0 = 30*rand(12,1)
[T, Y] = ode45(cup_osc, [0, Tmax], x0);

%%
close all;

figure(1);

% Plot repressilator 1
subplot(211)
plot(T, Y(:, 1:2:5), '--'), hold on; % plot mRNA
plot(T, Y(:, 2:2:6), '-');          % plot protein
title("repressilator 1");
ylabel("Concentration");
legend({"m1", "m2", "m3", "p1", "p2", "p3"});
ylim([0,30]);
set(gca, 'Fontsize', 20);

% plot repressilator 2
subplot(212)
plot(T, Y(:, 7:2:11), '--'), hold on; % plot mRNA
plot(T, Y(:, 8:2:12), '-');          % plot protein
title("repressilator 2");
xlabel("Time (s)");
ylabel("Concentration");
legend({"n1", "n2", "n3", "q1", "q2", "q3"});
ylim([0,30])
set(gca, 'Fontsize', 20);

% plot corresponding protein species together
figure(2);

for i = 1:3
    subplot(3,2,2*i - 1);
    plot(T, Y(:,[2*i 2*i+6]), '-')
    legend({strcat("p_", num2str(i)), strcat("q_", num2str(i)) });
    ylabel("Concentration");
    if i == 1
       title("Concentrations of corresponding Proteins"); 
    elseif i==3
        xlabel("Time (s)");
    end
    set(gca, 'Fontsize', 15);
    ylim([0,30]);
    
    
    % plot difference as a function of time
    subplot(3,2,2*i);
    plot(T, Y(:, 2*i) - Y(:, 2*i + 6), '-k'), hold on;
    plot(T, zeros(1, length(T)), 'r-');
    legend(strcat("difference in p_", num2str(i), " - q_", num2str(i)));
    ylabel("Difference in concentration");
    
    if i == 1
       title("Difference in corresponding protein concentrations"); 
    elseif i==3
        xlabel("Time (s)");
    end
    set(gca, 'Fontsize', 15);
    ylim([-40,40]);
end


%% Problem 2: Systems Biology and Network Motifs

F = @(x,thresh) x >= thresh;
Z = @(t) (t >= 2).*(t <= 4);

% a)
z_thresh = 0.5;
y_thresh = 0.5;
x_thresh = 0.5;

eqns_a = @(t,x) [
  (1 - (1 - F(Z(t), z_thresh)) .* ( 1 - F(x(2), y_thresh))) - x(1);
  (1 - (1 - F(Z(t), z_thresh)) .* ( 1 - F(x(1), x_thresh))) - x(2);
  
  % This ^ is equivalent to the following:
  %max(Z above threshold, Y above threshold) - x(1); % X
  %max(Z above threshold, X above threshold) - x(2); % Y
];

x0 = [0,0];
[T, Y] = ode45(eqns_a, [0, 6], x0);

figure(1);
subplot(311);
plot(T, Z(T),  'r');
legend('Z');
ylabel("Relative Activity");
set(gca, 'fontsize', 20);


subplot(312);
plot(T, Y(:,1),  'b');
legend('X');
ylabel("Relative Activity");
set(gca, 'fontsize', 20);


subplot(313)
plot(T, Y(:,2),  'b');
legend('Y');
xlabel("Time (s)");
ylabel("Relative Activity");
set(gca, 'fontsize', 20);

% b)
z_thresh = 1;
x_thresh = 0.5;
y_thresh = 0.2;

eqns_b = @(t,x) [
    (1 - (1- F(Z(t), z_thresh)).* F(x(2), y_thresh)) - x(1);
    % This ^ is equivalent to the following:
    % max(Z above threshold, Y below threshold) - x(1); % X
    
    (1 - F(Z(t), z_thresh)).*(1 - F(x(1), x_thresh)) - x(2);
    % This ^ is equivalent to:
    % min (Z below threshold, X below threshold) - x(2);
];

x0 = [0, 1];
[T, Y] = ode45(eqns_b, [0, 6], x0);

figure(2);
subplot(311);
plot(T, Z(T),  'r');
legend('Z');
ylabel("Relative Activity");
set(gca, 'fontsize', 20);

subplot(312);
plot(T, Y(:,1),  'b');
legend('X');
ylabel("Relative Activity");
set(gca, 'fontsize', 20);

subplot(313)
plot(T, Y(:,2),  'b');
legend('Y');
xlabel("Time (s)");
ylabel("Relative Activity");
set(gca, 'fontsize', 20);
