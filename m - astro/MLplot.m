close all;
figure
subplot(5,1,1)
plot(1:length(U(:,1)),U(:,1),'k')
ylabel('V','FontSize',20);
xlabel('500s','FontSize',20);
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(gca,'xtick',[])
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
axis tight
subplot(5,1,2)
plot(1:length(U(:,2)),U(:,2),'k')
ylabel('w','FontSize',20);
xlabel('50s','FontSize',20);
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(gca,'xtick',[])
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
axis tight
subplot(5,1,3)
plot(1:length(U(:,4)),U(:,4),'k')
ylabel('Fai','FontSize',20);
xlabel('500s','FontSize',20);
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(gca,'xtick',[])
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
axis tight
subplot(5,1,4)
plot(1:length(U(:,5)),U(:,5)*10,'k')
ylabel('IP_3','FontSize',20);
xlabel('50s','FontSize',20);
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(gca,'xtick',[])
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
axis tight
subplot(5,1,5)
plot(1:length(U(:,6)),U(:,6)*1000,'k')
ylabel('Ca','FontSize',20);
xlabel('500s','FontSize',20);
set(gca,'fontsize',14);
set(gca,'linewidth',1) %设置边框宽度 
set(gca,'xtick',[])
set(get(gca,'Children'),'linewidth',1);%设置图中线宽1.5磅
axis tight

figure
plot(1:length(U(:,8)),U(:,8),'k')
ylabel('V','FontSize',20);
xlabel('H','FontSize',20);
set(gca,'fontsize',14);
set(gca,'linewidth',3) %设置边框宽度 
% 
% set(get(gca,'Children'),'linewidth',3);%设置图中线宽1.5磅
% axis tight

% y = fft(U(fix(0.7*length(U)):fix(length(U)),1));     
% f = (0:length(y)-1)*50/length(y);
% plot(f,abs(y))
% title('Magnitude')

% x=[0	0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1	1.1	1.2	1.3	1.4	1.5	1.6	1.7	1.8	1.9	2	2.1	2.2	2.3	2.4	2.5	2.6	2.7	2.8	2.9	3	3.1	3.2	3.3	3.4	3.5	3.6	3.7	3.8	3.9	4	4.1	4.2	4.3	4.4	4.5	4.6	4.7	4.8	4.9	5	5.1	5.2	5.3	5.4	5.5	5.6	5.7	5.8	5.9	6	6.1	6.2	6.3	6.4	6.5	6.6	6.7	6.8	6.9	7	7.1	7.2	7.3	7.4	7.5	7.6	7.7	7.8	7.9	8	8.1	8.2	8.3	8.4	8.5	8.6	8.7	8.8	8.9	9	9.1	9.2	9.3	9.4	9.5	9.6	9.7	9.8	9.9	10];
% y=[3.95201	3.30618	2.91515	2.64525	2.44307	2.2792	2.15103	2.03002	1.95408	1.86158	1.78015	1.70763	1.58441	1.57436	1.53097	1.47361	1.43054	1.39048	1.35207	1.31672	1.28482	1.25397	1.22501	1.19714	1.1717	1.14806	1.12518	1.10301	1.08271	1.06298	1.04396	1.02636	1.00861	0.99259	0.97666	0.96151	0.94681	0.93268	0.91897	0.90624	0.89328	0.88136	0.86943	0.85866	0.84774	0.8371	0.82701	0.81706	0.80736	0.79797	0.7888	0.78044	0.77167	0.76334	0.75527	0.74728	0.73978	0.73228	0.72499	0.71793	0.711	0.70435	0.69768	0.69127	0.68491	0.67874	0.67274	0.66703	0.66124	0.65554	0.65024	0.64449	0.63937	0.63433	0.6292	0.62443	0.61929	0.61472	0.61001	0.60542	0.60095	0.59654	0.59225	0.58807	0.58405	0.57979	0.57565	0.57184	0.56794	0.56419	0.56053	0.55647	0.55296	0.5494	0.54593	0.54241	0.53903	0.53573	0.53251	0.52933	0.52607];
% 








