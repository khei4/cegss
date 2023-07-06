// from alive2
#include "smt/smt.h"
#include "smt/solver.h"
#include <sstream>
#include <string>
// from liboai
#include "liboai.h"

// from llvm
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/AsmParser/Parser.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

// TODO: create lib to use liboai, interface from LLVM Function.
std::string stripNonLLVMIR(std::string_view llvmCode) {
  std::istringstream iss{std::string(llvmCode)};
  std::ostringstream oss;
  std::string line;
  bool insideLLVMIR = false;

  while (std::getline(iss, line)) {
    if (line.find("define") != std::string::npos)
      insideLLVMIR = true;

    if (insideLLVMIR)
      oss << line << '\n';

    if (line.find('}') != std::string::npos)
      insideLLVMIR = false;
  }

  return oss.str();
}

static bool optimize_function(llvm::Function &F, DominatorTree &DT,
                              TargetLibraryInfoWrapperPass &TLI) {
  // TODO: Cut OAI library calls into library
  // 1. Dump Function IR print or dump to string
  std::string functionString;
  llvm::raw_string_ostream rso(functionString);
  F.print(rso);
  rso.flush();
  // dbgs() << functionString << '\n';
  // 2. Throw IR to GPT liboai
  liboai::OpenAI OAI;
  liboai::Conversation Convo;
  std::string ResGPT;
  Convo.AddUserData("please optimize and/or vectorize following LLVM IR. "
                    "PLEASE NEVER say anythings except optimized LLVM IR"
                    "and NEVER change function name" +
                    functionString);
  if (OAI.auth.SetKeyEnv("OPENAI_API_KEY")) {
    try {
      liboai::Response response =
          OAI.ChatCompletion->create("gpt-3.5-turbo", Convo);

      // update our conversation with the response
      Convo.Update(response);

      ResGPT = Convo.GetLastResponse();
      // print the response
      // dbgs() << "GPT returned: " << '\n';
      // dbgs() << ResGPT << '\n';
      // dbgs() << "fin" << '\n';
    } catch (std::exception &e) {
      errs() << e.what() << '\n';
      return false;
    }
  } else {
    errs() << "failed to read oai key\n";
    return false;
  }

  // 3. GPT response to IR by AsmParser
  LLVMContext &C = F.getContext();
  SMDiagnostic Err;
  std::unique_ptr<Module> M =
      parseAssemblyString(stripNonLLVMIR(ResGPT), Err, C);
  if (!M)
    Err.print("ParseFailed", errs());
  // M->dump();
  Function *Fnew = M->getFunction(F.getName().str());
  // 4. Verify by alive2
  // 5. replace F with Fnew
  // FIXME: this doesn't work for top level function
  F.replaceAllUsesWith(Fnew);
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