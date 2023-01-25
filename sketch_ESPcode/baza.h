#ifndef BAZA_H
#define BAZA_H
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
typedef unsigned char byte;
typedef struct karta
{
    char *name;
    char *surname;
    byte *UID;
    struct karta *next;
} KARTA;
#ifdef __cplusplus
extern "C" {
KARTA *allocate(char *name, char *surname, byte *UID);
void add_to_list(KARTA *head, KARTA *NEW);
KARTA *find_by_UID(KARTA *head, byte *UID);
}
#endif
#endif