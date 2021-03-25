#include "hello/Hello.hpp"

#include <iostream>

namespace hello {
    const std::string helloMessage = "helloActions";

unsigned int Hello::helloLength() {
    return hello::helloMessage.length();
}

std::string Hello::getHello()  {
    return hello::helloMessage;
}

void Hello::helloActions() {
    std::cout << getHello() << std::endl;
}

}  // namespace hello
