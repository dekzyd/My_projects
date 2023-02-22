#include "my_ngram.h"

/**
 * sort - sort string in ascending order
 * @string: string to be sorted
 * Return: string
 */
char *sort(char *string)
{
    int a, b, len;
    char ptr;
    char tmp = '"';
    len = strlen(string);
    for (a = 0; a < len; a++)
    {
        for (b = 0; b < len - 1; b++)
        {
            if (string[b] == tmp)
                break;
            if (string[b] > string[b + 1])
            {
                 ptr = string[b];
                 string[b] = string[b + 1];
                 string[b + 1] = ptr;
            }
         }
     }
    return (string);
}

/**
 * main - checks all characters passed into a string and returns the number of times they occur in ascending order
 * @argc: argument count
 * @argv: argument vector
 * Return: 0 success
 */
 int main(int argc, char **argv)
{
    int x, y, m, n, val, length1, length2;
    int count, i, j, k;
    int savelen, s;
    char *string, *save, *no_dup, ch, *ptr_save, *ptr_no_dup;
    //printf("%s\n", argv[1]);
    save = malloc(1024);
    count = 0;
    /* looping through argv */
    for (x = 1; x < argc; x++)
    {
        /* assing string to var*/
        string = argv[x];
        /*looping through all string in argv and save string*/
        for (y = 0; string[y] != '\0'; y++)
        {
            save[count] = string[y];
            count++;
        }
        savelen = strlen(save);
    }
    /* keeping original strings */
    no_dup = malloc(1024);
    for (s = 0; s < savelen; s++)
    {
        no_dup[s] = save[s];
    }
    /* remove duplicated string */
    for (i = 0; i < savelen; i++)
    {
        for (j = i + 1; j < savelen;)
        {
            if (save[i] == save[j])
            {
                for (k = j; k < savelen; k++)
                {
                    save[k] = save[k + 1];
                }
                savelen--;
            }
            else
            {
                j++;
            }
        }
    }
    /* counting occurance of string for below function*/
    length1 = strlen(no_dup);
    length2 = strlen(save);
    ptr_save = malloc(1024);
    ptr_no_dup = malloc(1024);
    ptr_save = sort(save);
    ptr_no_dup = sort(no_dup);
    for (m = 0; m < length2; m++)
    {
        val = 0;
        ch = ptr_save[m];
        for (n = 0; n < length1; n++)
        {
            if (ptr_no_dup[n] == ch)
            {
                val++;
            }
        }
         printf("%c:%d\n", ch, val);
    }
    free(save);
    free(ptr_save);
    free(no_dup);
    free(ptr_no_dup);
    }