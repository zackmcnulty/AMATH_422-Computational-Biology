function dy =  toggle2_odefun(t,y,p)

    %parameters -- "unpack" the parameter vector p
    a=p(1);
    b=p(2);

    dy = zeros(2,1);
    dy(1) = - y(1) + a./(1+y(2).^b);
    dy(2) = - y(2) + a./(1+y(1).^b);
 
