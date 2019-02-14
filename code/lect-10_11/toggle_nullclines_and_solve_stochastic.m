clear all

set(0,'defaultTextFontSize',14)
set(0,'DefaultAxesFontSize',14)

warning off

ulist=0:.2:4;
vlist=0:.2:4;


%SET PARAMETERS
a=2;
b=3;
p=[a,b];



%PLOT NULLCLINES
figure
set(gca,'FontSize',20)
vlist_for_u_nullcline=a./(1+vlist.^b) ;
ulist_for_v_nullcline=a./(1+ulist.^b) ;

plot(ulist,vlist_for_u_nullcline,':','Linewidth',2); hold on
plot(ulist_for_v_nullcline,vlist,'Linewidth',2); hold on

axis([0 max(ulist)+.2 0 max(vlist)+.2])
xlabel('u'); ylabel('v')


%Set initial state
u_initial=0 ;
v_initial=0.5 ;
initial_state=[u_initial ; v_initial];

%%%% Plot solutions
[T,X] = ode45(@toggle2_odefun,[0 1000],initial_state,[],p);

plot(X(:,1),X(:,2),'-','LineWidth',6)
title('Noise-free:  Light lines are nullclines; heavy line is trajec.')



%_________________________________


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Now implement STOCHASTIC euler method integration

%gaussian white noise with amplitude eps
eps=0.5;

%first, define where my trajectory starts at time 0
u_0=0.0;   v_0=0.1;
initial_state=[u_0 ; v_0];



%number of timesteps of size h I need to take to get to Tmax
h=0.01 ; %timestep
Tmax=500;
numsteps=Tmax/h;

%Make a dummy matrix that is going to hold my trajectory.
%Each column is the solution at one timestep 
%col 1 is initial state, col 2 is timestep h, col 2 is timestep h+1, ...
%Note that the columns are of length 2:  first element is u(t), second
%element is v(t)
state_matrix=zeros(2,numsteps);  


%all that I know is the initial value of the state, so "set" that
state_matrix(:,1)=initial_state;

%p is vector of parameters:  
p=[a,b];

%now, do the STOCHASTIC euler method!
for n=1:(numsteps-1)
    state_matrix(:,n+1)=state_matrix(:,n) + h*toggle2_odefun(0,state_matrix(:,n),p) + eps*sqrt(h)*randn(2,1) ;
end




figure
tlist=0:h:(Tmax-h);
set(gca,'FontSize',16)
plot(tlist,state_matrix(1,:),'r','LineWidth',2); hold on
plot(tlist,state_matrix(2,:),'k','LineWidth',2); hold on
legend('state 1','state 2')
xlabel('time')

%%%%%%%%%%%%%%%%%%%%%%%%%
anim_flag=1;

if anim_flag
%simple animation
%plot nullclines as before
figure
set(gca,'FontSize',16)
plot(ulist,vlist_for_u_nullcline,':','Linewidth',2); hold on
plot(vlist_for_u_nullcline,vlist,'Linewidth',2); hold on

axis([0 max(ulist)+.2 0 max(vlist)+.2])
xlabel('u'); ylabel('v')


%add a moving dot with current value of trajectory
%to the direction field plot
%note that I want to plot on horizontal axis u(t), on vertical axis v(t),
%so I pick out the rows of state_matrix and plot them against eachother

for n=1:(numsteps-1)
    plot(state_matrix(1,n),state_matrix(2,n),'.','EraseMode','xor','MarkerSize',15)
    drawnow
end
    
end    