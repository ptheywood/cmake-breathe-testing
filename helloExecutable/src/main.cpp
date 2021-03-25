#include <cstdlib>
#include "hello/Hello.hpp"

// Entry point
int main(int, char *[]){
    // Call the method
    hello::Hello::helloActions();
    // Return a value
    return EXIT_SUCCESS;
}
