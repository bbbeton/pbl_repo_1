#include<stdio.h>
#include<time.h>
#include<math.h>

void main(){
    int min = 30;
    int max = 50;
    int L = max - min + 1;
    int i = rand()%L+min;
    printf("Wylosowana liczba to %d\n", i);
    //prosty program losujacy liczbe z przedzialu <30,50> zrobiony na potrzeby repozytorium
}