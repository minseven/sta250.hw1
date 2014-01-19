#include <stdio.h>
#include <stdlib.h>
 
#define MAXCHAR 1000

typedef unsigned short int Boolean;

#define TRUE 1
#define FALSE 0

int main(int argc, char *argv[]) {
	FILE *fp;
	char str[MAXCHAR];
	char* filename = argv[1];
	fp = fopen(filename, "r");
	float size = atof(argv[2]);
	float middle = size/2;
	int count = 1;
	float mean = 0;
	float std = 0;
	float med = 0;
	float p_value = 0;

	Boolean first = TRUE;

	if (fp == NULL) {
		printf("Could not open file %s",filename);
		return 1;
	}
	while (fgets(str, MAXCHAR, fp) != NULL) {
		printf("%s", str);
		// Mean and SD
		float value = atof(str);
		if (first == TRUE) {
			mean = value;
			first = FALSE;
		}
		else {
			float u_mean = mean + (value-mean)/(size+1);
			std = std + (value-mean)*(value-u_mean);
			mean = u_mean;
		}
		// Median
		if (count-1 < middle && middle < count)
			med = value;	
		else if (count == middle)
			p_value = value;
		else if (count == middle+1)
			med = (p_value+value)/2;
		count++;
	}
	printf("Mean: %f\n", mean);
	printf("SD: %f\n", std);
	printf("Median: %f\n", med);
	fclose(fp);
	return 0;
}
