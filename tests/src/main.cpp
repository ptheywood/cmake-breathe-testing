#include <cstdlib>
#include <iostream>

#include "hello/Hello.hpp"

bool test_helloLength() {
    unsigned int helloLength = hello::Hello::helloLength();
    return helloLength == 11;
}

// Entry point
int main(int, char *[]) {
    unsigned int pass_count = 0;
    unsigned int fail_count = 0;

    if (test_helloLength()) {
        pass_count++;
    } else {
        fail_count++;
    }

    unsigned int total_count = pass_count + fail_count;

    if (fail_count == 0) {
        std::cout << "Success: " << pass_count << "/" << total_count << "tests passed" << std::endl;
        return EXIT_SUCCESS;
    } else {
        std::cout << "Failure:  " << fail_count << "/" << total_count << "tests failed" << std::endl;
        return EXIT_FAILURE;
    }
}
