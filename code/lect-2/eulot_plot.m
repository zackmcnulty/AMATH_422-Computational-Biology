lambda_min=-1 ;
lambda_max=5 ;

lambdalist=linspace(lambda_min,lambda_max,1000) ;
Glist=zeros(1,length(lambdalist));

Ialist=[1.0000    0.5000    0.250];
falist=[0     1     5];

for j=1:length(lambdalist)
    Glist(j)=eulot(lambdalist(j),Ialist,falist) ;
end

figure
plot(lambdalist,Glist);
xlabel('lambda','FontSize',20)
ylabel('G(lambda)','FontSize',20)
ylim([-1,2]);
xlim([1,5]);

set(gca,'FontSize',20)

guess_min=0.0001; guess_max=10;

lambdabar = fzero(@(lambda) eulot(lambda,Ialist,falist),[guess_min,guess_max])
