% Plot nullclines
clear all

%First, define parameters:
I1= 2.2;
I2=2.1 ;
beta=1 ;
g=8; b=2 ;

%-------------------------
%y2=0 nullcline

%let y1 range between minimum and maximum values
y1min=-.5 ; y1max=1.2 ; yspacing=0.01;
y1list= y1min:yspacing:y1max ;

%define a matched list of y2 values:
y2list_stim_cline=f(I2-beta*y1list,g,b) ;

%plot the y2 nullcline!
figure; set(gca,'FontSize',16)
plot(y1list,y2list_stim_cline,'b-','LineWidth',3) ; hold on
xlabel('y1'); ylabel('y2')

%-------------------------
%now repeat for the y1=0 nullcline

y2min=-.5 ; y2max=1.2 ; yspacing=0.01;
y2list= y2min:yspacing:y2max ;

y1list_stim_cline=f(I1-beta*y2list,g,b) ;

%plot the y2 nullcline!
plot(y1list_stim_cline,y2list,'r-','LineWidth',3) ; hold on

%add axes
hold on
plot(y1list,0*y1list,':') ; plot(0*y2list,y2list,':')
axis([y1min y1max y2min y2max])



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Now implement STOCHASTIC euler method integration

%gaussian white noise with amplitude eps
eps=0.4;

%first, define where my trajectory starts at time 0
y1_0=0.0;   y2_0=0.1;
initial_state=[y1_0 ; y2_0];



%number of timesteps of size h I need to take to get to Tmax
h=0.01 ; %timestep
Tmax=20;
numsteps=Tmax/h;

%Make a dummy matrix that is going to hold my trajectory.
%Each column is the solution at one timestep 
%col 1 is initial state, col 2 is timestep h, col 2 is timestep h+1, ...
%Note that the columns are of length 2:  first element is y1(t), second
%element is y2(t)
state_matrix=zeros(2,numsteps);  


%all that I know is the initial value of the state, so "set" that
state_matrix(:,1)=initial_state;

%p is vector of parameters:  
p=[I1 I2 beta g b eps];

%now, do the STOCHASTIC euler method!
for n=1:(numsteps-1)
    state_matrix(:,n+1)=state_matrix(:,n) + h*two_cell_neural_network_odefun(0,state_matrix(:,n),p) + eps*sqrt(h)*randn(2,1) ;
end

%finally, add a plot of my trajectory to the direction field plot
%note that I want to plot on horizontal axis x1(t), on vertical axis x2(t),
%so I pick out the rows of state_matrix and plot them against eachother
plot(state_matrix(1,:),state_matrix(2,:),'k','LineWidth',2)


%simple animation
figure
%plot nullclines as before
set(gca,'FontSize',16)
plot(y1list_stim_cline,y2list,'r-','LineWidth',3) ; hold on
plot(y1list,y2list_stim_cline,'b-','LineWidth',3) ; 
xlabel('y1'); ylabel('y2')
plot(y1list,0*y1list,':') ; plot(0*y2list,y2list,':')
axis([y1min y1max y2min y2max])

%add a moving dot with current value of trajectory

for n=1:(numsteps-1)
    plot(state_matrix(1,n),state_matrix(2,n),'.','EraseMode','xor','MarkerSize',15)
    drawnow
end
    
    