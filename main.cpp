// from alive2
#include "smt/smt.h"
#include "smt/solver.h"
#include <iostream>

// from liboai
#include "liboai.h"

// from llvm
#include "llvm/ADT/Triple.h"

int main() {
  liboai::OpenAI oai;
  smt::solver_print_stats(std::cerr);
}