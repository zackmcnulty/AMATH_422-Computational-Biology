% Define projection matrix A
format long

f2=1;
p1=1;


A=[ 0    f2;
    p1   0 ]


disp(' -----------  A^2 -----------')

%Test for power-positivity.  n^2-2n+2 is crucial power.  For n=2, that's 2
A^2

 E=eig(A);
 absolute_eigenvalues = abs(E) 



%Initial population size in each class
n_zero=[2900;
        9000];
    
                
Tmax=20;
n_vs_t=zeros(2,Tmax);

n_vs_t(:,1)=n_zero ;

for t=2:Tmax;
   n_vs_t(:,t)=A*n_vs_t(:,t-1) ;    
end

figure
set(gca,'FontSize',20)
plot(1:Tmax,n_vs_t','.-','MarkerSize',14,'LineWidth',3)
xlabel('t','FontSize',20)
ylabel('n','FontSize',20)
legend('stage 1','stage 2')
    