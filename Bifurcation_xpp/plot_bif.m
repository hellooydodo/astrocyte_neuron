figure(1)
hold on
Iex = 0.22916;
plot(diagramg02head(:,1)-Iex,diagramg02head(:,2),'-b')
plot(diagramg02dash(:,1)-Iex,diagramg02dash(:,2),'--b')
plot(diagramg02tail(:,1)-Iex,diagramg02tail(:,2),'-b')
plot(diagramg02bif(:,1)-Iex,diagramg02bif(:,2),'-b')
plot(diagramg02bif(:,1)-Iex,diagramg02bif(:,3),'-b')

plot(diagramg01head(:,1)-Iex,diagramg01head(:,2),'-r')
plot(diagramg01dash(:,1)-Iex,diagramg01dash(:,2),'--r')
plot(diagramg01tail(:,1)-Iex,diagramg01tail(:,2),'-r')
plot(diagramg01bif(:,1)-Iex,diagramg01bif(:,2),'-r')
plot(diagramg01bif(:,1)-Iex,diagramg01bif(:,3),'-r')

plot(diagramg03head(:,1)-Iex,diagramg03head(:,2),'-k')
plot(diagramg03dash(:,1)-Iex,diagramg03dash(:,2),'--k')
plot(diagramg03tail(:,1)-Iex,diagramg03tail(:,2),'-k')
plot(diagramg03bif(:,1)-Iex,diagramg03bif(:,2),'-k')
plot(diagramg03bif(:,1)-Iex,diagramg03bif(:,3),'-k')

plot(diagramg0head(:,1)-Iex,diagramg0head(:,2),'-g')
plot(diagramg0dash(:,1)-Iex,diagramg0dash(:,2),'--g')
plot(diagramg0tail(:,1)-Iex,diagramg0tail(:,2),'-g')
plot(diagramg0bif(:,1)-Iex,diagramg0bif(:,2),'-g')
plot(diagramg0bif(:,1)-Iex,diagramg0bif(:,3),'-g')

axis([0.05-Iex 0.55-Iex -0.6 0.4])