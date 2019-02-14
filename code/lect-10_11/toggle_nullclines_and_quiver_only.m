clear all

set(0,'defaultTextFontSize',14)
set(0,'DefaultAxesFontSize',14)
  
  
ulist=0:.2:4;
vlist=0:.2:4;

[umatrix,vmatrix]=meshgrid(ulist,vlist);

dudt_matrix=zeros(size(umatrix));
dvdt_matrix=zeros(size(vmatrix));

%SET PARAMETERS
a=3;
b=2;   % b = 2 creates SWITCH, b = 1 is lame single stability system
p=[a,b];

for i=1:length(vlist)
    for j=1:length(ulist)
    dxdt=toggle2_odefun(0,[umatrix(i,j);vmatrix(i,j)],p);
    dudt_matrix(i,j)=dxdt(1);
    dvdt_matrix(i,j)=dxdt(2);
    end
end

%PLOT DIRECTION FIELD

figure
set(gca,'FontSize',16)
quiver(umatrix,vmatrix,dudt_matrix,dvdt_matrix); hold on
xlabel('u','FontSize',20);ylabel('v','FontSize',20)


%PLOT NULLCLINES
vlist_for_u_nullcline=a./(1+vlist.^b) ;
ulist_for_v_nullcline=a./(1+ulist.^b) ;

plot(ulist,vlist_for_u_nullcline,':','Linewidth',2);
plot(ulist_for_v_nullcline,vlist,'Linewidth',2);

axis([0 max(ulist)+.2 0 max(vlist)+.2])

