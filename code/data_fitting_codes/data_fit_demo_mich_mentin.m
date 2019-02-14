function data_fit_demo_mich_mentin

%Note this whole .m file needs to be a "dummy" function file so that
% can use nested functions below


% Looking at the residuals, we do not see guassian distributed error, which
% suggests that Sum Squared Errors is not the best choice for fitting our
% model. We 
    

load EggRatioData.dat

%this data is Y=X+randn
xlist=EggRatioData(:,1); 
ylist=EggRatioData(:,2); 

%want to fit y as a function of x:  y_list_fit = V*xlist./(K+xlist)
%sse is summed square error
V_initial_guess=1;
K_initial_guess=1;
p0=[V_initial_guess,K_initial_guess];

p_fit=fminsearch( @(p) sse_mich_mentin_fit(xlist,ylist,p) , p0)

V_fit=p_fit(1);
K_fit=p_fit(2);

%plot the data, and our fit
figure
set(gca,'FontSize',16)
plot(xlist,ylist,'o'); hold on
plot(xlist,V_fit*xlist./(K_fit+xlist),'.');
xlabel('x');ylabel('y')

residual_list=(V_fit*xlist./(K_fit+xlist))- ylist;
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
function f=sse_mich_mentin_fit(xlist,ylist,p)
%attempt to fit ylist to equation ylist=V*xlist/(xlist+K)
%compute summed square error

V=p(1) ; K=p(2) ;

ylist_fit=V*xlist./(K+xlist);
f=sum( (ylist_fit-ylist).^2 );