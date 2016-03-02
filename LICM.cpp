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
#include "llvm/Analysis/ValueTracking.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Scalar.h"
#include <map>
using namespace llvm;

#define DEBUG_TYPE "simple-licm"
  
// STATISTIC(LoopCounter, "Counts number of loops greeted");

namespace {

    struct YourLICM : public LoopPass {
        static char ID; // Pass identification, replacement for typeid
        YourLICM() : LoopPass(ID) {}

        bool isLoopInvariant(Instruction &I , Loop *L) {
            bool case1 = ( I.isBinaryOp() || I.isShift() ||
                           I.isCast() || I.getOpcode() == Instruction::Select ||
                           I.getOpcode() == Instruction::GetElementPtr );

            bool case2 = L->hasLoopInvariantOperands(&I);

            return case1 && case2;
        }

        bool safeToHoist(Instruction &I , Loop *L , DominatorTree *DT) {
            unsigned int i = 0;
            
            bool case1 = llvm::isSafeToSpeculativelyExecute(&I);
            if (case1)
                return true;

            bool case2 = true;
            SmallVector<BasicBlock*, 0> ExitBlocks;
            L->getExitBlocks(ExitBlocks);
            for ( i = 0 ; i < ExitBlocks.size() ; i ++) {
                if (! DT->dominates(&I, ExitBlocks[i])) {
                    case2 = false;
                    break;
                }
            }
            
            return case2; 
        }

        void get_preorder(Loop* L, DominatorTree *DT,DomTreeNodeBase< BasicBlock > * parent)
        {
            // errs()<<"new block\n";
            BasicBlock* parent_BB = parent->getBlock();
            BasicBlock* header = L->getHeader();
            Instruction &first_parent = parent_BB->front();
            Instruction &first_header = header->front();
            
            if(DT->dominates(header, parent_BB)) 
            {
                bool inSubLoop = false, outofLoop = true;
                for(auto subLoop : L->getSubLoops())
                {
                    for(auto BB : subLoop->getBlocks())
                    {
                        if(parent_BB == BB)
                        {
                            inSubLoop = true;
                            break;
                        }
                    }
                }
                for(auto BB : L->getBlocks())
                {
                    if(BB == parent_BB)
                        outofLoop = false;
                }
                bool immediateBB = !(inSubLoop || outofLoop);
                if(immediateBB){
                    auto I = parent_BB->getInstList().begin();

                    Instruction* pI;
                    while(I != parent_BB->getInstList().end()){
                        pI = &*(I++);
                        // pI->print(errs());
                        // errs()<<'\n';
                        // if(I != parent_BB->getInstList().end())
                        //     I->print(errs());
                        //errs()<<'\n';
                        if(isLoopInvariant(*pI, L) && safeToHoist(*pI, L, DT))  
                        {
                            BasicBlock* PreHeader = L->getLoopPreheader();
                            pI->moveBefore(PreHeader->getTerminator());
                        }
                    }
                }
            }


            for(auto child : parent->getChildren())
                get_preorder(L,  DT , child );
        }

        bool runOnLoop(Loop *L, LPPassManager &LPM) override {

            // DominatorTree 
            DominatorTreeWrapperPass *DTWP = getAnalysisIfAvailable<DominatorTreeWrapperPass>();
            DominatorTree *DT = DTWP ? &DTWP->getDomTree() : nullptr;
            DomTreeNodeBase<BasicBlock> *root = DT->getRootNode();

            get_preorder(L,  DT , root );
        
            return true;

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
