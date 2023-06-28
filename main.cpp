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
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

static bool optimize_function(llvm::Function &F, DominatorTree &DT,
                              TargetLibraryInfoWrapperPass &TLI) {
  // TODO: implement simplified form
  // 1. Dump Function IR print or dump
  // 2. Throw IR to GPT liboai
  // 3. GPT response to IR by AsmParser
  // 4. Verify alive2
  return false;
}
namespace {
struct SuperoptimizerPass : PassInfoMixin<SuperoptimizerPass> {
  PreservedAnalyses run(llvm::Function &F, FunctionAnalysisManager &FAM) {
    PreservedAnalyses PA;
    PA.preserveSet<CFGAnalyses>();

    if (F.isDeclaration())
      return PA;

    DominatorTree &DT = FAM.getResult<DominatorTreeAnalysis>(F);

    TargetLibraryInfoWrapperPass TLI(Triple(F.getParent()->getTargetTriple()));
    optimize_function(F, DT, TLI);
    return PA;
  }

  // TODO: find whether this is necessary.
  // Without isRequired returning true, this pass will be skipped for functions
  // decorated with the optnone LLVM attribute. Note that clang -O0 decorates
  // all functions with optnone.
  static bool isRequired() { return true; }
};

} // namespace

void passBuilderCallback(PassBuilder &PB) {
  // form minotaur
  // https://github.com/minotaur-toolkit/minotaur/blob/aa06f51f9b2ce601e8332b449a33b29db7ce01a2/pass/online.cpp#L276-L282
  // PB.registerPipelineParsingCallback(pipelineParsingCallback);
  // PB.registerVectorCombineCallback(
  //     [](llvm::FunctionPassManager &FPM, llvm::OptimizationLevel) {
  //       FPM.addPass(SuperoptimizerPass());
  //     });

  // from llvm-tutor
  // https://github.com/khei4/llvm-tutor/blob/b8f50cf7e885b68b1e1fe33931df9e95acfdab79/HelloWorld/HelloWorld.cpp#L73-L86
  // FIXME: find the place to call, consider PeepholeEPCallback or
  // registerOptimizerLastEPCallback
  PB.registerPipelineParsingCallback(
      [](StringRef Name, FunctionPassManager &FPM,
         ArrayRef<PassBuilder::PipelineElement>) {
        FPM.addPass(SuperoptimizerPass());
        return true;
      });
}

PassPluginLibraryInfo getSuperoptimizerPassPluginInfo() {
  llvm::PassPluginLibraryInfo Res;

  Res.APIVersion = LLVM_PLUGIN_API_VERSION;
  Res.PluginName = "SuperoptimizerPass";
  Res.PluginVersion = LLVM_VERSION_STRING;
  Res.RegisterPassBuilderCallbacks = passBuilderCallback;

  return Res;
}

extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo llvmGetPassPluginInfo() {
  return getSuperoptimizerPassPluginInfo();
}