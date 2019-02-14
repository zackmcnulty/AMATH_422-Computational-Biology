% Simulate the repressilator model

close all

alpha=10;

alpha0=0.5;
beta=1;
n=2;

x0 = 30*rand(6,1) ;

for alpha= 1:0.05:20 

p = [alpha,alpha0,beta,n];

Tmax=100;

[T,Y] = ode45(@repress,[0 Tmax],x0,[],p);

figure(1)
plot(T,Y(:,1:3),'LineWidth',3) ; hold on;
plot(T,Y(:,4:6),':','LineWidth',3) ; hold off;
text(60,20, strcat('\alpha = ', num2str(alpha)))

pause(0.1)


end


%%
for numreps=1:4 

p = [alpha,alpha0,beta,n];
x0 = 30*rand(6,1) ;

Tmax=100;

[T,Y] = ode45(@repress,[0 Tmax],x0,[],p);

figure(1)
plot(T,Y(:,1:3),'LineWidth',3) ; hold on;
plot(T,Y(:,4:6),':','LineWidth',3) ; hold on;
legend('m lalcl','m tetR','m cl','p lacl','p tetR','p cl')
xlabel('t') ; 
set(gca,'FontSize',16)


figure(2)
plot3(Y(:,1),Y(:,2),Y(:,3),'LineWidth',3) ; hold on, grid on 
xlabel('m lalcl');ylabel('m tetR');zlabel('m cl')
set(gca,'FontSize',16)

end