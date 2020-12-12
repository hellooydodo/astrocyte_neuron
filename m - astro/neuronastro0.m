clear;
tic
timeStart = datetime('now');
fprintf('Start time is %s\n', char(timeStart));


u0=InitCond();

tspan=[0,10000];
[T,U] = ode45( @hybridastro, tspan, u0, []);

[pks,locs]=findpeaks(U(10000:end,1));

output.info.completiontime = toc;
fprintf('ODE solution time: %.3f seconds\n', output.info.completiontime)

MLplot();

function du = hybridastro(t, u)
indices();
all_constants();
du = zeros(7,1);    % a column vector

% 神经元
  m_inf=0.5*(1+tanh((u(idx.V)-v1)./v2));
du(idx.V) =1./Cm*(-g_Ca*m_inf*(u(idx.V)-v_Ca)-g_K*u(idx.w)*(u(idx.V)-v_K)-g_L*(u(idx.V)-v_L)+I_ext...
    -k1*(0.1+0.06*u(idx.Fai).^2).*u(idx.V)+g_amma*u(idx.f));%k1为神经元与电磁感应耦合强度

  w_inf=0.5*(1+tanh((u(idx.V)-v3)./v4));
  tau_w=1./(cosh((u(idx.V)-v3)/(2*v4)));
du(idx.w) = phi*(w_inf-u(idx.w)).*tau_w;
du(idx.Fai) = k3*u(idx.V)-k2*u(idx.Fai)+A*cos(omiga*t) ;%电磁辐射


% 胶质细胞
T_cou=1./(1+exp(-(u(idx.V)-theta_s)./sigma_s));%耦合
c=0.01;
du(idx.IP3) =c*(IP3s-u(idx.IP3))./tau_IP3+r_IP3*T_cou;
        Jchannel=0.185*6*(u(idx.IP3)/(u(idx.IP3)+0.13)).^3.*(u(idx.Ca)/(u(idx.Ca)+0.08234)).^3.*u(idx.q).^3*(u(idx.Ca)-(2.0-u(idx.Ca))/0.185);
	    Jpump=0.9.*(u(idx.Ca).^2.)/(0.01+u(idx.Ca).^2.);
	    Jleak=0.185*0.11*(u(idx.Ca)-(2.-u(idx.Ca))/0.185);
du(idx.Ca) =c.*(-Jchannel-Jpump-Jleak);
du(idx.q) =c.*(0.2*1.049*(u(idx.IP3)+0.13)/(u(idx.IP3)+0.9434)*(1-u(idx.q))-0.2*u(idx.Ca)*u(idx.q));


du(idx.f)=-u(idx.f)./tau_Ca+(1-u(idx.f))*kappa*(u(idx.Ca)>Ca_th)*(u(idx.Ca)-Ca_th);


end


