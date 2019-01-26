#include<stdio.h>
#include<stdbool.h>
#include<ctype.h>

// constants
FILE *FP;

typedef struct {
    char                word[32];
    int                 wordFreq;
    struct wordList     *nextWord;
    struct wordList     *prevWord;
} wordList;

char *getWord() {
    char c;
    char word[32];
    int len = 0;

    while ((c = getc(FP)) != EOF) {
        if (c == ' ' || c == '\n') {
            word[len++] = '\0';
            break;
        }
        word[len++] = c;
    }
    char *p = word;
    return p;
}

    // Read the file (1st pass) and create a linked list of words (in order) with freq set to 1
    // TODO: Loop through file
    // TODO: Test that each is an actual word
    // TODO: Put confirmed word in Linked List
void createBaseList() {
    char *tempWord;
    bool found;

    tempWord = getWord();
    printf("%s\n", tempWord);
    
}

void caclWordFreq() {
    // TODO: Read the file (2nd pass) and for each word identified, seach the linked list and increment matching word
}

void printList() {
    // TODO: Print out each word and frequency in order of appearance
}

void alphaSortandPrint() {
    // TODO: Sort the linked like alphabetically then invoke PrintList 
}

void freqSortandPrint() {
    // TODO: Sort the linked list in decreasing order of word frequency and invoke PrintList
}

int main(int argc, char* argv[]) {
    // Loop for all possible file inputs
    FP = fopen(argv[1], "r");
    createBaseList();
    return 0;
}