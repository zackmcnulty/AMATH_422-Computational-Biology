%rivalry.m generates two perpendicular sine wave gratings
% strength = [1,0.9] %for equal strong salience
% strength=[1,0.4] %or 0.6,1] for strong + bias
strength=[.3,.3] %for balanced at low intenstiy
% strength=[.4,.3] for bias near threshold

strength=[.5,.5] %for balanced at low intenstiy


N=1000
t=.05*[1:N];
tt=t+3.14;% or t+60
v=0.5*(1+.2*sin(t));
vv=0.5*(1+.2*sin(tt));
%v=log(v+1);
%vv=log(vv+1);
x=ones(1,N);
V=x'*v;
Vp=x'*vv;
VV=V';
W=cat(3,strength(1)*V,strength(2)*VV);
X=cat(3,W,zeros(N));
%WW=cat(3,V,Vp);
%XX=cat(3,WW,zeros(N));
figure(1)
image(X)
%figure(2)
%image(XX)

%figure(3)
%imagesc(V,[0 1]);colormap(gray);