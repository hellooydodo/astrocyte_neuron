#include <iostream>
#include <stdio.h>
#include <math.h>
#include <ctime>
#include <stdlib.h>
#include <time.h>

#define  cm 20
#define  e 2.71828

int const  N=101;//����ѡ��������Ϊ�˼�����м�ĵ�


double D=0.26;//,T;//T�Ǹ�ɶ
double step=0.01;
//double ar=1.1,ad=0.19;//AMPAd�����
double ar=5.0,ad=0.18;//GABA�����
double Vsyn=-60.0;//GABA�������-60��AMPA�������0
//double Vsyn=0;

double v[N+2][N+2],n[N+2][N+2],s[N+2][N+2];//m[N+2][N+2],h[N+2][N+2],
double v0[N+2][N+2],n0[N+2][N+2],s0[N+2][N+2];//m0[N+2][N+2],h0[N+2][N+2],


int const time_step=100001;

FILE *fp1,*fp2,*fp3,*fp4,*fp5,*fp6,*fp7,*fp8;//,*fp3,*fp4,*fp5,*fp6,*fp7,*fp8,*fp9,*fp10,*fp11,*fp12,*fp13;//,*fp12,*fp13,*fp14,*fp15,*fp16,*fp17,*fp18;
                                   //fp5��fp6�ֱ�洢n��s
double f(double v,double n,double Iapp,double Isy)
{
	double Ica,Ik,Il,result;
	Ica=4.4*0.5*(1+tanh((v+1.2)/18))*(v-120);//na�絼
	Ik=8*n*(v+84);//k�絼��
	Il=2*(v+60);//©�絼��
	result=(-Ica-Ik-Il+Iapp+Isy)/cm;
	return result;//���ط���6��ǰ����
}
double gn(double v,double n)
{
	double result,tn,nn;
	tn=1/cosh((v-2)/60);
	nn=0.5*(1+tanh((v-2)/30));
	result=0.04*(nn-n)/tn;
	return result;
}
double gs(double v,double s)
{
	double result;
	result=-ad*s;
return result;
}
int main()
{
	int ss,i,j;
    double Isy;
    double times=0.0;
	int N_middle;
	if(N%2==1)
    {
	N_middle=(N+1)/2;
    }
		if(N%2==0)
    {
	N_middle=N/2;
    }
double Vsmall[2][N+1];//����1��1�㵽�м��Ǹ��㣬��һ�д�v���ڶ��д���������Сֵ��ʱ��
//    fp1=fopen("001v1D44noisy03.dat","wb");
	    //fp1=fopen("GABAD026history.dat","wb");
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
   for(i=0;i<=N+1;i++)
    	{
    		for(j=0;j<=N+1;j++)
    			{
    				v0[i][j]=-50.333;
                    n0[i][j]=0.3086478;
					s0[i][j]=0.8527076;
            }
    	}
    for(i=41;i<=43;i++)
    	{
    		for(j=1;j<=N_middle;j++)
    			{
				   	v0[i][j]=-33.35202;
                    n0[i][j]=0.460674;
					s0[i][j]=0.8367547;
			}
    	}
    for(i=44;i<=46;i++)
      {
      	for(j=1;j<=N_middle;j++)
         	{
		 v0[i][j]=0.02615987;
          n0[i][j]=0.5109428;
           s0[i][j]=0.5672657;
            }
      }
    for(i=47;i<=N_middle-1;i++)
    	{
      	for(j=1;j<=N_middle;j++)
         	{
            	v0[i][j]=33.324;
                n0[i][j]=0.3068459;
				s0[i][j]=0.3049031;
            }
      }//initial conditions
   /* for(i=1;i<=N;i++) //����v0��v�û죬����ֱ�Ӱѳ�ֵ������
    	{
          v0[0][i]=v[N+1][i];
          v0[N+1][i]=v[0][i];
          v0[i][0]=v[i][N+1];
          v0[i][N+1]=v[i][0];
      }//periodic boundary condition*/
	double delta_sumV=1.0;//%����ѭ��
    double Vsumold=100;//%��¼��һ����Ĥ��λ֮��
	double Vsum=0;
	ss=0;
	// for(ss=0;ss<=time_step;ss++)
	while (delta_sumV>-1)
    {
	  times+=step;
	  ss=ss+1;
	  double Iex=110;//the external current
      double AA=0,BB=0,CC=0;
      for(i=1;i<=N;i++) //�������Ҫ���֣����󣬱߽�û���ر���
      {
          for(j=1;j<=N;j++)
		  {

	    	Isy=-D*(s0[i][j+1]+s0[i][j-1]+s0[i+1][j]+s0[i-1][j])*(v0[i][j]-Vsyn);
			double r= rand() / 32768.0;//�������һ��noisy
			if ((i<8 && j<8) || (i>(N-8) && j>(N-8)) || (i<8 && j>(N-8)) || (i>(N-8) && j<8)){
			//if(i>(N_middle-8) && j>(N_middle-8) && i<=(N_middle+8) && j<=(N_middle+8)){
                    Isy = Isy + 1.5*2*(r - 0.5)*Isy;
            }
			v[i][j]=v0[i][j]+f(v0[i][j],n0[i][j],Iex,Isy)*step;//+(r*2-1)*0.3;// *pow(10,-2);
            n[i][j]=n0[i][j]+gn(v0[i][j],n0[i][j])*step;
			if(v0[i][j]<2)
			{
		    s[i][j]=s0[i][j]+gs(v0[i][j],s0[i][j])*step;
			}
			else
			{s[i][j]=1;}

        }
		}
	/* 	for(i=44;i<=54;i++)
		{
			for(j=39;j<=49;j++)
			{
            BB=BB+v0[i][j];
			}
		} //Ĥ��λƽ����*/
	 // BB=BB/121;
      /* for(i=1;i<=N;i++)
       	{
          v0[0][i]=v[N+1][i];
          v0[N+1][i]=v[0][i];
          v0[i][0]=v[i][N+1];
          v0[i][N+1]=v[i][0];
         	}*/
/*
         if(ss==100)
		 {
			 for(i=1;i<=N_middle;i++)
			 {
				  Vsmall[0][i]=v[i][i];//��һ�д�v,�ڶ��д�ʱ�䡣����ֵ
				  Vsmall[1][i]=ss/100;
			 }
		 }
		 if(ss>100)
		 {
		 for(i=1;i<=N_middle;i++)//��ʱv��û�и�ֵ��v0����v0��¼������һ����ֵ�����ﲻ�Ǻ���һ���ȣ��Ǻ��Ѿ��洢��Vsmall����
		 {
			 if (v[i][i]<=Vsmall[0][i])
			 {
				  Vsmall[0][i]=v[i][i];//��һ�д�v,�ڶ��д�ʱ�䡣����ֵ
				  Vsmall[1][i]=ss/100;
			 }
		 }
		 }*/

         for(i=1;i<=N;i++)
         	{
            	for(j=1;j<=N;j++)
               	{
                  	 v0[i][j]=v[i][j];
                     n0[i][j]=n[i][j];
                    // m0[i][j]=m[i][j];
                     //h0[i][j]=h[i][j];
                     s0[i][j]=s[i][j];
                  }
            }//�ڱ߽��ڣ�v0=v,�����ʱ����Ԫ�ŵ����
//         if(ss>=800000&&ss%10==0)
	//		{
		//	fprintf(fp7,"%f\n",BB);
			//}

		 Vsum=v0[N_middle][N_middle];
         delta_sumV=abs(Vsum-Vsumold);
         Vsumold=Vsum;

	        if (ss%100 == 0){
            char s3[255] = "v_GABAD01_middle.txt";
            fp7 = fopen(s3,"a+");
            fprintf(fp7,"%.4f\n",v0[N_middle][N_middle]);
            fclose(fp7);
        }

         if(ss%(10000*100)==0) //z����ֻ��100ms
         	{
				//FILE *fp2;
        char s[255];
            char s1[255];
            char s2[255];
                 //scanf_s("%d",&ss);
            sprintf(s, "%dvGABAD01.txt", ss/100);
            sprintf(s1, "%dnGABAD01.txt", ss/100);
            sprintf(s2, "%dsGABAD01.txt", ss/100);
            fp2=fopen(s,"w");//fp2����ÿһǧ�����¼һ����ͼ
            fp5=fopen(s1,"w");//fp5����ÿһǧ�����¼һ������n
            fp6=fopen(s2,"w");//fp6����ÿһǧ�����¼һ������s
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

  /*  if(ss%100==0)
	{
		fprintf(fp1,"%d %.4f %.4f\n",ss/100,v0[1][1],v0[N_middle][N_middle]);
            fp4=fopen("TsmallGABAD026.dat","wb");
			for(i=1;i<=N_middle;i++)
				     {
					char s[255];
                 //scanf_s("%d",&ss);
                 sprintf(s, "%dhistoryGABAD026.txt", i);
                 fp3=fopen(s,"a");//б�ŵ�ÿ��������̶���¼��Ϊ���о���ͼ���γ��ٶȡ�"a"����д�ķ�ʽ���ļ������Ƶ��ļ���ĩβ����������ڻ��Զ��������ļ�
		    	 fprintf(fp3,"%d %.4f\n",ss/100,v0[i][i]);
				 				fclose(fp3);
                 fprintf(fp4,"%d %.4f\n",i,Vsmall[1][i]);

			      }
			fclose(fp4);
//			printf("%d %.4f\n",ss/100,delta_sumV);
	}*/
   }

      return(0);
}
