//===- Hello.cpp - Example code from "Writing an LLVM Pass" ---------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements two versions of the LLVM "Hello World" pass described
// in docs/WritingAnLLVMPass.html
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Dominators.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Scalar.h"
#include <map>
using namespace llvm;

#define DEBUG_TYPE "simple-licm"
  
STATISTIC(LoopCounter, "Counts number of loops greeted");

namespace {

    struct YourLICM : public LoopPass {
        static char ID; // Pass identification, replacement for typeid
        YourLICM() : LoopPass(ID) {}

        struct LoopNode {
            int num_bbs;
            int num_instrs;
            int num_atomics;
            int num_branches;
 
            LoopNode(){}
            LoopNode(int a = 0 , int b = 0 , int c = 0 , int d = 0) {
                num_bbs = a;
                num_instrs = b;
                num_atomics = c;
                num_branches = d;
            }
        };
        // std::map<Loop*, LoopNode> LoopData

        LoopNode processLoop(Loop* L) {
            unsigned int i = 0;
            int instrs = 0 , atomics = 0 , branches = 0;
            int BBs = L->getBlocks().size();

            std::vector< BasicBlock *> blocks = L->getBlocks();
            for( i = 0 ; i < blocks.size() ; i ++) {
                BasicBlock::InstListType& instlist = blocks[i]->getInstList();
                instrs += instlist.size();

                for( auto& I : instlist){
                    if(I.isAtomic())
                        atomics++;
                    if(isa<BranchInst> (I))
                        branches++;
                }
            }

            LoopNode tmp(BBs,instrs,atomics,branches);
            return tmp;
        }

        bool runOnLoop(Loop *L, LPPassManager &LPM) override {

            Loop *tmpLoop;
            unsigned int i = 0;
/*---------------------------Function------------------------------*/

            BasicBlock* funcblock = L->getHeader();
            Function* F = funcblock->getParent();

            // DominatorTree 
            DominatorTreeWrapperPass *DTWP = getAnalysisIfAvailable<DominatorTreeWrapperPass>();
            DominatorTree *DT = DTWP ? &DTWP->getDomTree() : nullptr;
            LoopInfoWrapperPass *LIWP = getAnalysisIfAvailable<LoopInfoWrapperPass>();
            LoopInfo *LI = LIWP ? &LIWP->getLoopInfo() : nullptr;
            errs() << "!!!!!!!!DT: " << DT->compare(*DT) << "\n"
                   << "!!!!!!!!LI: " << LI->empty() << "\n";

/*----------------------------DEPTH--------------------------------*/

            int depth = 0;
            for ( tmpLoop = L->getParentLoop() ; tmpLoop ; tmpLoop = tmpLoop->getParentLoop()) {
                depth ++;
            }

/*---------------BBs INSTRUCTIONS ATOMICS BRANCHES-----------------*/
            
            LoopNode loopdata = processLoop(L);
            std::vector<llvm::Loop*> subloops = L->getSubLoops();
            for ( i = 0 ; i < subloops.size() ; i ++) {
                LoopNode tmp = processLoop(subloops[i]);

                loopdata.num_bbs -= tmp.num_bbs;
                loopdata.num_branches -= tmp.num_branches;
            }

/*---------------------------OUTPUTS-------------------------------*/            
            errs() << LoopCounter++
                   << ": func=" << F->getName()
                   << ", depth=" << depth 
                   << ", subLoops=" << ((L->empty())?"false":"true") 
                   << ", BBs=" << loopdata.num_bbs  
                   << ", instrs=" << loopdata.num_instrs
                   << ", atomics=" << loopdata.num_atomics
                   << ", branches=" << loopdata.num_branches
                   << "\n" ;
            return false;
        }

        // void getAnalysisUsage(AnalysisUsage &AU) const override {
        virtual void getAnalysisUsage(AnalysisUsage &AU) const {
            AU.setPreservesCFG();
            AU.addRequiredID(LoopSimplifyID);
            AU.addRequired<LoopInfoWrapperPass>();
            AU.addRequired<DominatorTreeWrapperPass>();
        }
    };
}

char YourLICM::ID = 0;
static RegisterPass<YourLICM> X("simple-licm", "LICM implemented by F&M");
