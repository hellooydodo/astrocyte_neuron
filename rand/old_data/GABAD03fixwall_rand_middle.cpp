#include <iostream>
#include <stdio.h>
#include <math.h>
#include <ctime>
#include <stdlib.h>
#include <time.h>

#define  cm 20
#define  e 2.71828

int const  N = 101;//这里选个奇数，为了检测最中间的点


double D = 0.3;//,T;//T是个啥
double dt = 0.01; //0.01ms
//double ar = 1.1,ad = 0.19;//AMPAd的情况
double ar=5.0,ad=0.18;//GABA的情况
double Vsyn = -60;//GABA的情况是-60，AMPA的情况是0

double v[N+1][N+1],n[N+1][N+1],s[N+1][N+1];//m[N+2][N+2],h[N+2][N+2],
double v0[N+1][N+1],n0[N+1][N+1],s0[N+1][N+1];//m0[N+2][N+2],h0[N+2][N+2],

int const time_step = 100001;

FILE *fp1,*fp2,*fp3,*fp4,*fp5,*fp6;//,*fp3,*fp4,*fp5,*fp6,*fp7,*fp8,*fp9,*fp10,*fp11,*fp12,*fp13;//,*fp12,*fp13,*fp14,*fp15,*fp16,*fp17,*fp18;
                                   //fp5和fp6分别存储n和s
double max(double a,double b){
    if (a > b) return a;
    else return b;
}

double power(double a, int b){
    if (b == 0)
        return 1;
    else if(b % 2 == 1)
        return a*power(a*a,b>>1);
    else
        return power(a*a,b>>1);
}

double m_inf(double v){ //Eq.7
    double ans,V1 = -1.2, V2 = 18;
    ans = 0.5*(1 + tanh((v - V1)/V2));
    return ans;
}

double n_inf(double v){ //Eq.9
    double ans,V3 = 2, V4 = 30;
    ans = 0.5*(1 + tanh((v - V3)/V4));
    return ans;
}

double tau_n(double v){
    double ans,V3 = 2, V4 = 30;
    ans = 1/cosh((v - V3)/(2*V4));
    return ans;
}

double Iion(double v,double n) //Eq.1
{
	double Ica,Ik,Il,ans;
	double gl = 2, gk = 8, gca = 4.4;
	double Vl = -60, Vk = -84, Vca = 120;
	Il = gl*(v - Vl);//漏电导项
	Ik = gk*n*(v - Vk);//k电导项
	Ica = gca*m_inf(v)*(v - Vca);//na电导
	ans = -(Ica + Ik + Il);
	return ans;
}


double Eq2(double v,double n){
    double lambda = 0.04;
	double ans,tn,nn;
	ans=lambda*(n_inf(v)-n)/tau_n(v);
	return ans;
}

double gs(double v,double s){
	double ans;
	ans = -ad*s;
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

double Vsmall[2][N+1];//储存1，1点到中间那个点，第一列存v，第二列存所经历最小值的时间
//    fp1=fopen("001v1D44noisy03.dat","wb");
	    fp1=fopen("GABAD026history.dat","wb");
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
   for(int i = 0; i <= N+1;i++){ //（4）
        for(int j = 0;j <= N+1;j++){
                v[i][j]=0;
                n[i][j]=0;
                s[i][j]=0;
        }
    }
   for(int i = 1; i <= N;i++){ //（4）
        for(int j = 1;j <= N;j++){
                v0[i][j]=-50.333;
                n0[i][j]=0.3086478;
                s0[i][j]=0.8527076;
        }
    }
    for(int i = 41;i <= 43;i++){ //（1）
        for(int j = 1;j <= N_middle;j++){
            v0[i][j]=-33.35202;
            n0[i][j]=0.460674;
            s0[i][j]=0.8367547;
        }
    }
    for(int i = 44;i <= 46;i++){ //（2）
        for(int j = 1;j <= N_middle;j++){
            v0[i][j]=0.02615987;
            n0[i][j]=0.5109428;
            s0[i][j]=0.5672657;
        }
    }
    for(int i = 47;i <= N_middle-1;i++){ //（3）
        for(int j = 1;j <= N_middle;j++){
            v0[i][j]=33.324;
            n0[i][j]=0.3068459;
            s0[i][j]=0.3049031;
        }
    }
///////////periodic boundary condition//////////////
 /*   for(int i = 1;i <= N;i++){ //用第0列存第N-1列的值，来实现周期化
          v0[N][i] = v0[1][i];
          v0[i][N] = v0[i][1];
          n0[N][i] = n0[1][i];
          n0[i][N] = n0[i][1];
          s0[N][i] = s0[1][i];
          s0[i][N] = s0[i][1];
          v0[0][i] = v0[N-1][i];
          v0[i][0] = v0[i][N-1];
          n0[0][i] = n0[N-1][i];
          n0[i][0] = n0[i][N-1];
          s0[0][i] = s0[N-1][i];
          s0[i][0] = s0[i][N-1];
      }
//////////////////////////////////////////*/

	double delta_sumV = 1.0;//%进入循环
    double Vsumold = 100;//%记录上一步的膜电位之和
	double Vsum = 0;
    double const Iex = 110;//the external current
    double const c1 = 0.185, v1 = 6, v2 = 0.11, v3 = 0.9, k3 = 0.1, d1 = 0.13, d2 = 1.049, d3 = 0.9434, d5 = 0.08234, a2 = 0.2, c0 = 2; //数据来自 Spontaneous Oscillations of Dressed neurons
    double const Ip3_st = 0.16, tau_Ip3 = 0.00014,r_ip3 = 0.0072;
    double const tau_ca = 6, kappa = 0.5, Ca_th = 0.2, gamma = 1;
    /*double Ip3[N+1][N+1],Ca[N+1][N+1];
    double Ip3_0[N+1][N+1],Ca0[N+1][N+1];
    double q[N+1][N+1],q0[N+1][N+1];
    double f[N+1][N+1],f0[N+1][N+1];
    double I_ast[N+1][N+1];*/
	ss = 0;
	// for(ss=0;ss<=time_step;ss++)
    while (delta_sumV > -1)
    {
        times += dt;
        ss = ss + 1;
        /*for(int i = 1; i < N; i++){
            for (int j = 1; j < N; j++){
                double m_infj = Ip3_0[i][j]/(Ip3_0[i][j] + d1);
                double n_infj = Ca0[i][j]/(Ca0[i][j] + d5);

                Ip3[i][j] =  Ip3_0[i][j] + ((Ip3_st - Ip3[i][j])/tau_Ip3 + r_ip3 * max(v[i][j] - 50,0))*dt;
                double alpha_q = a2*d2*(Ip3_0[i][j] + d1)/(Ip3_0[i][j] + d3);
                double beta_q = a2*Ca0[i][j];
                double Ca_er = (c0 - Ca[i][j])/c1;
                q[i][j] = q0[i][j] + ((alpha_q)*(1 - q0[i][j]) - beta_q*q0[i][j])*dt;
                double J_channel = c1*v1*power(m_infj,3)*power(n_infj,3)*power(q[i][j],3)*(Ca[i][j] - Ca_er);
                double J_pump = v3*power(Ca[i][j],2)/(power(k3,2)+power(Ca[i][j],2));
                double J_leak = c1*v2*(Ca[i][j] - Ca_er);

                Ca[i][j] = Ca0[i][j] - (J_channel + J_pump + J_leak)*dt;
        // 胶质细胞作用

                f[i][j] = f0[i][j] + (-f0[i][j]/tau_ca + (1 - f0[i][j])*kappa*max(Ca[i][j] - Ca_th,0))*dt;
                I_ast[i][j] = gamma * f[i][j];
                I_ast[i][j] = 0;
            }
        }*/


        for(int i = 1;i <= N;i++){ //计算的主要部分
            for(int j = 1;j <= N;j++){
                Isy[i][j] = -D * (s0[i][j+1] + s0[i][j-1] + s0[i+1][j] + s0[i-1][j]) * (v0[i][j] - Vsyn); //Eq.4
                double r = rand() ;
                //if ((i <=8 && j <=8) || (i <=8 && j > (N-8)) || (i >(N-8) && j <=8) || (i>(N-8) && j >(N-8)) )
                if(i>(N_middle-4) && j>(N_middle-4) && i<=(N_middle+4) && j<=(N_middle+4)){
                    Isy[i][j] = Isy[i][j] + 0.5*((r % 2) - 1)*Isy[i][j];
                }
                v[i][j] = v0[i][j] + (Iion(v0[i][j],n0[i][j])+ Iex + Isy[i][j] )/cm*dt;
                n[i][j] = n0[i][j] + Eq2(v0[i][j],n0[i][j])*dt;
                if(v0[i][j] < 2)
                    s[i][j] = s0[i][j] + gs(v0[i][j],s0[i][j])*dt;
                else
                    s[i][j]=1;
            }
        }
        /*
        for(int i = 1;i <= N;i++){ //维护周期化
            v[N][i] = v[1][i];
            v[i][N] = v[i][1];
            n[N][i] = n[1][i];
            n[i][N] = n[i][1];
            s[N][i] = s[1][i];
            s[i][N] = s[i][1];
            v[0][i] = v[N-1][i];
            v[i][0] = v[i][N-1];
            n[0][i] = n[N-1][i];
            n[i][0] = n[i][N-1];
            s[0][i] = s[N-1][i];
            s[i][0] = s[i][N-1];

        } */

 /*      for(int i = 44;i <= 54;i++){
            for(int j = 39;j <= 49;j++){
                BB=BB+v[i][j]; //FFN?
            }
        }

        BB = BB/(N*N); //膜电位平均数

        if(ss == 100){
            for(int i = 1;i <= N_middle;i++){
                Vsmall[0][i] = v[i][i];//第一列存v,第二列存时间。给初值
                Vsmall[1][i] = ss/100;
            }
        }

        if(ss > 100){
            for(int i = 1;i <= N_middle;i++){//此时v还没有赋值给v0，即v0记录的是上一步的值。这里不是和上一步比，是和已经存储的Vsmall来比
                if (v[i][i] <= Vsmall[0][i]){
                    Vsmall[0][i] = v[i][i];//第一列存v,第二列存时间。给初值
                    Vsmall[1][i] = ss/100;
                }
            }
        }*/

        for(int i = 0;i <= N;i++){
            for(int j = 0;j <= N;j++){
                v0[i][j] = v[i][j];
                n0[i][j] = n[i][j];
                // m0[i][j]=m[i][j];
                //h0[i][j]=h[i][j];
                s0[i][j] = s[i][j];
              //  f0[i][j] = f[i][j];
              //  q0[i][j] = q[i][j];
               // Ip3_0[i][j] = Ip3[i][j];
            }
        }//在边界内，v0=v,即这个时刻神经元放电情况
//         if(ss>=800000&&ss%10==0)
	//		{
		//	fprintf(fp7,"%f\n",BB);
			//}

        Vsum = v0[N_middle][N_middle];
        delta_sumV = abs(Vsum-Vsumold);
        Vsumold = Vsum;



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
                    fprintf(fp6,"%.4f ",s0[i][j]);
                }
                fprintf(fp6,"%.4f",s0[i][N]);
                fprintf(fp6,"\n");
            }
            fclose(fp6);
            printf("%d %.4f\n",ss/100,delta_sumV);
        }


        /*if(ss%100==0){
            fprintf(fp1,"%d %.4f %.4f\n",ss/100,v0[1][1],v0[N_middle][N_middle]);
            fp4=fopen("TsmallGABAD026.dat","wb");
            for(int i = 1;i <= N_middle;i++){
                char s[255];
                //scanf_s("%d",&ss);
                sprintf(s, "%dhistoryGABAD026.txt", i);
                fp3 = fopen(s,"a");//斜着的每个点的历程都记录，为了研究斑图的形成速度。"a"是以写的方式打开文件，并移到文件的末尾，如果不存在会自动创建该文件
                fprintf(fp3,"%d %.4f\n",ss/100,v0[i][i]);
                fclose(fp3);
                fprintf(fp4,"%d %.4f\n",i,Vsmall[1][i]);
            }
        fclose(fp4);
//		printf("%d %.4f\n",ss/100,delta_sumV);
        }*/
    }
    return(0);
}
