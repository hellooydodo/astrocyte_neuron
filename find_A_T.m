clc,clear
Path = input('输入路径：',"s");
pattern = "\\AMPA.*";
[keyword_l,keyword_r] = regexp(Path,pattern);
import = importdata(Path+"\v_Isyn_"+string(Path(keyword_l+1:keyword_r))+"_sample.txt");
v = import(:,1);
Isyn = import(:,2);
Fs = 1000; %采样频率 1ms 
L = length(v);
NFFT = 2^nextpow2(L);
Y = fft(v,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
figure
subplot(2,1,1),plot(v);
subplot(2,1,2),plot(f,2*abs(Y(1:NFFT/2+1)));