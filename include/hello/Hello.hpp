#pragma once

#include <string>

// Simple header file, with the hello namespace

namespace hello {

class Hello {
 public:
/**
  *Return the length of the hello message - a testable function.
 * @return length of the message to be output.
 */
static unsigned int helloLength();

/**
 * Get the hello messsage as a string.
 * @return string containing the hello message.
 */

static std::string getHello();

/**
 * Print helloActions to stdout
 */
static void helloActions();
};

}  // namespace hello
