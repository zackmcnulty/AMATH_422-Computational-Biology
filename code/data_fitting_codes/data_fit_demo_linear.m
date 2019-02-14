function data_fit_demo_linear

%Note this whole .m file needs to be a "dummy" function file so that
% can use nested functions below
    

load sample_data_1.dat

%this data is Y=X+randn
xlist=sample_data_1(:,1); 
ylist=sample_data_1(:,2); 

%want to fit y as a function of x:  y_list_fit = m*xlist + b
%sse is summed square error
m_initial_guess=1;
b_initial_guess=1;
p0=[m_initial_guess,b_initial_guess];

p_fit=fminsearch( @(p) sse_linear_fit(xlist,ylist,p) , p0)

m_fit=p_fit(1);
b_fit=p_fit(2);

%plot the data, and our fit
figure
set(gca,'FontSize',20)
plot(xlist,ylist,'o'); hold on
plot(xlist,m_fit*xlist+b_fit,'LineWidth',2);
xlabel('x');ylabel('y')


residual_list= m_fit*xlist+b_fit - (ylist);
figure
set(gca,'FontSize',16)
subplot(211)
set(gca,'FontSize',16)
hist(residual_list,20);
title('Histogram of residuals')
subplot(212)
set(gca,'FontSize',16)
[N,H]=hist(residual_list,20);
bar(H,log(N)); hold on
title('Histogram of LOG OF residuals')



%%%%%%%%%%%%%%%%%%%%%
% define subfunctions

%---------------------------------
function f=sse_linear_fit(xlist,ylist,p)
%attempt to fit ylist to equation ylist=m*xlist+b
%compute summed square error

m=p(1) ; b=p(2) ;

ylist_fit=m*xlist+b;
f=sum( (ylist_fit-ylist).^2 );