#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>
#include<string.h>
#include<ctype.h>

struct wordList {
    char                *word;
    int                 wordFreq;
    struct wordList     *nextWord;
    struct wordList     *prevWord;
};
typedef struct wordList LIST;

// constants
LIST *HEAD;
LIST *TAIL;
FILE *FP;

char *getWord() {
    char c;
    int len = 0;
    char *word = (char *)malloc(sizeof(char));

    // Test for allocation
    if (word == NULL) {
        printf("Could not allocate memory.\n");
        exit(1);
    }

    // Check if end of file
    if ((c = getc(FP)) == EOF) {
        return NULL;
    }

    // Retrieve word from file
    while (isalpha(c) || isdigit(c) || c == 95 || c == 45) {

        // Test first letter
        if (len == 0 && !isalpha(c)) {
            break;
        }

        // Add character and increase buffer
        word[len] = tolower(c);
        len++;
        word = realloc(word, sizeof(char) + len);
        c = getc(FP);
    }

    word[len] = '\0';
    return word;
}

    // Read the file (1st pass) and create a linked list of words (in order) with freq set to 1
int createList() {
    LIST *listPtr;
    LIST *newElement;
    char *tempWord;
    bool found;

    // Add first word to the Linked List
    if (tempWord = getWord()) {
        newElement = (LIST *)malloc(sizeof(LIST));
        newElement->word = tempWord;
        newElement->wordFreq = 1;
        newElement->nextWord = NULL;
        newElement->prevWord = NULL;
        HEAD = newElement;
    }

    // Loop through the remainder of the file adding words
    while (tempWord = getWord()) {
        if (tempWord[0] != '\0') {
            //printf("%s\n", tempWord);
            listPtr = HEAD;
            found = false;
            if (listPtr->prevWord == NULL && strcmp(listPtr->word, tempWord) == 0) {
                found = true;
            }
            while (listPtr->nextWord != NULL && !found) {
                listPtr = listPtr->nextWord;
                if (strcmp(listPtr->word, tempWord) == 0) {
                    found = true;
                    break;
                }
            }

            // add to linked list
            if (!found) {
                newElement = (LIST *)malloc(sizeof(LIST));
                newElement->word = tempWord;
                newElement->wordFreq = 1;
                newElement->nextWord = NULL;
                newElement->prevWord = listPtr;
                listPtr->nextWord = newElement;
                TAIL = newElement;
            } else {
                listPtr->wordFreq++;
            }
        }
    }
    free(tempWord);
}

void printList() {
    LIST *ptr = HEAD;
    while (ptr != NULL) {
        printf("Word: %-40s Freq: %d\n", ptr->word, ptr->wordFreq);
        ptr = ptr->nextWord;
    }
}

void alphaSortandPrint() {
    // TODO: Sort the linked like alphabetically then invoke PrintList 
}

void freqSortandPrint() {
    // TODO: Sort the linked list in decreasing order of word frequency and invoke PrintList
}

void freeList() {
    LIST *temp;
    while(HEAD != NULL) {
        temp = HEAD;
        HEAD = HEAD->nextWord;
        free(temp);
    }
}

int main(int argc, char* argv[]) {
    // Loop for all possible file inputs
    FP = fopen(argv[1], "r");

    if (FP == NULL) {
        printf("Could not open file.\n");
        exit(0);
    }

    createList();
    printList();

    //alphaSortandPrint();
    //printList();

    freeList();
    fclose(FP);
    return 0;
}