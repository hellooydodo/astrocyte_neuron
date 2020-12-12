clc;clear;close all;

a1=[0.95 1.0659];
b11=[0.1229 0.12048];
b12=[-0.24843 -0.247];

x1=linspace(0.95,1.0659,10000);
y11=linspace(0.1229,0.12048,10000);
y12=linspace(-0.24843,-0.247,10000);

x2=linspace(0.993,1.1,10000);
y2=ones(10000,1)*-0.2199;

s=0.993:0.001:1.066;
x10=0.98;
c1=5;
a1=0.34047/((1.0659-x10).^c1-(0.993-x10).^c1);
b1=0.12048-a1*((1.0659-x10).^c1);

t1=a1*(s-x10).^c1+b1;

x20=0.99;
c2=3;
a2=-0.0271/((1.0659-x20).^c2-(0.993-x20).^c2);
b2=-0.247-a2*((1.0659-x20).^c2);

t2=a2*(s-x20).^c2+b2;
d=4;
plot(x1,y11,'b','linewidth',d)
hold on
plot(x1,y12,'b','linewidth',d)
plot(x2,y2,'black','linewidth',d)
plot(s,t1,'ro')
plot(s,t2,'ro')
xlabel('k_1');
ylabel('V');
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(gca,'FontName','Times New Roman','FontSize',17,'LineWidth',1);
% set(get(gca,'Children'),'linewidth',2);%设置图中线宽1.5磅
axis([0.95 1.1 -0.3 0.2])





