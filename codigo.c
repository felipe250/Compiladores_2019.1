#include <stdio.h>
#include <stdlib.h>

void bubble_sort(int *, int);

int main(void){
	int vetor[10] = {1,10,2,3,7,8,9,4,5,6};
	bubble_sort(vetor, 10);
	return 0;
}

void bubble_sort (int *vetor, int n) {
    int k, j, aux;

    for (k = 1; k < n; k++) {
        printf("\n[%d] ", k);

        for (j = 0; j < n - 1; j++) {
            printf("%d, ", j);

            if (vetor[j] > vetor[j + 1]) {
                aux          = vetor[j];
                vetor[j]     = vetor[j + 1];
                vetor[j + 1] = aux;
            }
        }
    }
}