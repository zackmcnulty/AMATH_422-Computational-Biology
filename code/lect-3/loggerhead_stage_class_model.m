% Define projection matrix A
A=[ 0    0     0     0     127       4   80  ;
 .6747  1.25*.737   0     0     0         0    0  ;
    0  .0486 .661    0     0         0    0  ;
    0     0  .0147  .6907  0         0    0  ;
    0     0    0    .0518  0         0    0  ;
    0     0    0     0    .8091      0    0  ;
    0     0    0     0     0       .8091  .8089  ];


% Compute eigenvalues and eigenvectors of A
 E=eig(A);
 absolute_eigenvalues = abs(E) 
% Returns matrix V, columns of which are eigenvectors
% Diagonal matrix D, entries of which are corresponding eigenvectors


%--------------------------------------------------------

%Initial population size in each class
n_zero=[2900;
        9000;
        1600;
        100;
        5;
        4;
        20];
    
                
Tmax=200;
n_vs_t=zeros(7,Tmax);

n_vs_t(:,1)=n_zero ;

for t=2:Tmax;
   n_vs_t(:,t)=A*n_vs_t(:,t-1) ;    
end

figure
set(gca,'FontSize',20)
plot(1:Tmax,n_vs_t','.-','MarkerSize',14)
xlabel('t','FontSize',20)
ylabel('n','FontSize',20)
legend('stage 1','stage 2','stage 3','stage 4','stage 5','stage 6','stage 7')
    