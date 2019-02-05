#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>

/* Program excepts files passed as command line arguments */

// Linked List structure
struct wordList
{
    char *word;
    int wordFreq;
    struct wordList *nextWord;
    struct wordList *prevWord;
};
typedef struct wordList LIST;

// constants
LIST *HEAD;
FILE *FP;

// Pulls a word out of the file and tests it as described in the assignment guidelines
char *getWord()
{
    char c;
    int len = 0;
    char *word = (char *)malloc(sizeof(char));
    bool isWord = true;

    // Test for allocation
    if (word == NULL)
    {
        printf("Could not allocate memory.\n");
        exit(1);
    }

    // Check if end of file
    if ((c = getc(FP)) == EOF)
    {
        return NULL;
    }

    // Retrieve word from file
    while (isalpha(c) || isdigit(c) || c == 95 || c == 45)
    {

        // Test first letter
        if (len == 0 && !isalpha(c))
        {
            isWord = false;
        }

        // Add character and increase buffer
        word[len] = c;
        len++;
        word = realloc(word, sizeof(char) * (len + 1));
        c = getc(FP);
    }

    word[len] = '\0';
    if (!isWord)
    {
        return "\0";
    }
    return word;
}

// Adds the words to the List and increments frequency
void createList()
{
    LIST *listPtr;
    LIST *newElement;
    char *tempWord;
    bool found;

    // Add first word to the Linked List
    if ((tempWord = getWord()))
    {
        newElement = (LIST *)malloc(sizeof(LIST));
        newElement->word = tempWord;
        newElement->wordFreq = 1;
        newElement->nextWord = NULL;
        newElement->prevWord = NULL;
        HEAD = newElement;
    }

    // Loop through the remainder of the file adding words
    while ((tempWord = getWord()))
    {
        // Test for empty strings
        if (tempWord[0] != '\0')
        {
            listPtr = HEAD;
            found = false;
            if (listPtr->prevWord == NULL && strcmp(listPtr->word, tempWord) == 0)
            {
                found = true;
            }

            // Loops through list check if current word is present
            while (listPtr->nextWord != NULL && !found)
            {
                listPtr = listPtr->nextWord;
                if (strcmp(listPtr->word, tempWord) == 0)
                {
                    found = true;
                    break;
                }
            }

            // If found increment frequency else add to List
            if (found)
            {
                listPtr->wordFreq++;
            }
            else
            {
                newElement = (LIST *)malloc(sizeof(LIST));
                newElement->word = tempWord;
                newElement->wordFreq = 1;
                newElement->nextWord = NULL;
                newElement->prevWord = listPtr;
                listPtr->nextWord = newElement;
            }
        }
    }
}

// Loop through List printing each word/frequency
void printList()
{
    LIST *ptr = HEAD;
    while (ptr != NULL)
    {
        printf("Word: %-40s Freq: %d\n", ptr->word, ptr->wordFreq);
        ptr = ptr->nextWord;
    }
}

// Free allocated memory from List
void freeList()
{
    LIST *temp;
    while (HEAD != NULL)
    {
        temp = HEAD;
        HEAD = HEAD->nextWord;
        free(temp->word);
        free(temp);
    }
}

int main(int argc, char *argv[])
{
    // Loop for all file inputs passed on command line
    for (int i = 1; i < argc; i++)
    {
        FP = fopen(argv[i], "r");

        if (FP == NULL)
        {
            printf("Could not open file.\n");
            exit(0);
        }

        createList();
        printList();

        freeList();
        fclose(FP);
    }
    
    return 0;
}