#include <iostream>
#include <cuda_runtime.h> 
using namespace std;

// Derived class
class Rectangle
{
   public:
      Rectangle()
      {
	cudaMallocManaged(&width, sizeof(int));
	cudaMallocManaged(&height, sizeof(int));
        //width = (int *)malloc(sizeof(int));
        //height = (int *)malloc(sizeof(int));
      }
      int getArea()
      { 
         return (*width * *height); 
      }
      int* width;
      int* height;
};

// Base class
class Shape 
{
   public:
    Shape()
    {
 	cudaMallocManaged(&rect, sizeof(Rectangle));	
        *(rect->width) = 20;
        *(rect->height) = 10;
    }
    Rectangle* rect;
};

__global__ void change_width(Shape* sha)
{
	*(sha->rect->width) = 10;
	return;
}

int main(void)
{
   Shape* sha;
   cudaMallocManaged(&sha,sizeof(Shape));
   //Shape* sha = new Shape(); 
   change_width<<<1,1,0>>>(sha);
   cudaDeviceSynchronize(); 
   // Print the area of the object.
   cout << "Total area: " << sha->rect->getArea() << endl;

   return 0;
}
