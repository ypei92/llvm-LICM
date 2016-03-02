; ModuleID = 'loc_test_mem_sim.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [16 x i8] c"%d %d %d %d %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %args) #0 {
entry:
  %thing = alloca [10 x i32], align 16
  %arrayidx = getelementptr inbounds i8*, i8** %args, i64 1
  %0 = load i8*, i8** %arrayidx, align 8
  %call = call i32 @atoi(i8* %0) #3
  %arrayidx1 = getelementptr inbounds i8*, i8** %args, i64 2
  %1 = load i8*, i8** %arrayidx1, align 8
  %call2 = call i32 @atoi(i8* %1) #3
  %arrayidx3 = getelementptr inbounds i8*, i8** %args, i64 3
  %2 = load i8*, i8** %arrayidx3, align 8
  %call4 = call i32 @atoi(i8* %2) #3
  %arrayidx5 = getelementptr inbounds [10 x i32], [10 x i32]* %thing, i64 0, i64 1
  store i32 10, i32* %arrayidx5, align 4
  %div = sdiv i32 %call4, %call
  br label %do.body

do.body:                                          ; preds = %do.cond, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %add, %do.cond ]
  %add = add nsw i32 %i.0, 1
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %cmp = icmp slt i32 %add, 5
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  br label %while.cond

while.cond:                                       ; preds = %while.body, %do.end
  %k.0 = phi i32 [ %div, %do.end ], [ %div7, %while.body ]
  %i.1 = phi i32 [ 0, %do.end ], [ %add8, %while.body ]
  %cmp6 = icmp slt i32 %i.1, 5
  br i1 %cmp6, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %div7 = sdiv i32 %call4, %call
  %add8 = add nsw i32 %i.1, 1
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %mul = mul nsw i32 %call, %call2
  %shl = shl i32 %call4, 2
  %add13 = add nsw i32 %shl, %mul
  %mul14 = mul nsw i32 3, %shl
  %idxprom = sext i32 %call to i64
  %arrayidx16 = getelementptr inbounds [10 x i32], [10 x i32]* %thing, i64 0, i64 %idxprom
  br label %for.cond

for.cond:                                         ; preds = %for.inc18, %while.end
  %i.2 = phi i32 [ 0, %while.end ], [ %inc19, %for.inc18 ]
  %j.0 = phi i32 [ 0, %while.end ], [ %j.1, %for.inc18 ]
  %l.0 = phi i32 [ 0, %while.end ], [ %l.1, %for.inc18 ]
  %o.0 = phi i32 [ 0, %while.end ], [ %o.1, %for.inc18 ]
  %q.0 = phi i32 [ 0, %while.end ], [ %q.1, %for.inc18 ]
  %cmp9 = icmp slt i32 %i.2, 2
  br i1 %cmp9, label %for.body, label %for.end20

for.body:                                         ; preds = %for.cond
  br label %for.cond10

for.cond10:                                       ; preds = %for.inc, %for.body
  %j.1 = phi i32 [ %j.0, %for.body ], [ %add13, %for.inc ]
  %l.1 = phi i32 [ %l.0, %for.body ], [ %mul14, %for.inc ]
  %o.1 = phi i32 [ %o.0, %for.body ], [ %add15, %for.inc ]
  %q.1 = phi i32 [ %q.0, %for.body ], [ %add17, %for.inc ]
  %p.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  %cmp11 = icmp slt i32 %p.0, 2
  br i1 %cmp11, label %for.body12, label %for.end

for.body12:                                       ; preds = %for.cond10
  %add15 = add nsw i32 %p.0, %i.2
  %3 = load i32, i32* %arrayidx16, align 4
  %add17 = add nsw i32 %call2, %3
  br label %for.inc

for.inc:                                          ; preds = %for.body12
  %inc = add nsw i32 %p.0, 1
  br label %for.cond10

for.end:                                          ; preds = %for.cond10
  br label %for.inc18

for.inc18:                                        ; preds = %for.end
  %inc19 = add nsw i32 %i.2, 1
  br label %for.cond

for.end20:                                        ; preds = %for.cond
  %call21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i32 0, i32 0), i32 %k.0, i32 %j.0, i32 %l.0, i32 %o.0, i32 %q.0)
  ret i32 0
}

; Function Attrs: nounwind readonly
declare i32 @atoi(i8*) #1

declare i32 @printf(i8*, ...) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0 (http://llvm.org/git/clang.git e88720a6287e5fa399e833ed5ddf4f0b475c37bd) (http://llvm.org/git/llvm.git 9867695c88ba0998618aa879e86315800c49c7c8)"}
