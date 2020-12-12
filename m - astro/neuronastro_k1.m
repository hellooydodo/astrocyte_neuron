clear;
tic
timeStart = datetime('now');
fprintf('Start time is %s\n', char(timeStart));

fid=fopen('Astrocyte_k1_80.dat','w');

% k1=0.5;
k2=0.5;k3=1;%磁感应耦合强度
I_ext=0.2;
A=1;omiga=0.1;%外加磁感应刺激强度

IP3s=0.16;alpha=0.0005;
g_Ca=1;v_Ca=1;g_K=2;v_K= -0.7;g_L=0.5;v_L= -0.5;
Cm=1;v0=0.2;v1=-0.01;v2=0.15;v3=0.1;v4=0.145;ibu=0.1;
theta_s=0.2;sigma_s=0.02;phi=1.15;r_IP3=80;
g_amma=0.0;tau_IP3=7; tau_Ca=6;kappa=0.5;Ca_th=0.2;
% 	***************************************************************************/

tEnd = 20000;
dt = 0.01;
time = 0:dt:tEnd;
  
  for k1 = 0 : 0.01 :1.0
  V = zeros(length(time),1);                V(1) = 0;
  w = zeros(length(time),1);                w(1) =0.1;
  Fai = zeros(length(time),1);              Fai(1) = 0;
  IP3 = zeros(length(time),1);              IP3(1) = 0.2;
  Ca = zeros(length(time),1);               Ca(1) = 0.1;
  q = zeros(length(time),1);                q(1) = 0.2;
  f = zeros(length(time),1);                f(1) = 0.2;
  I_slow = zeros(length(time),1);           I_slow(1) = 0.02;
      for i=2:length(time)
    

        m_inf=0.5*(1+tanh((V(i-1)-v1)./v2));

        V(i) = V(i-1) + (1./Cm*(-g_Ca*m_inf*(V(i-1)-v_Ca)-g_K*w(i-1)*(V(i-1)-v_K)-g_L*(V(i-1)-v_L)+I_ext+I_slow(i-1) -g_amma*f(i-1)-k1*(0.1+0.06*Fai(i-1).^2).*V(i-1)))*dt;%

          w_inf=0.5*(1+tanh((V(i-1)-v3)./v4));
          tau_w=1./(cosh((V(i-1)-v3)/(2*v4)));
        w(i) = w(i-1) + (phi*(w_inf-w(i-1))./tau_w)*dt;
        I_slow(i) = I_slow(i-1) + (0.002*(-0.22-V(i-1)-alpha*I_slow(i-1)))*dt;

        Fai(i) = Fai(i-1) + (k3*V(i-1)-k2*Fai(i-1)+A*cos(omiga*i))*dt;
        
          T_cou=1./(1+exp(-(V(i-1)-theta_s)./sigma_s));%耦合
          c=0.01;
        IP3(i) = IP3(i-1)+ (c*((IP3s-IP3(i-1))./tau_IP3+r_IP3*T_cou))*dt;
        
          Jchannel=0.185*6*(IP3(i-1)/(IP3(i-1)+0.13))^3.*(Ca(i-1)/(Ca(i-1)+0.08234))^3.*q(i-1)^3*(Ca(i-1)-(2.0-Ca(i-1))/0.185);
	      Jpump=0.9.*(Ca(i-1).^2)/(0.01+Ca(i-1).^2);
	      Jleak=0.185*0.11*(Ca(i-1)-(2.-Ca(i-1))/0.185);
        Ca(i) =Ca(i-1) +(c.*(-Jchannel-Jpump-Jleak))*dt;

        q(i) = q(i-1) + (c.*(0.2*1.05*(IP3(i-1)+0.13)/(IP3(i-1)+0.9434)*(1-q(i-1))-0.2*Ca(i-1)*q(i-1)))*dt;
        f(i) = f(i-1) + (-f(i-1)./tau_Ca+(1-f(i-1))*kappa*(Ca(i-1)>Ca_th)*(Ca(i-1)-Ca_th))*dt;
      end
      [pks,locs]=findpeaks(V(tEnd*80:end));
      
       for i = 3 : length(locs)-1
           fprintf(fid,'%12.8f %12.8f\n',k1, (locs(i)-locs(i-1))./tEnd);
       end
      
  end
  

 fclose(fid);

output.info.completiontime = toc;
fprintf('ODE solution time: %.3f seconds\n', output.info.completiontime)


