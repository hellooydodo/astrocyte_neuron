clc,clear
load('plot.mat');
figure(1)
hold on
Iex = 0.22916;
h2 = plot(diagramg02head(:,1)-Iex,diagramg02head(:,2),'-r',diagramg02tail(:,1)-Iex,diagramg02tail(:,2),'-r',...
diagramg02bif(:,1)-Iex,diagramg02bif(:,2),'-r',diagramg02bif(:,1)-Iex,diagramg02bif(:,3),'-r',...
diagramg02dash(:,1)-Iex,diagramg02dash(:,2),'--r','LineWidth',1.5);

h1 = plot(diagramg01head(:,1)-Iex,diagramg01head(:,2),'-b',diagramg01tail(:,1)-Iex,diagramg01tail(:,2),'-b',...
diagramg01bif(:,1)-Iex,diagramg01bif(:,2),'-b',diagramg01bif(:,1)-Iex,diagramg01bif(:,3),'-b',...
diagramg01dash(:,1)-Iex,diagramg01dash(:,2),'--b','LineWidth',1.5);

h3 = plot(diagramg03head(:,1)-Iex,diagramg03head(:,2),'-k',diagramg03tail(:,1)-Iex,diagramg03tail(:,2),'-k',...
diagramg03bif(:,1)-Iex,diagramg03bif(:,2),'-k',diagramg03bif(:,1)-Iex,diagramg03bif(:,3),'-k',...
diagramg03dash(:,1)-Iex,diagramg03dash(:,2),'--k','LineWidth',1.5);

h0 = plot(diagramg0head(:,1)-Iex,diagramg0head(:,2),'-g',diagramg0tail(:,1)-Iex,diagramg0tail(:,2),'-g',...
diagramg0bif(:,1)-Iex,diagramg0bif(:,2),'-g',diagramg0bif(:,1)-Iex,diagramg0bif(:,3),'-g',...
diagramg0dash(:,1)-Iex,diagramg0dash(:,2),'--g','LineWidth',1.5);

axis([0.05-Iex 0.55-Iex -0.6 0.4])
xlabel('I_{syn} ({\mu}A)','FontName','Times New Roman','FontSize',14,'FontWeight','bold');
ylabel('V (mV)','FontName','Times New Roman','FontSize',14,'FontWeight','bold');
set(gca,'Box','on')
h = legend([h0(1),h1(1),h2(1),h3(1)],'\gamma = 0','\gamma = 0.1','\gamma = 0.2','\gamma = 0.3','Location','SouthEast');
set(h,'FontName','Times New Roman','FontSize',12,'FontWeight','bold')