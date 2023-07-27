#include "llvm_util/compare.h"
#include "llvm_util/llvm2alive.h"
#include "smt/smt.h"
#include "smt/solver.h"
#include <cassert>
#include <iostream>
#include <ostream>
#include <sstream>
#include <string>

#include "liboai.h"

// from llvm
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/AsmParser/Parser.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Transforms/Utils/ValueMapper.h"

// FIXME: These can't be passed by CLI
llvm::cl::opt<unsigned>
    Alive2TimeOut("alive-timeout",
                  llvm::cl::desc("cegss: timeout for alive2 queries"),
                  llvm::cl::init(50), llvm::cl::value_desc("s"));

llvm::cl::opt<bool> DA("disable-alive",
                       llvm::cl::desc("cegss: disable alive2 verification"),
                       llvm::cl::init(true), llvm::cl::value_desc("s"));

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

// FIXME: removing this unused function causes
// `Failed to load passes from '/home/khei4/git/cegss/build/libcegss.so'.
// Request ignored. Expected<T> must be checked before access or destruction.
// Unchecked Expected<T> contained error:
// Could not load library '/home/khei4/git/cegss/build/libcegss.so':
// /home/khei4/git/cegss/build/libcegss.so: undefined symbol:
// _ZTIN2IR13AggregateTypeEPLEASE submit a bug report to
// https://github.com/llvm/llvm-project/issues/ and include the crash backtrace.
// Stack dump:
//  #0 0x00007f2dc6fdb4d0 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int)
//  (/home/khei4/git/llvm-project/buildcegss/bin/../lib/libLLVMSupport.so.17git+0x27d4d0)
//  #1 0x00007f2dc6fd8584 SignalHandler(int) Signals.cpp:0:0
//  #2 0x00007f2dc6914520 (/lib/x86_64-linux-gnu/libc.so.6+0x42520)
//  #3 0x00007f2dc6968a7c __pthread_kill_implementation
//  ./nptl/pthread_kill.c:44:76 #4 0x00007f2dc6968a7c __pthread_kill_internal
//  ./nptl/pthread_kill.c:78:10 #5 0x00007f2dc6968a7c pthread_kill
//  ./nptl/pthread_kill.c:89:10 #6 0x00007f2dc6914476 gsignal
//  ./signal/../sysdeps/posix/raise.c:27:6 #7 0x00007f2dc68fa7f3 abort
//  ./stdlib/abort.c:81:7 #8 0x000055ec5775d4ce
//  llvm::Expected<llvm::PassPlugin>::fatalUncheckedExpected() const opt.cpp:0:0
//  #9 0x000055ec5775d71e std::_Function_handler<void
//  (std::__cxx11::basic_string<char, std::char_traits<char>,
//  std::allocator<char>> const&),
//  main::'lambda'(std::__cxx11::basic_string<char, std::char_traits<char>,
//  std::allocator<char>> const&)>::_M_invoke(std::_Any_data const&,
//  std::__cxx11::basic_string<char, std::char_traits<char>,
//  std::allocator<char>> const&) opt.cpp:0:0
// #10 0x000055ec5775f0f5 llvm::cl::list<std::__cxx11::basic_string<char,
// std::char_traits<char>, std::allocator<char>>, bool,
// llvm::cl::parser<std::__cxx11::basic_string<char, std::char_traits<char>,
// std::allocator<char>>>>::handleOccurrence(unsigned int, llvm::StringRef,
// llvm::StringRef) opt.cpp:0:0 #11 0x00007f2dc6ecd71d
// llvm::cl::ParseCommandLineOptions(int, char const* const*, llvm::StringRef,
// llvm::raw_ostream*, char const*, bool)
// (/home/khei4/git/llvm-project/buildcegss/bin/../lib/libLLVMSupport.so.17git+0x16f71d)
bool compareFunctions(llvm::Function &Src, llvm::Function &Tgt,
                      TargetLibraryInfoWrapperPass &TLI) {
  // std::optional<smt::smt_initializer> smt_init;
  // smt_init.emplace();
  // TODO: use of these calls is the key? -> are these inlined?
  // auto Hoge = TLI.getTLI(Src);
  auto Func1 = llvm_util::llvm2alive(Src, TLI.getTLI(Src), true);
  // auto Func2 = llvm_util::llvm2alive(Tgt, TLI.getTLI(Tgt), true);

  // if (!Func1.has_value() || !Func2.has_value()) {
  //   return false;
  // }
  // return true;
}

bool verify(llvm::Function &Src, llvm::Function &Tgt, std::ostream &msg,
            TargetLibraryInfoWrapperPass &TLI) {
  smt::smt_initializer smt_init;
  llvm_util::Verifier verifier(TLI, smt_init, msg);
  verifier.quiet = true;
  verifier.compareFunctions(Src, Tgt);
  return verifier.num_correct;
}

void replaceFunctionBody(Function *F, Function *F1) {
  assert(F->arg_size() != F1->arg_size() && "Arg Num should match");

  // Create a mapping from the arguments of F1 to the arguments of F.
  llvm::ValueToValueMapTy VMap;
  for (auto i = F->arg_begin(), j = F1->arg_begin(); i != F->arg_end();
       ++i, ++j)
    VMap[&*j] = &*i;

  // TODO: these returns API function are to be removed?
  llvm::SmallVector<llvm::ReturnInst *, 8> Returns;
  CloneAndPruneFunctionInto(F, F1, VMap, F1->getSubprogram() != nullptr,
                            Returns);
  // At this point, F has the body of F1. If you want to remove the old body of
  // F, you can erase the original basic blocks:
  for (auto it = F->begin(), ite = F->end(); it != ite;) {
    llvm::BasicBlock &BB = *it;
    ++it;
    if (std::find(Returns.begin(), Returns.end(), BB.getTerminator()) ==
        Returns.end())
      BB.eraseFromParent();
  }
}

namespace {
struct SuperoptimizerPass : PassInfoMixin<SuperoptimizerPass> {
  PreservedAnalyses run(llvm::Function &F, FunctionAnalysisManager &FAM) {
    smt::set_query_timeout(std::to_string(Alive2TimeOut * 1000));
    PreservedAnalyses PA;
    PA.preserveSet<CFGAnalyses>();
    TargetLibraryInfoWrapperPass TLI(Triple(F.getParent()->getTargetTriple()));
    LLVMContext &C = F.getContext();
    SMDiagnostic Err;
    // Dump Function into string
    std::string FString;
    raw_string_ostream rso(FString);
    F.print(rso);
    rso.flush();
    liboai::OpenAI OAI;
    if (!OAI.auth.SetKeyEnv("OPENAI_API_KEY")) {
      errs() << "failed to read oai key\n";
      return PA;
    }
    liboai::Conversation Convo;
    std::string ResGPT, FeedBack;
    std::unique_ptr<Module> M = nullptr;
    Function *Fnew = nullptr;
    int cnt = 0;
    bool Ok = false;

    do {
      do {
        if (cnt++)
          dbgs() << "retry " << cnt << "times\n";
        // 2. Throw IR to GPT liboai
        // TODO:
        // ask the reason, what is done, if something is there, more optimized
        // 最適化の根拠を聞く、何をしたか、入力になにか制約があればもっとできたはずか？みたいなのをpromptにいれる
        // TODO: load from something
        std::string prompt =
            "please optimize and/or vectorize following LLVM IR. "
            "PLEASE NEVER say anythings except optimized LLVM IR "
            "and NEVER change function name.\n\n" +
            FString;
        if (!FeedBack.empty())
          prompt += "previous output is rejected by: " + FeedBack;

        dbgs() << "===============GPT request prompt ====================\n";
        dbgs() << prompt << '\n';
        dbgs() << "======================================================\n";
        // clear data if the context is over 5000
        Convo.AddUserData(prompt);
        try {
          liboai::Response response =
              OAI.ChatCompletion->create("gpt-4", Convo);
          Convo.Update(response);
          ResGPT = Convo.GetLastResponse();
        } catch (std::exception &e) {
          errs() << "===============GPT request failure for================\n";
          errs() << e.what() << '\n';
          errs() << "======================================================\n";
          return PA;
        }
        // 3. GPT response to IR by AsmParser
        errs() << "===============GPT raw response================\n";
        errs() << ResGPT << '\n';
        errs() << "======================================================\n";
        M = parseAssemblyString(stripNonLLVMIR(ResGPT), Err, C);
        FeedBack = Err.getMessage().str();
      } while (!M);
      Fnew = M->getFunction(F.getName().str());
      dbgs() << "================Valid Module emitted ==================\n";
      Fnew->print(dbgs());
      dbgs() << "=======================================================\n";
      if (DA) {
        dbgs() << "Verification diabled\n";
        break;
      }
      // 4. Verify by alive2
      std::ostringstream MsgS;

      Ok = verify(F, *Fnew, MsgS, TLI);
      if (Ok) {
        dbgs() << "correctly verified \n";
        Fnew->print(dbgs());
      } else {
        dbgs() << "================Verification failure==================\n";
        dbgs() << MsgS.str() << "\n";
        dbgs() << "=======================================================\n";
        FeedBack = "verification: " + MsgS.str();
      }
    } while (!Ok);

    // 5. replace function body
    replaceFunctionBody(&F, Fnew);

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