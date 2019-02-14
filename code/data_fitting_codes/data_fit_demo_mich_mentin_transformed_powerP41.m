function data_fit_demo_mich_mentin_transformed_powerP41

%Note this whole .m file needs to be a "dummy" function file so that
% can use nested functions below
    

load EggRatioData.dat

%this data is Y=X+randn
xlist=EggRatioData(:,1); 
ylist=EggRatioData(:,2); 


%want to fit (y).^.41 as a function of x:  (y_list_fit).^.41 = (V*xlist./(K+xlist)).^.41
%sse is summed square error
V_initial_guess=1;
K_initial_guess=1;
p0=[V_initial_guess,K_initial_guess];

p_fit=fminsearch( @(p) sse_mich_mentin_power_fit(xlist,ylist,p) , p0)

V_fit=p_fit(1);
K_fit=p_fit(2);

%plot the data, and our fit
figure
set(gca,'FontSize',16)
plot(xlist,ylist,'o'); hold on
plot(xlist,V_fit*xlist./(K_fit+xlist),'.');
xlabel('x');ylabel('y')

residual_list=(V_fit*xlist./(K_fit+xlist)).^.41  -  (ylist).^.41;
figure
subplot(211)
hist(residual_list);
subplot(212)
[N,H]=hist(residual_list);
bar(H,sqrt(N)); hold on








%%%%%%%%%%%%%%%%%%%%%
% define subfunctions

%---------------------------------
function f=sse_mich_mentin_power_fit(xlist,ylist,p)
%attempt to fit ylist.^.41 to equation ylist.^.41=(V*xlist/(xlist+K)).^.41
%compute summed square error

V=p(1) ; K=p(2) ;

ylist_fit=(V*xlist./(K+xlist)).^.41;
f=sum( (ylist_fit-(ylist).^.41).^2 );