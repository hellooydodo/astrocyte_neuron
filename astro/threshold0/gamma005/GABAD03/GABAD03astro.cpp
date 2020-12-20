#include <iostream>
#include <stdio.h>
#include <math.h>
#include <ctime>
#include <stdlib.h>
#include <time.h>
#define  e 2.71828

int const  N = 101;//这里选个奇数，为了检测最中间的点

double dt = 1e-2; //0.01ms
//double ar = 1.1,ad = 0.19;//AMPAd的情况
double ar=5.0,ad=0.18;//GABA的情况
double Vsyn = -0.5;//GABA的情况是-0.3，AMPA的情况是0

double v[N+2][N+2],n[N+2][N+2];//m[N+2][N+2],h[N+2][N+2],
double v0[N+2][N+2],n0[N+2][N+2];//m0[N+2][N+2],h0[N+2][N+2],
double Ip3[N+2][N+2],Ca[N+2][N+2],J_g[N+2][N+2],T[N+2][N+2],I_slow[N+2][N+2],g[N+2][N+2];
double Ip3_0[N+2][N+2],Ca0[N+2][N+2],I_slow0[N+2][N+2],g0[N+2][N+2];
double q[N+2][N+2],q0[N+2][N+2];
double f[N+2][N+2],f0[N+2][N+2];
double I_ast[N+2][N+2];
int const time_step = 100001;

FILE *fp1,*fp2,*fp3,*fp4,*fp5,*fp6,*fp7,*fp8;//,*fp3,*fp4,*fp5,*fp6,*fp7,*fp8,*fp9,*fp10,*fp11,*fp12,*fp13;//,*fp12,*fp13,*fp14,*fp15,*fp16,*fp17,*fp18;
                                   //fp5和fp6分别存储n和s
double max(double a,double b){
    if (a > b) return a;
    else return b;
}

double n_inf(double v){ //Eq.9
    double ans;
	//double V3 = 2, V4 = 30;
	double V3 = 0.0167, V4 = 0.25;
    ans = 0.5*(1 + tanh((v - V3)/V4));
    return ans;
}

double tau_n(double v){
    double ans;
	//double V3 = 2, V4 = 30;
	double V3 = 0.0167, V4 = 0.25;
    ans = 1/cosh((v - V3)/(2*V4));
    return ans;
}

double Iion(double v,double n) //Eq.1
{
	double Ica,Ik,Il,ans;
	//double V1 = -1.2, V2 = 18; 
	double V1 = -0.01, V2 = 0.15; 
	//double gl = 2, gk = 8, gca = 4.4;
	double gl = 0.5, gk = 2.0, gca = 1.1;
	//double Vl = -60, Vk = -84, Vca = 120;
	double Vl = -0.5, Vk = -0.7, Vca = 1.0;
	Il = gl*(v - Vl);//漏电导项
	Ik = gk*n*(v - Vk);//k电导项
	Ica = gca*0.5*(1 + tanh((v - V1)/V2))*(v - Vca);//na电导
	ans = -Ica - Ik - Il;
	return ans;
}

int main()
{
	int ss;
    double Isy[N+2][N+2];
    double times=0.0;
	int N_middle;
	if(N % 2 == 1)
        N_middle = (N + 1)/2;
    else N_middle=N/2;

//    fp1=fopen("001v1D44noisy03.dat","wb");
//	    fp1=fopen("GABAD026history.dat","wb");
//	fp9=fopen("4v131.dat","wb");
//	fp10=fopen("6v131.dat","wb");
//		fp11=fopen("8v131.dat","wb");
//			fp12=fopen("10v131.dat","wb");
//    fp2=fopen("v2.dat","wb");
//    fp3=fopen("v3.dat","wb");
//    fp4=fopen("v4.dat","wb");
//    fp5=fopen("P.dat","wb");
//    fp6=fopen("timeseries.dat","wb");
//    fp7=fopen("membrane.dat","wb");
//    fp8=fopen("synaptic.dat","wb");
///////initial conditions//////////////////////

   for (int i = 1; i <= N; i++){
   		for (int j = 1; j <= N; j++){
   			Ip3_0[i][j] = 0.2;
   			q0[i][j] = 0.5;
   			Ca0[i][j] = 0.5;
   			f[i][j] = 0.5;
		   }
   }
   for(int i = 1; i <= N;i++){ //（4）
        for(int j = 1;j <= N;j++){
                v0[i][j]=-0.419417;
                n0[i][j]=0.3086478;
                g0[i][j]=0.8527076;
        }
    }
    for(int i = 41;i <= 43;i++){ //（1）
        for(int j = 1;j <= N_middle;j++){
            v0[i][j]=-0.277917;
            n0[i][j]=0.460674;
            g0[i][j]=0.8367547;
        }
    }
    for(int i = 44;i <= 46;i++){ //（2）
        for(int j = 1;j <= N_middle;j++){
            v0[i][j]=2.5e-4;
            n0[i][j]=0.5109428;
            g0[i][j]=0.5672657;
        }
    }
    for(int i = 47;i <= N_middle-1;i++){ //（3）
        for(int j = 1;j <= N_middle;j++){
            v0[i][j]=0.277667;
            n0[i][j]=0.3068459;
            g0[i][j]=0.3049031;
        }
    }

    double const Iex = 0.22916;//the external current
    double const cm = 5, phi = 0.04; //v,n
    double const c1 = 0.185, v1 = 6, v2 = 0.11, v3 = 0.9, k3 = 0.5; // Jchannel,Jpump,Jleak;
	double const d1 = 0.13, d2 = 1.049, d3 = 0.9434, d5 = 0.08234, a2 = 0.2, c0 = 2; //m_inf,n_inf,alpha_q,beta_q,Ca_er ...
	//数据来自 Spontaneous Oscillations of Dressed neurons，羊师兄
    double const Ip3_st = 0.16, tau_Ip3 = 7,r_ip3 = 7.2;


    double const k_g = 0.1; // Jg
	double const theta_s = 0.2, delta_s = 0.02; // [T]
	double const alpha = 0.001, v_star = -0.22, epsilon = 0.0005; // Islow
    double const alpha_s = 0.1, beta_s = 0.05; //g
    double const g_s = 0.075; // Isy,相当于D
    double const tau_ca = 6, kappa = 0.5, Ca_th = 0.2; //f
    double const gamma = 0.05, P = 0.8; //Iast

	ss = 0;
	bool astro = 1;
	// for(ss=0;ss<=time_step;ss++)
    while (1)
    {
        times += dt;
        ss = ss + 1;
        for(int i = 1; i <= N; i++){
            for (int j = 1; j <= N; j++){
            	T[i][j] = 1/(1 + exp(-(v0[i][j] - theta_s)/delta_s)); // T是神经元的属性
                if (astro && i<N && j<N){ // 胶质细胞相关

                	double alpha_q = a2*d2*(Ip3_0[i][j] + d1)/(Ip3_0[i][j] + d3);
                	double beta_q = a2*Ca0[i][j];
                	q[i][j] = q0[i][j] + ((alpha_q)*(1 - q0[i][j]) - beta_q*q0[i][j])*dt;
                	//q 表示活跃的Ip3受体比例

                	J_g[i][j] = k_g*((Ip3_0[i+1][j] + Ip3_0[i][j+1] + Ip3_0[i-1][j] + Ip3_0[i][j-1]) - 4*Ip3_0[i][j]); //胶质细胞连接
                	Ip3[i][j] =  Ip3_0[i][j] + ((Ip3_st - Ip3_0[i][j])/tau_Ip3 + r_ip3 * (T[i][j] + T[i][j+1] + T[i+1][j] + T[i+1][j+1]) + J_g[i][j])*dt;
                	// Ip3是胶质细胞的属性
                	// T表示了神经元递质，加权项表达了胶质细胞和周围神经元的连接，(i,j)胶质细胞附近的神经元编号为(i,j),(i,j+1),(i+1,j),(i+1,j+1)...

                	double m_infj = Ip3_0[i][j]/(Ip3_0[i][j] + d1);
                	double n_infj = Ca0[i][j]/(Ca0[i][j] + d5);
                	double Ca_er = (c0 - Ca0[i][j])/c1;
                	double J_channel = c1*v1*pow(m_infj,3)*pow(n_infj,3)*pow(q0[i][j],3)*(Ca_er - Ca0[i][j]); //check
                	double J_pump = -v3*pow(Ca0[i][j],2)/(pow(k3,2)+pow(Ca0[i][j],2)); //check
                	double J_leak = c1*v2*(Ca_er - Ca0[i][j]); //check
                	Ca[i][j] = Ca0[i][j] + (J_channel + J_pump + J_leak)*dt;
					//if (i == N_middle && j == N_middle)
					//	printf("m_infj=%.4f n_infj=%.4f Ca_er=%.10f J_channel=%.10f J_pump=%.10f J_leak=%.10f Ca=%.10f\n",m_infj,n_infj,Ca_er,J_channel,J_pump,J_leak,Ca0[i][j]);
                	f[i][j] = f0[i][j] + (-f0[i][j]/tau_ca + (1 - f0[i][j])*kappa*max(Ca[i][j] - Ca_th,0))*dt; //胶质细胞和神经元的连接 
                	//f表示了某一个胶质细胞和周围所有神经元的连接性，这个连接性只有胶质细胞（Ca浓度）决定 
                	I_ast[i][j] = gamma*P*(f0[i-1][j-1] + f0[i][j-1] + f0[i-1][j] + f0[i][j]);
                	//表示了某一个神经元受到周围胶质细胞的影响，(i,j)神经元附近的胶质细胞如上 
				}			
                I_slow[i][j] = I_slow0[i][j] + epsilon*(v_star - v0[i][j] - alpha*I_slow0[i][j])*dt;
                g[i][j] = g0[i][j] + (alpha_s*T[i][j]*(1 - g0[i][j]) - beta_s*g0[i][j])*dt; // g  神经元开度
                Isy[i][j] = -g_s*(v0[i][j] - Vsyn)*(g0[i-1][j] + g0[i][j-1] + g0[i+1][j] + g0[i][j+1]); //统一了羊师兄和王荣师兄的形式
                n[i][j] = n0[i][j] + phi*((n_inf(v0[i][j]) - n0[i][j])/tau_n(v0[i][j]))*dt;
                
                v[i][j] = v0[i][j] + (Iion(v0[i][j],n0[i][j])+ Iex + Isy[i][j] + I_slow0[i][j] +  I_ast[i][j])/cm*dt;
				if (v0[i][j] < 0 ){
                	g[i][j] = g0[i][j] + ( -ad * g0[i][j])*dt;
				}
                else {g[i][j] = 1; }
            }
        }
		//printf("v = %.4f T = %.6f q = %.6f Ip3 = %.10f I_slow = %.6f J_g = %.10f Ca = %.10f f = %.10f  I_ast = %.10f I_sy = %.10f g = %.10f\n",
		//v[N_middle][N_middle],T[N_middle][N_middle],q[N_middle][N_middle],Ip3[N_middle][N_middle],I_slow[N_middle][N_middle],
		//J_g[N_middle][N_middle],Ca[N_middle][N_middle],f[N_middle][N_middle],I_ast[N_middle][N_middle],Isy[N_middle][N_middle],g[N_middle][N_middle]);
		for(int i = 1;i <= N;i++){
            for(int j = 1;j <= N;j++){
                v0[i][j] = v[i][j];
                n0[i][j] = n[i][j];
				Ca0[i][j] = Ca[i][j];
                f0[i][j] = f[i][j];
                q0[i][j] = q[i][j];
                Ip3_0[i][j] = Ip3[i][j];
                g0[i][j] = g[i][j];
                I_slow0[i][j] = I_slow[i][j];
            }
        }//在边界内，v0=v,即这个时刻神经元放电情况
//         if(ss>=800000&&ss%10==0)
	//		{
		//	fprintf(fp7,"%f\n",BB);
			//}

        if (ss%100 == 0){
            char s3[255] = "v_GABAD03_middle.txt";
            fp7 = fopen(s3,"a+");
            fprintf(fp7,"%.4f\n",v0[N_middle][N_middle]);
            fclose(fp7);
            char s4[255] = "v_Isyn_GABAD03_sample.txt";
            fp8 = fopen(s4,"a+");
            fprintf(fp8,"%.4f %4f\n",v0[44][55],Isy[44][55]);
            fclose(fp8);
            /*char s4[255] = "Isy_GABAD03_middle.txt";
            fp8 = fopen(s4,"a+");
            fprintf(fp8,"%.4f\n",Isy[N_middle][N_middle]);
            fclose(fp8);*/
        }
        if(ss%(10000*100)==0){
				//FILE *fp2;
            char s[255];
            char s1[255];
            char s2[255];

                 //scanf_s("%d",&ss);
            sprintf(s, "%dvGABAD03.txt", ss/100);
            sprintf(s1, "%dnGABAD03.txt", ss/100);
            sprintf(s2, "%dsGABAD03.txt", ss/100);
            fp2=fopen(s,"w");//fp2存着每一千毫秒记录一个斑图
            fp5=fopen(s1,"w");//fp5存着每一千毫秒记录一个变量n
            fp6=fopen(s2,"w");//fp6存着每一千毫秒记录一个变量s
            for(int i = 1;i <= N;i++){
                for(int j = 1;j < N;j++){
                    fprintf(fp2,"%.4f ",v0[i][j]);
                }
                fprintf(fp2,"%.4f",v0[i][N]);
                fprintf(fp2,"\n");
            }
            fclose(fp2);
            for(int i = 1;i <= N;i++){
                for(int j = 1;j < N;j++){
                    fprintf(fp5,"%.4f ",n0[i][j]);
                }
                fprintf(fp5,"%.4f",n0[i][N]);
                fprintf(fp5,"\n");
            }
            fclose(fp5);
            for(int i = 1;i <= N;i++){
                for(int j = 1;j < N;j++){
                    fprintf(fp6,"%.4f ",g0[i][j]);
                }
                fprintf(fp6,"%.4f",g0[i][N]);
                fprintf(fp6,"\n");
            }
            fclose(fp6);
            printf("%d",ss/100);
        }

    }
    return(0);
}
