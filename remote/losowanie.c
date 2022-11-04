#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>

void main(){
   srand(time(NULL));
   int min = 1;
   int max = 2;
   int L = max - min + 1;
   int i = rand()%L + min;
   if (i==1){
      printf("Milego koncertu Maciek :)\n");
   }
   if(i==2){
      printf("Milego koncertu Jasiek :)\n");
   }
   

}