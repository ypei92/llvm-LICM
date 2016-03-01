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

        bool isLoopInvariant(Instruction &I , Loop *L) {

            errs() << " isloopinvariant:";
            I.print(errs());
            errs()<<"\n";
            bool case1 = ( I.isBinaryOp() || I.isShift() ||
                           I.isCast() || I.getOpcode() == Instruction::Select ||
                           I.getOpcode() == Instruction::GetElementPtr );

            bool case2 = L->hasLoopInvariantOperands(&I);

            return case1 && case2;
        }

        bool safeToHoist(Instruction &I , Loop *L , DominatorTree *DT) {
            unsigned int i = 0;
            
            errs() << " safetohoist:" ;
            I.print(errs());
            errs()<<"\n";
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
            // DomTreeNodeBase< BasicBlock > * root = DT->getRootNode();
            // BasicBlock* root_BB = root->getBlock();
            errs()<<"new block\n";
            BasicBlock* parent_BB = parent->getBlock();
            BasicBlock* header = L->getHeader();
            //errs()<< (header == parent_BB) << (header == header)<<'\n'; 
            Instruction &first_parent = parent_BB->front();
            Instruction &first_header = header->front();
            //first_parent.print(errs());
            //errs()<<'\n';
            //first_header.print(errs());
            //errs()<<'\n';
            
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
                        pI->print(errs());
                        errs()<<'\n';
                        if(I != parent_BB->getInstList().end())
                            I->print(errs());
                        errs()<<'\n';
                        if(isLoopInvariant(*pI, L) && safeToHoist(*pI, L, DT))  
                        {
                            errs()<<"1\n";
                        
                            errs()<<"2\n";
                            BasicBlock* PreHeader = L->getLoopPreheader();
                            errs()<<"3\n";
                            pI->moveBefore(PreHeader->getTerminator());
                        }
                    }
                }
            }


            for(auto child : parent->getChildren())
            {
                errs()<<"has children\n";
                get_preorder(L,  DT , child );
            }
        }

        bool runOnLoop(Loop *L, LPPassManager &LPM) override {
            // return NodeList;

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

            DomTreeNodeBase<BasicBlock> *root = DT->getRootNode();

            errs() << "!!!!!!!!DT: " << root->getNumChildren() << "\n"
                   << "!!!!!!!!LI: " << LI->empty() << "\n";
             
            get_preorder(L,  DT , root );
        

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
