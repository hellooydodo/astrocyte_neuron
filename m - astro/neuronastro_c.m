clear;
tic
timeStart = datetime('now');
fprintf('Start time is %s\n', char(timeStart));


    fid=fopen('Astrocyte_change.dat','w');
for    ka=0:0.1:10
    
u0=InitCond();

tspan=[0,1000];
[T,U] = ode45( @hybridastro, tspan, u0, [], ka);
 
  for i = 1:fix(length(U)./2)
      if U(i,1)> max(U(fix(0.02*length(U)):fix(0.04*length(U)),1))
              fprintf(fid,'%12.8f %12.8f\n',ka,i./length(U)*1000);
              break
      end
  end
  
  
end  
    
 fclose(fid);
output.info.completiontime = toc;
fprintf('ODE solution time: %.3f seconds\n', output.info.completiontime)

function du = hybridastro(t, u, ka)
indices();
all_constants();
du = zeros(6,1);    % a column vector
  m_inf=0.5*(1+tanh((u(idx.V)-v1)./v2));
du(idx.V) =-g_Ca*m_inf*(u(idx.V)-v_Ca)-g_K*u(idx.N)*(u(idx.V)-v_K)-g_L*(u(idx.V)-v_L)+I_ext...
    -k1*(0.4+0.06*u(idx.Fai).^2).*u(idx.V)+ka*(u(idx.Ca)>0.19669)*2.11*log(1000*u(idx.Ca)-196.69);
  N_inf=0.5*(1+tanh((idx.V-v3)./v4));
  tau_N=1./(3*(cosh((u(idx.V)-v3)/(2*v4))));
du(idx.N) = phi*(N_inf-u(idx.N)).*tau_N;
du(idx.Fai) = u(idx.V)-k2*u(idx.Fai)+A*cos(omiga*t) ;
   cou=1./(1+exp(-(u(idx.V)-theta_s)./sigma_s));%соєП
c=.01;
du(idx.IP3) =c*(IP3s-u(idx.IP3))*0.14+r_IP3*cou;
        Jchannel=0.185*6*(u(idx.IP3)/(u(idx.IP3)+0.13)).^3.*(u(idx.Ca)/(u(idx.Ca)+0.08234)).^3.*u(idx.q).^3*(u(idx.Ca)-(2.0-u(idx.Ca))/0.185);
	    Jpump=0.9.*(u(idx.Ca).^2.)/(0.01+u(idx.Ca).^2.);
	    Jleak=0.185*0.11*(u(idx.Ca)-(2.-u(idx.Ca))/0.185);
du(idx.Ca) =c.*(-Jchannel-Jpump-Jleak);
du(idx.q) =c.*(0.2*1.049*(u(idx.IP3)+0.13)/(u(idx.IP3)+0.9434)*(1-u(idx.q))-0.2*u(idx.Ca)*u(idx.q));

end


