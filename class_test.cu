#include <iostream>
 
using namespace std;

// Derived class
class Rectangle
{
   public:
      Rectangle()
      {
        width = (int *)malloc(sizeof(int));
        height = (int *)malloc(sizeof(int));
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
        rect = new Rectangle();
        *(rect->width) = 20;
        *(rect->height) = 10;
    }
    Rectangle* rect;
};


int main(void)
{
    Shape* sha = new Shape(); 

   // Print the area of the object.
   cout << "Total area: " << sha->rect->getArea() << endl;

   return 0;
}
