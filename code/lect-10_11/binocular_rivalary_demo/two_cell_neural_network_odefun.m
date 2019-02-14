 function F=two_cell_neural_network_odefun(t,y,p)  
    %y is the state vector
    %F is the velocity vector
    %t is the time.  Note, you have to use this t argument, even if it is
    %not used in defining the velocity!
    %p is vector of parameters:  p=[I1 I2 beta g b eps]
    
    
    y1=y(1);
    y2=y(2);
    
    
   %New step:  unpack the parameters
    I1=p(1); I2=p(2); beta=p(3); g=p(4); b=p(5); eps=p(6);
    
    dy1_dt= -y1 + f(-beta*y2+I1,g,b) ;
    dy2_dt= -y2+ f(-beta*y1+I2,g,b) ;
    
    F=[dy1_dt ; 
       dy2_dt ] ;