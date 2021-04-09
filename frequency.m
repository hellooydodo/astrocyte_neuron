%FFT变换,获得采样数据基本信息，时域图，频域图
%这里的向量都用行向量，假设被测变量是速度，单位为m/s
clear;
close all;

load v_Isyn_AMPAD260_sample.txt              %通过仪器测量的原始数据，存储为data.txt中，附件中有一个模版(该信号极不规则)
A=v_Isyn_AMPAD260_sample;                                        %将测量数据赋给A，此时A为N×2的数组
%x=A(:,1);                                     %将A中的第一列赋值给x，形成时间序列
%x=x';                                           %将列向量变成行向量
x = 0.001:0.001:length(A)/1000;
y=A(:,1);                                     %将A中的第二列赋值给y，形成被测量序列
%,v0[44][50],Iion(v0[44][50],n0[44][50]),Isy[44][50],I_slow0[44][50],I_ast[44][55],Ca0[44][50],Ip3_0[44][50]);
y=y';                                           %将列向量变成行向量

%显示数据基本信息
fprintf('\n数据基本信息：\n') 
fprintf('        采样点数 = %7.0f \n',length(x))                         %输出采样数据个数
fprintf('        采样时间 = %7.3f s\n',max(x)-min(x))                    %输出采样耗时
fprintf('        采样频率 = %7.1f Hz\n',length(x)/(max(x)-min(x)))   %输出采样频率
fprintf('        最小速度 = %7.3f m/s\n',min(y))                         %输出本次采样被测量最小值
fprintf('        平均速度 = %7.3f m/s\n',mean(y))                      %输出本次采样被测量平均值
fprintf('        速度中值 = %7.3f m/s\n',median(y))                   %输出本次采样被测量中值
fprintf('        最大速度 = %7.3f m/s\n',max(y))                          %输出本次采样被测量最大值
fprintf('        标准方差 = %7.3f \n',std(y))                               %输出本次采样数据标准差
fprintf('       协 方 差 = %7.3f \n',cov(y))                                %输出本次采样数据协方差
fprintf('     自相关系数 = %7.3f \n\n',corrcoef(y))                       %输出本次采样数据自相关系数
set(gca,'FontSize',20,'Fontname', 'Times New Roman');
%显示原始数据曲线图（时域）
subplot(2,1,1);
plot(x,y)                                                                                %显示原始数据曲线图
axis([min(x) max(x) 0.9*(min(y)) 1.1*(max(y))])             %优化坐标，可有可无
xlabel('Time (s)','FontName','Times New Roman','FontSize',12);
ylabel('Calcium concentration','FontName','Times New Roman','FontSize',12);
%title('原始信号(时域)');
grid on;

%傅立叶变换
y=y-mean(y);                                               %消去直流分量，使频谱更能体现有效信息
Fs=length(x)/(max(x)-min(x));                %得到原始数据data.txt时，仪器的采样频率。就是length(x)/(max(x)-min(x));     
N=length(y);                                                 %data.txt中的被测量个数，即采样个数。其实就是length(y);
z=fft(y);

%频谱分析
f=(0:N-1)*Fs/N;
Mag=2*abs(z)/N;                                        %幅值，单位同被测变量y
Pyy=Mag.^2;          %能量；对实数系列X，有 X.*X=X.*conj(X)=abs(X).^2=X.^2，故这里有很多表达方式

%显示频谱图(频域)
subplot(2,1,2)
semilogx(f(1:N/2),Pyy(1:N/2),'r')                         %显示频谱图
%                 |
%             将这里的Pyy改成Mag就是 幅值-频率图了
axis([min(f(1:N/2)) max(f(1:N/2)) 0 1.1*(max(Pyy(1:N/2)))]) 
xlabel('频率 (Hz)')
ylabel('能量')
title('频谱图(频域)')
grid on;

%返回最大能量对应的频率和周期值
[a b]=max(Pyy(1:N/2));
Pyy = Pyy';
save('.\output.txt','Pyy','-ascii')
fprintf('\n傅立叶变换结果：\n') 
fprintf('           FFT_f = %1.3f Hz\n',f(b))             %输出最大值对应的频率
fprintf('           FFT_T = %1.3f s\n',1/f(b))          %输出最大值对应的周期

 