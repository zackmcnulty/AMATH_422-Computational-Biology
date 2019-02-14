% Plot nullclines
clear all

%First, define parameters:
I1= 2.2;
I2= 2.1 ;
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


hold on
plot(y1list,0*y1list,':') ; plot(0*y2list,y2list,':')
axis([y1min y1max y2min y2max])
set(gca,'Fontsize',18)
