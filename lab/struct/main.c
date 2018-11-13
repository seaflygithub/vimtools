#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "main.h"
int main(int argc, char *argv[])
{
    data_t data = {0};
    data_t *pdata = NULL;
    pdata = malloc(sizeof(data_t));


    free(pdata);
    pdata = NULL;
    return 0;
}
