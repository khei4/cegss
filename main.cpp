// from alive2
#include "smt/smt.h"
#include "smt/solver.h"
#include <iostream>

// from liboai
#include "liboai.h"

// from llvm
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

using namespace llvm;

static bool optimize_function(llvm::Function &F, DominatorTree &DT,
                              TargetLibraryInfoWrapperPass &TLI) {
  return false;
}
namespace {
struct SuperoptimizerPass : PassInfoMixin<SuperoptimizerPass> {
  PreservedAnalyses run(llvm::Function &F, FunctionAnalysisManager &FAM) {
    // TargetLibraryInfo &TLI = FAM.getResult<TargetLibraryAnalysis>(F);
    PreservedAnalyses PA;
    PA.preserveSet<CFGAnalyses>();

    if (F.isDeclaration())
      return PA;

    DominatorTree &DT = FAM.getResult<DominatorTreeAnalysis>(F);

    TargetLibraryInfoWrapperPass TLI(Triple(F.getParent()->getTargetTriple()));
    optimize_function(F, DT, TLI);
    return PA;
  }
};

} // namespace
