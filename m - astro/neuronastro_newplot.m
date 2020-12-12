close all;
figure
subplot(3,1,1)
plot(1:length(V),V,'k')
xlabel('T/s');
ylabel('V','FontSize',20);
set(gca,'Xtick',0:0.1*length(time):length(time))
set(gca, 'XTicklabel', 0:10:100);
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
axis tight
subplot(3,1,2)
plot(1:length(f),0.5*f,'k')
ylabel('I_{Astro}','FontSize',20);
xlabel('T/s','FontSize',20);
set(gca,'Xtick',0:0.1*length(time):length(time))
set(gca, 'XTicklabel', 0:10:100);
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
axis([0 1e4 0 0.1])
set(gca,'Xtick',0:1e3:1e4)
set(gca, 'XTicklabel', 0:0.1:1);

axis tight
subplot(3,1,3)
plot(1:length(Ca),Ca*1000,'k')
xlabel('T/s');
ylabel('Ca^{2+}/nM','FontSize',20);
set(gca,'Xtick',0:0.1*length(time):length(time))
set(gca, 'XTicklabel', 0:10:100);
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
axis tight


a1=342800;a2=614600;c=3;
figure
subplot(c,1,1)
plot(a1:1:a2,V(a1:a2),'k')
xlabel('T/s');
ylabel('V','FontSize',20);
line([369000,369000],[-0.5,0.15],'color','r','linestyle','--');
line([462600,462600],[-0.5,0.15],'color','r','linestyle','--');
line([502150,502150],[-0.5,0.15],'color','r','linestyle','--');
line([595500,595500],[-0.5,0.15],'color','r','linestyle','--');

set(gca,'Xtick',linspace(a1,a2,3))
set(gca, 'XTicklabel', linspace(a1./10000,a2./10000,3));
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
axis tight

subplot(c,1,2)
plot(a1:1:a2,0.5*f(a1:a2),'k')
xlabel('T/s');
ylabel('I_{Astro}','FontSize',20);
line([369000,369000],[0.0,0.13],'color','r','linestyle','--');
line([462600,462600],[0.0,0.13],'color','r','linestyle','--');
line([502150,502150],[0.0,0.13],'color','r','linestyle','--');
line([595500,595500],[0.0,0.13],'color','r','linestyle','--');

% hold on
% for i = a1 : a2
%     if (Ca(i-1)-0.2)*(Ca(i)-0.2) < 0
%         m=i;
%         n=linspace(0,0.12);
%         plot(m,n,'r');
%         hold on
%     end
% end
set(gca,'Xtick',linspace(a1,a2,c))
set(gca, 'XTicklabel', linspace(a1./10000,a2./10000,c));
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
axis tight

subplot(c,1,c)
plot(a1:1:a2,Ca(a1:a2)*1000,'k')
xlabel('T/s');
ylabel('Ca^{2+}/nM','FontSize',20);
line([342800,614600],[200,200],'color','r','linestyle','--');
line([369000,369000],[88,312],'color','r','linestyle','--');
line([462600,462600],[88,312],'color','r','linestyle','--');
line([502150,502150],[88,312],'color','r','linestyle','--');
line([595500,595500],[88,312],'color','r','linestyle','--');

set(gca,'Xtick',linspace(a1,a2,3))
set(gca, 'XTicklabel', linspace(a1./10000,a2./10000,3));
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
% axis([a1 a2 60 80])
axis tight



% figure
% subplot(2,1,1)
% plot(1:length(I_slow),I_slow,'k')
% xlabel('T/s');
% ylabel('I_slow','FontSize',20);
% set(gca,'Xtick',0:0.1*length(time):length(time))
% set(gca, 'XTicklabel', 0:10:100);
% set(gca,'fontsize',14);
% set(gca,'linewidth',1) %设置边框宽度 
% set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
% axis tight
% subplot(2,1,2)
% plot(a1:1:a2,I_slow(a1:a2),'k')
% xlabel('T/s');
% ylabel('I_slow','FontSize',20);
% set(gca,'Xtick',linspace(a1,a2,c))
% set(gca, 'XTicklabel', linspace(a1./10000,a2./10000,c));
% set(gca,'fontsize',14);
% set(gca,'linewidth',1) %设置边框宽度 
% set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
% % axis([a1 a2 60 80])
% axis tight
