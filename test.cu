#include <stdio.h>
__global__ void printValue( int *value) {
printf("value %d",value[0]);
}
 
void hostFunction(){
int *value;
//cudaMallocManaged(&value, 2 * sizeof(int));
value = (int *)malloc(sizeof(int)*2);
value[0]=1;
value[1]=2;
//printValue<<< 1, 1 >>>(value);
//cudaDeviceSynchronize();
cudaFree(value);
}
 
int main() {
hostFunction();
return 0;
}
