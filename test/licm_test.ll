; ModuleID = 'licm_test.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.twoInt = type { i32, i32 }

@stderr = external global %struct._IO_FILE*, align 8
@.str = private unnamed_addr constant [21 x i8] c"USAGE: licm a b c d\0A\00", align 1
@i2 = common global %struct.twoInt zeroinitializer, align 4
@.str.1 = private unnamed_addr constant [22 x i8] c"%d %d %d %d %d %d %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %x = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %0 = load i32, i32* %argc.addr, align 4
  %cmp = icmp slt i32 %0, 5
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %call = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %1, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i32 0, i32 0))
  call void @exit(i32 1) #4
  unreachable

if.end:                                           ; preds = %entry
  %2 = load i8**, i8*** %argv.addr, align 8
  %arrayidx = getelementptr inbounds i8*, i8** %2, i64 1
  %3 = load i8*, i8** %arrayidx, align 8
  %call1 = call i32 @atoi(i8* %3) #5
  store i32 %call1, i32* %a, align 4
  %4 = load i8**, i8*** %argv.addr, align 8
  %arrayidx2 = getelementptr inbounds i8*, i8** %4, i64 2
  %5 = load i8*, i8** %arrayidx2, align 8
  %call3 = call i32 @atoi(i8* %5) #5
  store i32 %call3, i32* %b, align 4
  %6 = load i8**, i8*** %argv.addr, align 8
  %arrayidx4 = getelementptr inbounds i8*, i8** %6, i64 3
  %7 = load i8*, i8** %arrayidx4, align 8
  %call5 = call i32 @atoi(i8* %7) #5
  store i32 %call5, i32* %c, align 4
  %8 = load i8**, i8*** %argv.addr, align 8
  %arrayidx6 = getelementptr inbounds i8*, i8** %8, i64 4
  %9 = load i8*, i8** %arrayidx6, align 8
  %call7 = call i32 @atoi(i8* %9) #5
  store i32 %call7, i32* %d, align 4
  %10 = load i32, i32* %a, align 4
  store i32 %10, i32* getelementptr inbounds (%struct.twoInt, %struct.twoInt* @i2, i32 0, i32 0), align 4
  %11 = load i32, i32* %b, align 4
  store i32 %11, i32* getelementptr inbounds (%struct.twoInt, %struct.twoInt* @i2, i32 0, i32 1), align 4
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc19, %if.end
  %12 = load i32, i32* %j, align 4
  %13 = load i32, i32* %b, align 4
  %cmp8 = icmp slt i32 %12, %13
  br i1 %cmp8, label %for.body, label %for.end21

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc, %for.body
  %14 = load i32, i32* %i, align 4
  %15 = load i32, i32* %c, align 4
  %cmp10 = icmp slt i32 %14, %15
  br i1 %cmp10, label %for.body11, label %for.end

for.body11:                                       ; preds = %for.cond9
  %16 = load i32, i32* %c, align 4
  %17 = load i32, i32* %b, align 4
  %div = sdiv i32 %16, %17
  %18 = load i32, i32* %b, align 4
  %19 = load i32, i32* %j, align 4
  %mul = mul nsw i32 %18, %19
  %add = add nsw i32 %div, %mul
  store i32 %add, i32* %a, align 4
  %20 = load i32, i32* %b, align 4
  %21 = load i32, i32* %j, align 4
  %mul12 = mul nsw i32 %20, %21
  %22 = load i32, i32* getelementptr inbounds (%struct.twoInt, %struct.twoInt* @i2, i32 0, i32 0), align 4
  %add13 = add nsw i32 %mul12, %22
  store i32 %add13, i32* %x, align 4
  %23 = load i32, i32* %j, align 4
  %24 = load i32, i32* %i, align 4
  %cmp14 = icmp eq i32 %23, %24
  br i1 %cmp14, label %if.then15, label %if.end17

if.then15:                                        ; preds = %for.body11
  %25 = load i32, i32* %a, align 4
  %26 = load i32, i32* %c, align 4
  %mul16 = mul nsw i32 %25, %26
  store i32 %mul16, i32* %d, align 4
  br label %if.end17

if.end17:                                         ; preds = %if.then15, %for.body11
  %27 = load i32, i32* %a, align 4
  %28 = load i32, i32* %c, align 4
  %sub = sub nsw i32 %27, %28
  store i32 %sub, i32* %a, align 4
  br label %for.inc

for.inc:                                          ; preds = %if.end17
  %29 = load i32, i32* %i, align 4
  %inc = add nsw i32 %29, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond9

for.end:                                          ; preds = %for.cond9
  %30 = load i32, i32* %b, align 4
  %31 = load i32, i32* %c, align 4
  %add18 = add nsw i32 %30, %31
  store i32 %add18, i32* getelementptr inbounds (%struct.twoInt, %struct.twoInt* @i2, i32 0, i32 1), align 4
  br label %for.inc19

for.inc19:                                        ; preds = %for.end
  %32 = load i32, i32* %j, align 4
  %inc20 = add nsw i32 %32, 1
  store i32 %inc20, i32* %j, align 4
  br label %for.cond

for.end21:                                        ; preds = %for.cond
  %33 = load i32, i32* %a, align 4
  %34 = load i32, i32* %b, align 4
  %35 = load i32, i32* %c, align 4
  %36 = load i32, i32* %d, align 4
  %37 = load i32, i32* %x, align 4
  %38 = load i32, i32* getelementptr inbounds (%struct.twoInt, %struct.twoInt* @i2, i32 0, i32 0), align 4
  %39 = load i32, i32* getelementptr inbounds (%struct.twoInt, %struct.twoInt* @i2, i32 0, i32 1), align 4
  %call22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.1, i32 0, i32 0), i32 %33, i32 %34, i32 %35, i32 %36, i32 %37, i32 %38, i32 %39)
  %40 = load i32, i32* %retval, align 4
  ret i32 %40
}

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

; Function Attrs: nounwind readonly
declare i32 @atoi(i8*) #3

declare i32 @printf(i8*, ...) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0 "}
