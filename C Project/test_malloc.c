#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, char *argv[])
{
    FILE *fp;
    char c;
    int len = 0;

    // allocate a char array pointer
    char *input = (char *)malloc(sizeof(char));

    fp = fopen(argv[1], "r");

    if (input == NULL)
    {
        printf("Could not allocate memory.\n");
        exit(1);
    }

    while ((c = getc(fp)) != EOF)
    {
        if (c == ' ' || c == '\n')
        {
            input[len] = '\0';
            break;
        }

        input = realloc(input, sizeof(char));
        input[len++] = c;
    }

    // Check word
    for (int i = 0; i < len; i++)
    {
        if (i == 0 && !isalpha(input[i]))
        {
            printf("Not a word\n");
            // return
        }
        else
        {
            if (isalpha(input[i]) || isdigit(input[i]) || input[i] == 95 || input[i] == 45)
            {
                printf("%s\n", input);
            }
            else
            {
                printf("Not a word\n");
            }
        }
    }

    free()
    return 0;
}