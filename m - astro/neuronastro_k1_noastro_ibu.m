clc;clear;
tic
timeStart = datetime('now');
fprintf('Start time is %s\n', char(timeStart));

fid=fopen('Astrocyte_k1_noastro_ibu5.dat','w');

%%  /* set parameters */
k1=0.5;
k2=0.5;k3=1;%磁感应耦合强度
I_ext=0.2;
A=0;omiga=0.1;%外加磁感应刺激强度

IP3s=0.16;alpha=0.0005;
g_Ca=1;v_Ca=1;g_K=2;v_K= -0.7;g_L=0.5;v_L= -0.5;
Cm=1;v0=0.2;v1=-0.01;v2=0.15;v3=0.1;v4=0.145;phi=1.15;
% ibu=0.1;
% 	***************************************************************************/

%% /* set initial condition */+++
tEnd = 30000;
dt = 0.01;
time = 0:dt:tEnd;

  V = zeros(length(time),1);                V(1) = 0;
  w = zeros(length(time),1);                w(1) =0.2;
  Fai = zeros(length(time),1);              Fai(1) = 0;
  I_slow = zeros(length(time),1);           I_slow(1) = 0.0;

%% / * main * /
for ibu = 0 : 0.000001 :0.01
  V = zeros(length(time),1);                V(1) = 0;
  w = zeros(length(time),1);                w(1) =0.1;
  Fai = zeros(length(time),1);              Fai(1) = 0;
  I_slow = zeros(length(time),1);           I_slow(1) = 0.02;
  for i=2:length(time)
    

        m_inf=0.5*(1+tanh((V(i-1)-v1)./v2));

        V(i) = V(i-1) + (1./Cm*(-g_Ca*m_inf*(V(i-1)-v_Ca)-g_K*w(i-1)*(V(i-1)-v_K)-g_L*(V(i-1)-v_L)+I_ext+I_slow(i-1)-k1*(0.1+0.06*Fai(i-1).^2).*V(i-1)))*dt;%

          w_inf=0.5*(1+tanh((V(i-1)-v3)./v4));
          tau_w=1./(cosh((V(i-1)-v3)/(2*v4)));
        w(i) = w(i-1) + (phi*(w_inf-w(i-1))./tau_w)*dt;
        I_slow(i) = I_slow(i-1) + (ibu*(-0.22-V(i-1)-alpha*I_slow(i-1)))*dt;

        Fai(i) = Fai(i-1) + (k3*V(i-1)-k2*Fai(i-1)+A*cos(omiga*i))*dt;%
        
        
  end
  
  [pks,locs]=findpeaks(V(tEnd*80:end)); 
       for i = 3 : length(locs)-1
           if (locs(i)-locs(i-1)) > 5000
           fprintf(fid,'%12.8f %12.8f\n',ibu, (locs(i)-locs(i-1))./1000);
           end
           
       end
end
 fclose(fid);
output.info.completiontime = toc;
fprintf('ODE solution time: %.3f seconds\n', output.info.completiontime)

