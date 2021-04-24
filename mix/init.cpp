#include <iostream>
#include <stdio.h>
#include <math.h>
#include <ctime>
#include <stdlib.h>
#include <time.h>

double p = 0.5;
int const  N = 101;//这里选个奇数，为了检测最中间的点
FILE *fp9;
int main(){
	int ampa[N+2][N+2];
	for (int i = 0; i <= N+1; i++){
   		for (int j = 0; j <= N+1; j++){
   			ampa[i][j] = -1;
		   }
	}
   		
	//随机生成兴奋和抑制性突触

	double num_ampa = int(N*N*p);
	int count_ampa = 0;

	while (count_ampa < num_ampa){
		int xx = rand() % N;
		int yy = rand() % N;
		if (xx>0 && yy >0 && ampa[xx][yy] == -1) {
			ampa[xx][yy] = 1;
			//Vsyn[xx][yy] = 0;
			//ad[xx][yy] = 0.19;
			count_ampa++;
		} 
	}
	char s9[255] = "ampa distribution.txt";
	fp9=fopen(s9,"w");
	for (int i = 0; i<=N+1; i++){
		for (int j = 0; j<=N; j++){
			fprintf(fp9,"%d ",ampa[i][j]);
		}
		fprintf(fp9,"%d",ampa[i][N+1]);
		fprintf(fp9,"\n");
	}
	return 0;
}

