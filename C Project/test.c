#include <stdio.h>
#include<string.h>

int count_lines(char* f_name)
{
	FILE *fp;
	char c;
	int  num_lines=0;
	fp = fopen(f_name, "r");
	while ((c=getc(fp)) != EOF)
	{
		while (c != '\n')
		c = getc(fp);
		num_lines++;
	}
	fclose(fp);
	return(num_lines);
}

int count_chars(char* f_name)
{
/* You need to supply the appropriate code */
}

int count_words(char* f_name)
{
/* You need to supply the appropriate code */
}

int main(int argc, char* argv[])
{
	char *array = malloc(sizeof(char));
	char str1 = "hello";
	char str2 = "corld";

	int length = strlen(str1);
	array = realloc(array, sizeof(char) + length);
	array[0] = str1;
}
