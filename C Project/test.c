#include <stdio.h>

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
	int lines[10], words[10], chars[10];
	int i, tot_lines=0, tot_words=0, tot_chars=0;

	/* Need error checks here */
	for (i = 0; i < (argc - 1); i++)
	{
		lines[i] = count_lines(argv[i + 1]);
		words[i] = count_words(argv[i + 1]);
		chars[i] = count_chars(argv[i + 1]);
	}

	for (i=0; i<(argc-1); i++)
	{
		tot_lines += lines[i];
		tot_words += words[i];
		tot_chars += chars[i];
	}

	printf(" **********The Results ****************\n");

	/* Both Individual and Total results */
	for (i=0; i<(argc-1); i++)
	{
		printf("%10d%10d%10d%20s\n",
		lines[i], words[i], chars[i], argv[i+1]);
	}

	printf("Totals for the Input are:\n");
	printf("Lines: %10d\nWords: %10d\nChars: %10d\n", tot_lines, tot_words, tot_chars);
}
