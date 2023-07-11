#include "llvm_util/compare.h"
#include "llvm_util/llvm2alive.h"
#include "smt/smt.h"
#include "smt/solver.h"
#include <iostream>
#include <sstream>
#include <string>

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

bool compareFunctions(llvm::Function &Src, llvm::Function &Tgt,
                      TargetLibraryInfoWrapperPass &TLI) {
  std::optional<smt::smt_initializer> smt_init;
  smt_init.emplace();

  auto Func1 = llvm_util::llvm2alive(Src, TLI.getTLI(Src), true);
  auto Func2 = llvm_util::llvm2alive(Tgt, TLI.getTLI(Tgt), true);

  if (!Func1.has_value() || !Func2.has_value()) {
    return false;
  }
  return true;
}

bool verify(llvm::Function &Src, llvm::Function &Tgt,
            TargetLibraryInfoWrapperPass &TLI) {
  smt::smt_initializer smt_init;
  llvm_util::Verifier verifier(TLI, smt_init, std::cout);
  verifier.quiet = true;
  verifier.compareFunctions(Src, Tgt);
  dbgs() << "verified\n";
  return verifier.num_correct;
}

namespace {
struct SuperoptimizerPass : PassInfoMixin<SuperoptimizerPass> {
  PreservedAnalyses run(llvm::Function &F, FunctionAnalysisManager &FAM) {
    PreservedAnalyses PA;
    PA.preserveSet<CFGAnalyses>();
    TargetLibraryInfoWrapperPass TLI(Triple(F.getParent()->getTargetTriple()));
    LLVMContext &C = F.getContext();
    SMDiagnostic Err;
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
        std::cerr << ResGPT << "\n";
        // print the response
      } catch (std::exception &e) {
        errs() << e.what() << '\n';
        return PA;
      }
    } else {
      errs() << "failed to read oai key\n";
      return PA;
    }

    // 3. GPT response to IR by AsmParser
    std::unique_ptr<Module> M =
        parseAssemblyString(stripNonLLVMIR(ResGPT), Err, C);
    if (!M)
      Err.print("ParseFailed", errs());
    // M->dump();
    Function *Fnew = M->getFunction(F.getName().str());
    // 4. Verify by alive2
    dbgs() << "successfully called!\n";
    if (verify(F, *Fnew, TLI)) {
      dbgs() << "ok\n";
      Fnew->print(dbgs());
    } else {
      dbgs() << "not ok\n";
      Fnew->print(dbgs());
    }

    return PA;
  }

  static bool isRequired() { return true; }
};

} // namespace
void passBuilderCallback(PassBuilder &PB) {
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
  Res.PluginName = "CEGSSPass";
  Res.PluginVersion = LLVM_VERSION_STRING;
  Res.RegisterPassBuilderCallbacks = passBuilderCallback;

  return Res;
}

extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo llvmGetPassPluginInfo() {
  return getSuperoptimizerPassPluginInfo();
}