; ModuleID = 'loc_test_maybe.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [16 x i8] c"%d %d %d %d %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @maybe(i32 %num) #0 {
entry:
  %num.addr = alloca i32, align 4
  store i32 %num, i32* %num.addr, align 4
  %0 = load i32, i32* %num.addr, align 4
  %cmp = icmp ne i32 %0, 2
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @exit(i32 1) #4
  unreachable

if.end:                                           ; preds = %entry
  ret void
}

; Function Attrs: noreturn nounwind
declare void @exit(i32) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %args) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %args.addr = alloca i8**, align 8
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  %k = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %l = alloca i32, align 4
  %o = alloca i32, align 4
  %q = alloca i32, align 4
  %thing = alloca [10 x i32], align 16
  %p = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %args, i8*** %args.addr, align 8
  %0 = load i8**, i8*** %args.addr, align 8
  %arrayidx = getelementptr inbounds i8*, i8** %0, i64 1
  %1 = load i8*, i8** %arrayidx, align 8
  %call = call i32 @atoi(i8* %1) #5
  store i32 %call, i32* %x, align 4
  %2 = load i8**, i8*** %args.addr, align 8
  %arrayidx1 = getelementptr inbounds i8*, i8** %2, i64 2
  %3 = load i8*, i8** %arrayidx1, align 8
  %call2 = call i32 @atoi(i8* %3) #5
  store i32 %call2, i32* %y, align 4
  %4 = load i8**, i8*** %args.addr, align 8
  %arrayidx3 = getelementptr inbounds i8*, i8** %4, i64 3
  %5 = load i8*, i8** %arrayidx3, align 8
  %call4 = call i32 @atoi(i8* %5) #5
  store i32 %call4, i32* %z, align 4
  store i32 0, i32* %i, align 4
  store i32 0, i32* %j, align 4
  store i32 0, i32* %l, align 4
  store i32 0, i32* %o, align 4
  store i32 0, i32* %q, align 4
  %arrayidx5 = getelementptr inbounds [10 x i32], [10 x i32]* %thing, i64 0, i64 1
  store i32 10, i32* %arrayidx5, align 4
  br label %do.body

do.body:                                          ; preds = %do.cond, %entry
  %6 = load i32, i32* %y, align 4
  call void @maybe(i32 %6)
  %7 = load i32, i32* %z, align 4
  %8 = load i32, i32* %x, align 4
  %div = sdiv i32 %7, %8
  store i32 %div, i32* %k, align 4
  %9 = load i32, i32* %i, align 4
  %add = add nsw i32 %9, 1
  store i32 %add, i32* %i, align 4
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %10 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %10, 5
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  store i32 0, i32* %i, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.body, %do.end
  %11 = load i32, i32* %i, align 4
  %cmp6 = icmp slt i32 %11, 5
  br i1 %cmp6, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %12 = load i32, i32* %z, align 4
  %13 = load i32, i32* %x, align 4
  %div7 = sdiv i32 %12, %13
  store i32 %div7, i32* %k, align 4
  %14 = load i32, i32* %i, align 4
  %add8 = add nsw i32 %14, 1
  store i32 %add8, i32* %i, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc18, %while.end
  %15 = load i32, i32* %i, align 4
  %cmp9 = icmp slt i32 %15, 2
  br i1 %cmp9, label %for.body, label %for.end20

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %p, align 4
  br label %for.cond10

for.cond10:                                       ; preds = %for.inc, %for.body
  %16 = load i32, i32* %p, align 4
  %cmp11 = icmp slt i32 %16, 2
  br i1 %cmp11, label %for.body12, label %for.end

for.body12:                                       ; preds = %for.cond10
  %17 = load i32, i32* %x, align 4
  %18 = load i32, i32* %y, align 4
  %mul = mul nsw i32 %17, %18
  store i32 %mul, i32* %a, align 4
  %19 = load i32, i32* %z, align 4
  %shl = shl i32 %19, 2
  store i32 %shl, i32* %b, align 4
  %20 = load i32, i32* %b, align 4
  %21 = load i32, i32* %a, align 4
  %add13 = add nsw i32 %20, %21
  store i32 %add13, i32* %j, align 4
  %22 = load i32, i32* %b, align 4
  %mul14 = mul nsw i32 3, %22
  store i32 %mul14, i32* %l, align 4
  %23 = load i32, i32* %p, align 4
  %24 = load i32, i32* %i, align 4
  %add15 = add nsw i32 %23, %24
  store i32 %add15, i32* %o, align 4
  %25 = load i32, i32* %y, align 4
  %26 = load i32, i32* %x, align 4
  %idxprom = sext i32 %26 to i64
  %arrayidx16 = getelementptr inbounds [10 x i32], [10 x i32]* %thing, i64 0, i64 %idxprom
  %27 = load i32, i32* %arrayidx16, align 4
  %add17 = add nsw i32 %25, %27
  store i32 %add17, i32* %q, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body12
  %28 = load i32, i32* %p, align 4
  %inc = add nsw i32 %28, 1
  store i32 %inc, i32* %p, align 4
  br label %for.cond10

for.end:                                          ; preds = %for.cond10
  br label %for.inc18

for.inc18:                                        ; preds = %for.end
  %29 = load i32, i32* %i, align 4
  %inc19 = add nsw i32 %29, 1
  store i32 %inc19, i32* %i, align 4
  br label %for.cond

for.end20:                                        ; preds = %for.cond
  %30 = load i32, i32* %k, align 4
  %31 = load i32, i32* %j, align 4
  %32 = load i32, i32* %l, align 4
  %33 = load i32, i32* %o, align 4
  %34 = load i32, i32* %q, align 4
  %call21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i32 0, i32 0), i32 %30, i32 %31, i32 %32, i32 %33, i32 %34)
  %35 = load i32, i32* %retval, align 4
  ret i32 %35
}

; Function Attrs: nounwind readonly
declare i32 @atoi(i8*) #2

declare i32 @printf(i8*, ...) #3

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0 (http://llvm.org/git/clang.git e88720a6287e5fa399e833ed5ddf4f0b475c37bd) (http://llvm.org/git/llvm.git 9867695c88ba0998618aa879e86315800c49c7c8)"}
