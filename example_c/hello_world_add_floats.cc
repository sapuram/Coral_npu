#include <string.h>



// 1. Declare Global Variables in the .data section

float input1[8] __attribute__((section(".data")));

float input2[8] __attribute__((section(".data")));

float output[8] __attribute__((section(".data")));



// 2. Main Entry Point

int main() {

  for (int i = 0; i < 8; i++) {

    output[i] = input1[i] + input2[i];

  }

  return 0;

}
