#include <iostream>
#include <cuda_runtime.h> 
using namespace std;

// Derived class
class Rectangle
{
    public:
        //don't use constructor
        Rectangle()
        {
            // width = (int *)malloc(sizeof(int));
            // height = (int *)malloc(sizeof(int));  
            // *width = 10;
            // *height = 30;
        }
        void build_function()
        {
            cudaMallocManaged(&width,sizeof(int));
            cudaMallocManaged(&height,sizeof(int));
            *width = 10;
            *height = 30;
        }
        __device__ __host__ void getArea()
        { 
            product = *width * *height; 
        }
        int product;
    private:
        int* width;
        int* height;
};

// Base class
class Shape 
{
    public:
        //don't use constructor
        Shape()
        {
            // rect = new Rectangle();
        }

        void build_function()
        {
            cudaMallocManaged(&rect,sizeof(Rectangle));
            rect->build_function();   
        }
        Rectangle* rect;
};

__global__ void kernel(Shape* sha)
{
    sha->rect->getArea(); 
}

int main(void)
{
    //    Shape* sha = new Shape();
    Shape* sha;
    cudaMallocManaged(&sha,sizeof(Shape));
    sha->build_function();

    kernel<<<1,1,0>>>(sha);
    cudaDeviceSynchronize(); 
    cout << "Total area: " << sha->rect->product << endl;
    return 0;
}
