clc;clear
close all 

T=3000;
dt=0.01;
t=0:dt:T;

a=0.02;b=0.2;c=-65;d=8;
Iest=10;
gse=0.10;gsi=0.1;
s=rand;

% v10=zeros(length(t)+2,1);
% v10(1)=-61.19389;
% w10=zeros(length(t)+2,1);
% w10(1)=0.5;
% gg10(1)=0.1;
% 
% v20=zeros(length(t),1);
% v20(1)=-61.19389;
% w20=zeros(length(t),1);
% w20(1)=0.5;
% gg20(1)=0.1;

v1=zeros(length(t),1);
v1(1)=-30;
w1=zeros(length(t),1);
w1(1)=0.1;
gg1(1)=0.1;

v2=zeros(length(t),1);
v2(1)=-30;
w2=zeros(length(t),1);
w2(1)=0.1;
gg2(1)=0.1;
% 
% v1=zeros(length(t),1);
% w1=zeros(length(t),1);
% v2=zeros(length(t),1);
% w2=zeros(length(t),1);


ca0=zeros(length(t),1);
ca0(1)=0.1;
IP30=zeros(length(t),1);
IP30(1)=0.2;
q0=zeros(length(t),1);
q0(1)=0.1;
fai(1)=0.2;
glu0=zeros(length(t),1);
glu0(1)=0.1;
yita0=zeros(length(t),1);
yita0(1)=0.1;

ca=zeros(length(t),1);
IP3=zeros(length(t),1);
q=zeros(length(t),1);
glu=zeros(length(t),1);
yita=zeros(length(t),1);

rip3=7.2;

for i=2:length(t)
  Iastro=10*s*fai(1);
%     if v1(i-1)>=30
%         v1(i-1)=c;
%         u1(i-1)=u1(i-1)+d;
%     end
%   v1(i)=v1(i-1)+(0.04*v1(i-1)^2+5*v1(i-1)+140-u1(i-1)+Iest-Iastro+gsi*(v1(i-1))*(gg2(i-1)))*dt;
%   u1(i)=u1(i-1)+(a*(b*v1(i-1)-u1(i-1)))*dt;
%   gg1(i)=gg1(i-1)+(0.1*1/(1+exp(-(v1(i-1)-0.2)/0.02))*(1-gg1(i-1))-0.05*gg1(i-1))*dt;
%     if v2(i-1)>=30
%         v2(i-1)=c;
%         u2(i-1)=u2(i-1)+d;
%     end
%   v2(i)=v2(i-1)+(0.04*v2(i-1)^2+5*v2(i-1)+140-u2(i-1)+Iest+Iastro+gse*(v2(i-1)+0.85)*gg1(i-1))*dt;
%   u2(i)=u2(i-1)+(a*(b*v2(i-1)-u2(i-1)))*dt;
%   gg2(i)=gg2(i-1)+(0.1*1/(1+exp(-(v2(i-1)-0.2)/0.02))*(1-gg2(i-1))-0.05*gg2(i-1))*dt;
   v1(i)=v1(i-1)+(v_function(v1(i-1),w1(i-1))+Iest-Iastro+gsi*(v1(i-1))*gg2(i-1))*dt;
   w1(i)=w1(i-1)+w_function(w1(i-1),v1(i-1))*dt;
   gg1(i)=gg1(i-1)+gg_function(gg1(i-1),v1(i-1))*dt;
%    v1(i)=v10(i-1)+(v_function(v10(i-1),w10(i-1))+Iest-Iastro+gsi*(v10(i-1))*gg20(i-1))*dt;
%    w1(i)=w10(i-1)+w_function(w10(i-1),v10(i-1))*dt;
%    gg1(i)=gg10(i-1)+gg_function(gg10(i-1),v10(i-1))*dt;
%    v10(i)=v1(i);
%    w10(i)=w1(i);
%    gg10(i)=gg1(i);

   v2(i)=v2(i-1)+(v_function(v2(i-1),w2(i-1))+Iest+Iastro+gse*(v1(i-1)+0.85)*gg1(i-1))*dt;
   w2(i)=w1(i-1)+w_function(w2(i-1),v2(i-1))*dt;
   gg2(i)=gg2(i-1)+gg_function(gg2(i-1),v2(i-1))*dt;
%    v2(i)=v20(i-1)+(v_function(v20(i-1),w20(i-1))+Iest+Iastro+gse*(v10(i-1)+0.85)*gg10(i-1))*dt;
%    w2(i)=w10(i-1)+w_function(w20(i-1),v20(i-1))*dt;
%    gg2(i)=gg20(i-1)+gg_function(gg20(i-1),v20(i-1))*dt;
%    v20(i)=v2(i);
%    w20(i)=w2(i);
%    gg20(i)=gg2(i);
%   if mod(i,1000)==0
%   IP3(i)=IP3(i-1)+((0.16-IP3(i-1))*0.140+rip3/(1+exp(-(v1(i-1)-0.2)/0.02))+rip3/(1+exp(-(v2(i-1)-0.2)/0.02)))*dt*0.001;
%   ca(i)=ca(i-1)+((-0.185*6*((IP3(i-1)/(IP3(i-1)+0.13))^3)*(ca(i-1)/(ca(i-1)+0.08234))^3*(q(i-1))^3*(ca(i-1)-(2-ca(i-1))/0.185))-0.9*ca(i-1)*ca(i-1)/(0.01+ca(i-1)*ca(i-1))+0.185*0.11*((2-ca(i-1))/0.185-ca(i-1)))*dt*0.001;
%   q(i)=q(i-1)+(0.2*1.049*(IP3(i-1)+0.13)/(IP3(i-1)+0.9434)*(1-q(i-1))-0.2*ca(i-1)*q(i-1))*dt*0.001;
%     if ca(i)>0.2
%        glu(i)=glu(i-1)+((-glu(i-1)-200*yita(i-1)+ca(i-1)-0.2)/0.5)*dt*0.001;
%     else
%        glu(i)=glu(i-1)+((-glu(i-1)-200*yita(i-1))/0.5)*dt*0.001;
%     end
%       yita(i)=yita(i-1)+((-yita(i-1)+glu(i-1))/10)*dt*0.001;
%   end
    IP3(i)=IP30(i)+((0.16-IP30(i))*0.140+rip3/(1+exp(-(v1(i)-0.2)/0.02))+rip3/(1+exp(-(v2(i)-0.2)/0.02)))*dt;
    ca(i)=ca0(i)+((-0.185*6*((IP30(i)/(IP30(i)+0.13))^3)*(ca0(i)/(ca0(i)+0.08234))^3*(q0(i)^3*(ca0(i)-(2-ca0(i))/0.185))-0.9*ca0(i)*ca0(i)/(0.01+ca0(i)*ca0(i))+0.185*0.11*((2-ca0(i))/0.185-ca0(i))))*dt;
    q(i)=q0(i)+(0.2*1.049*(IP30(i)+0.13)/(IP30(i)+0.9434)*(1-q0(i))-0.2*ca0(i)*q0(i))*dt ;
    yita(i)=yita0(i)+((-yita0(i)+glu0(i))/10)*dt;
    if ca(i)>0.2
       glu(i)=glu0(i)+((-glu0(i)-200*yita0(i)+ca0(i)-0.2)/0.5)*dt;
    else
       glu(i)=glu0(i)+((-glu0(i)-200*yita0(i))/0.5)*dt;
    end  
  IP30(i)=IP3(i);
  ca0(i)=ca(i);
  q0(i)=q(i);
  glu0(i)=glu(i);
   
  yita0(i)=yita(i);
end
 plot(1:length(v1),v1) 
 
function w_fun = w_function(w,v)     
        % M-L model W
 w_fun=(1.15*((((1+tanh((v-0.1)/0.145))/2)-w)*(cosh(v-0.1/(2*0.145)))));
end

function v_fun = v_function(v,w)     
        % M-L model V
Cm=1;
Gm=0.5;
Gca=1.1;
Gk=2;
Gl=0.5;

vca=100;
vk=-70;
vl=-50;
      
v_fun=((1/Cm)*(-Gca*((1+tanh((v+0.01)/0.15))/2)*(v-vca)-Gk*w*(v-vk)-Gl*(v-vl)));
end
 function gg_fun = gg_function(gg,v)     
        % M-L model gg
 gg_fun=(0.1*1/(1+exp(-(v-0.2)/0.02))*(1-gg)-0.05*gg);
end
  
  
  