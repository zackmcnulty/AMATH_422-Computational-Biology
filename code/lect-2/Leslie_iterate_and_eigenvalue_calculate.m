% iterates Leslie matrix

n_zero=[10 100 500]' ;

A=[0  1 5 ;
  .5  0 0 ;
  0 .25 0 ];


Tmax=200;

n_vs_t=zeros(3,Tmax);

n_vs_t(:,1)=n_zero ;

for t=2:Tmax;
   n_vs_t(:,t)=A*n_vs_t(:,t-1) ;    
end

figure
set(gca,'FontSize',20)
plot(1:Tmax,n_vs_t','.-','MarkerSize',14)
xlabel('t','FontSize',20)
ylabel('n','FontSize',20)

figure
set(gca,'FontSize',20)
plot(1:Tmax,log(n_vs_t'),'.-','MarkerSize',14)
xlabel('t','FontSize',20)
ylabel('log(n)','FontSize',20)

%Fit log n_0(t) to a straight line
p=polyfit(25:Tmax,log(n_vs_t(1,25:Tmax)),1)
lambda_estimate=exp(p(1))

%------------------
%Find the dominant eigenvalue
L=eig(A); 
j=find(abs(L)==max(abs(L))) ; 
dominant_eigenvalue=L(j) 

