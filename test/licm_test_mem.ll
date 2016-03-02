; ModuleID = 'licm_test_mem.bc'
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
  %cmp = icmp slt i32 %argc, 5
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %call = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i32 0, i32 0))
  call void @exit(i32 1) #4
  unreachable

if.end:                                           ; preds = %entry
  %arrayidx = getelementptr inbounds i8*, i8** %argv, i64 1
  %1 = load i8*, i8** %arrayidx, align 8
  %call1 = call i32 @atoi(i8* %1) #5
  %arrayidx2 = getelementptr inbounds i8*, i8** %argv, i64 2
  %2 = load i8*, i8** %arrayidx2, align 8
  %call3 = call i32 @atoi(i8* %2) #5
  %arrayidx4 = getelementptr inbounds i8*, i8** %argv, i64 3
  %3 = load i8*, i8** %arrayidx4, align 8
  %call5 = call i32 @atoi(i8* %3) #5
  %arrayidx6 = getelementptr inbounds i8*, i8** %argv, i64 4
  %4 = load i8*, i8** %arrayidx6, align 8
  %call7 = call i32 @atoi(i8* %4) #5
  store i32 %call1, i32* getelementptr inbounds (%struct.twoInt, %struct.twoInt* @i2, i32 0, i32 0), align 4
  store i32 %call3, i32* getelementptr inbounds (%struct.twoInt, %struct.twoInt* @i2, i32 0, i32 1), align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc19, %if.end
  %d.0 = phi i32 [ %call7, %if.end ], [ %d.1, %for.inc19 ]
  %a.0 = phi i32 [ %call1, %if.end ], [ %a.1, %for.inc19 ]
  %x.0 = phi i32 [ undef, %if.end ], [ %x.1, %for.inc19 ]
  %j.0 = phi i32 [ 0, %if.end ], [ %inc20, %for.inc19 ]
  %cmp8 = icmp slt i32 %j.0, %call3
  br i1 %cmp8, label %for.body, label %for.end21

for.body:                                         ; preds = %for.cond
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc, %for.body
  %d.1 = phi i32 [ %d.0, %for.body ], [ %d.2, %for.inc ]
  %a.1 = phi i32 [ %a.0, %for.body ], [ %sub, %for.inc ]
  %x.1 = phi i32 [ %x.0, %for.body ], [ %add13, %for.inc ]
  %i.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  %cmp10 = icmp slt i32 %i.0, %call5
  br i1 %cmp10, label %for.body11, label %for.end

for.body11:                                       ; preds = %for.cond9
  %div = sdiv i32 %call5, %call3
  %mul = mul nsw i32 %call3, %j.0
  %add = add nsw i32 %div, %mul
  %mul12 = mul nsw i32 %call3, %j.0
  %5 = load i32, i32* getelementptr inbounds (%struct.twoInt, %struct.twoInt* @i2, i32 0, i32 0), align 4
  %add13 = add nsw i32 %mul12, %5
  %cmp14 = icmp eq i32 %j.0, %i.0
  br i1 %cmp14, label %if.then15, label %if.end17

if.then15:                                        ; preds = %for.body11
  %mul16 = mul nsw i32 %add, %call5
  br label %if.end17

if.end17:                                         ; preds = %if.then15, %for.body11
  %d.2 = phi i32 [ %mul16, %if.then15 ], [ %d.1, %for.body11 ]
  %sub = sub nsw i32 %add, %call5
  br label %for.inc

for.inc:                                          ; preds = %if.end17
  %inc = add nsw i32 %i.0, 1
  br label %for.cond9

for.end:                                          ; preds = %for.cond9
  %add18 = add nsw i32 %call3, %call5
  store i32 %add18, i32* getelementptr inbounds (%struct.twoInt, %struct.twoInt* @i2, i32 0, i32 1), align 4
  br label %for.inc19

for.inc19:                                        ; preds = %for.end
  %inc20 = add nsw i32 %j.0, 1
  br label %for.cond

for.end21:                                        ; preds = %for.cond
  %6 = load i32, i32* getelementptr inbounds (%struct.twoInt, %struct.twoInt* @i2, i32 0, i32 0), align 4
  %7 = load i32, i32* getelementptr inbounds (%struct.twoInt, %struct.twoInt* @i2, i32 0, i32 1), align 4
  %call22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.1, i32 0, i32 0), i32 %a.0, i32 %call3, i32 %call5, i32 %d.0, i32 %x.0, i32 %6, i32 %7)
  ret i32 0
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
