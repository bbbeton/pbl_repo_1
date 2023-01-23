#include "baza.h"

KARTA *allocate(char *name, char *surname, byte *UID)
{
    KARTA *result = (KARTA *)malloc(sizeof(KARTA));
    if(result == NULL)
    {
        fprint("Error allocating memory for new card!\n");
        exit(1);
    }
    result->name = (char *)malloc((strlen(name) + 1) * sizeof(char));
    if(result->name == NULL)
    {
        fprint("Error allocating memory for name!\n");
        free(result);
        exit(1);
    }
    result->surname = (char *)malloc((strlen(surname) + 1) * sizeof(char));
    if(result->surname == NULL)
    {
        fprint("Error allocating memory for surname!\n");
        free(result);
        free(result->name);
        exit(1);
    }
    strcpy(result->name, name);
    strcpy(result->surname, surname);
    result->next = NULL;
    result->UID = (byte *)malloc(4 * sizeof(byte));
    if(result->UID == NULL)
    {
        fprint("Error allocating memory for UID!\n");
        free(result);
        free(result->name);
        free(result->surname);
        exit(1);
    }
    for(int i = 0; i < 4; i++)
    {
      result->UID[i] = UID[i];
    }  
    return result;
}

void add_to_list(KARTA *head, KARTA *NEW)
{
    if(NEW == NULL)
        return;
    KARTA *current = head;
    while(current != NULL)
    {
        current = current->next;
    }
    current->next = NEW;
}

KARTA *find_by_UID(KARTA *head, byte *UID)
{
    byte count = 0;
    KARTA *current = head->next;
    while(current != NULL)
    {
        for(int i = 0; i < 4; i++)
        {
            if(current->UID[i] == UID[i])
            {
                count++;
            }
        }
        if(count == 4)
        {
            return current;
        }
        else
            count = 0;
    }
    return NULL;
}