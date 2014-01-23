#include <stdio.h>
#include <stdlib.h>
#include <math.h>
 
#define MAXCHAR 1000

typedef unsigned short int Boolean;

#define TRUE 1
#define FALSE 0

int get_length(char* filname); // to compute the size of file

int main(int argc, char *argv[]) {
	FILE *fp;
	char str[MAXCHAR];
	char* filename = argv[1];
	float size = (float) get_length(filename);
	fp = fopen(filename, "r");
	float middle = size/2;
	int count = 1;
	float m = 0;
	float std = 0;
	float med = 0;
	int p_value = 0;
	int sum = 0;

	Boolean first = TRUE;

	if (fp == NULL) {
		printf("Could not open file %s",filename);
		return 1;
	}
	// loop over each line of the file
	while (fgets(str, MAXCHAR, fp) != NULL) {
		// printf("%s", str);
		// compute Mean and SD
		int value = atoi(str);
		sum += value;
		if (first == TRUE) {
			m = value;
			first = FALSE;
		}
		else {
			float u_m = m + ((float) value-m)/((float) count);
			std = std + (value-m)*(value-u_m);
			m = u_m;
		}
		// compute Median
		if (count-1 < middle && middle < count)
			med = value;	
		else if (count == middle)
			p_value = value;
		else if (count == middle+1)
			med = (p_value+value)/2;
		count++;
	}
	printf("Mean: %f\n", (float)sum/(float)size);
	printf("SD: %f\n", sqrt(std/(size-1)));
	printf("Median: %f\n", med);
	fclose(fp);
	return 0;
}

int get_length(char* filename) {
	FILE *fp;
        char str[MAXCHAR];
	int count = 0;
	fp = fopen(filename, "r");
	
	if (fp == NULL) {
                printf("Could not open file %s",filename);
                return 1;
        }
        while (fgets(str, MAXCHAR, fp) != NULL) {
                count++;
        }
	fclose(fp);
	return count;
}
