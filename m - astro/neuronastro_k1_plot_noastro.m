close all;
figure
subplot(2,1,1)
plot(1:length(V),V,'k')
xlabel('T/s');
ylabel('V','FontSize',20);
set(gca,'Xtick',0:0.1*length(time):length(time))
set(gca, 'XTicklabel', 0:0.0001*tEnd:0.001*tEnd);
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
axis tight
subplot(2,1,2)
plot(1:length(Fai),Fai,'k')
xlabel('T/s');
ylabel('\phi','FontSize',20);
set(gca,'Xtick',0:0.1*length(time):length(time))
set(gca, 'XTicklabel', 0:0.0001*tEnd:0.001*tEnd);
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
axis tight


a1=490600;a2=518300;c=3;
figure
subplot(2,1,1)
plot(a1:1:a2,V(a1:a2),'k')
xlabel('T/s');
ylabel('V','FontSize',20);
set(gca,'Xtick',linspace(a1,a2,c))
set(gca, 'XTicklabel', linspace(0.1*a1./tEnd,0.1*a2./tEnd,c));
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
% axis([a1 a2 -0.3 -0.1])
axis tight

subplot(2,1,2)
plot(a1:1:a2,Fai(a1:a2),'k')
xlabel('T/s');
ylabel('\phi','FontSize',20);
set(gca,'Xtick',linspace(a1,a2,c))
set(gca, 'XTicklabel', linspace(0.1*a1./tEnd,0.1*a2./tEnd,c));
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
% axis([a1 a2 60 80])
axis tight

figure
plot3(V(a1:a2),Fai(a1:a2),I_slow(a1:a2))


