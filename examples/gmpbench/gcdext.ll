; ModuleID = 'gcdext.c'
source_filename = "gcdext.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__gmp_randstate_struct = type { [1 x %struct.__mpz_struct], i32, %union.anon }
%struct.__mpz_struct = type { i32, i32, ptr }
%union.anon = type { ptr }
%struct.rusage = type { %struct.timeval, %struct.timeval, %union.anon.0, %union.anon.1, %union.anon.2, %union.anon.3, %union.anon.4, %union.anon.5, %union.anon.6, %union.anon.7, %union.anon.8, %union.anon.9, %union.anon.10, %union.anon.11, %union.anon.12, %union.anon.13 }
%struct.timeval = type { i64, i64 }
%union.anon.0 = type { i64 }
%union.anon.1 = type { i64 }
%union.anon.2 = type { i64 }
%union.anon.3 = type { i64 }
%union.anon.4 = type { i64 }
%union.anon.5 = type { i64 }
%union.anon.6 = type { i64 }
%union.anon.7 = type { i64 }
%union.anon.8 = type { i64 }
%union.anon.9 = type { i64 }
%union.anon.10 = type { i64 }
%union.anon.11 = type { i64 }
%union.anon.12 = type { i64 }
%union.anon.13 = type { i64 }

@stderr = external global ptr, align 8
@.str = private unnamed_addr constant [15 x i8] c"usage: %s m n\0A\00", align 1
@.str.1 = private unnamed_addr constant [54 x i8] c"  where m and n are number of bits in numbers tested\0A\00", align 1
@.str.2 = private unnamed_addr constant [25 x i8] c"Calibrating CPU speed...\00", align 1
@stdout = external global ptr, align 8
@.str.3 = private unnamed_addr constant [6 x i8] c"done\0A\00", align 1
@.str.4 = private unnamed_addr constant [60 x i8] c"Multiplying %lu-bit number with %lu-bit number %lu times...\00", align 1
@.str.5 = private unnamed_addr constant [7 x i8] c"done!\0A\00", align 1
@.str.6 = private unnamed_addr constant [36 x i8] c"RESULT: %.*f operations per second\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %argc, ptr noundef %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca ptr, align 8
  %rs = alloca [1 x %struct.__gmp_randstate_struct], align 16
  %x = alloca [1 x %struct.__mpz_struct], align 16
  %y = alloca [1 x %struct.__mpz_struct], align 16
  %z = alloca [1 x %struct.__mpz_struct], align 16
  %s = alloca [1 x %struct.__mpz_struct], align 16
  %m = alloca i64, align 8
  %n = alloca i64, align 8
  %i = alloca i64, align 8
  %niter = alloca i64, align 8
  %t0 = alloca i64, align 8
  %ti = alloca i64, align 8
  %t = alloca double, align 8
  %f = alloca double, align 8
  %ops_per_sec = alloca double, align 8
  %decimals = alloca i32, align 4
  %__t0 = alloca i64, align 8
  %__times = alloca i64, align 8
  %__t = alloca i64, align 8
  %__tmp = alloca i64, align 8
  store i32 0, ptr %retval, align 4
  store i32 %argc, ptr %argc.addr, align 4
  store ptr %argv, ptr %argv.addr, align 8
  %0 = load i32, ptr %argc.addr, align 4
  %cmp = icmp ne i32 %0, 3
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr @stderr, align 8
  %2 = load ptr, ptr %argv.addr, align 8
  %arrayidx = getelementptr inbounds ptr, ptr %2, i64 0
  %3 = load ptr, ptr %arrayidx, align 8
  %call = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %1, ptr noundef @.str, ptr noundef %3)
  %4 = load ptr, ptr @stderr, align 8
  %call1 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef @.str.1)
  store i32 -1, ptr %retval, align 4
  br label %return

if.end:                                           ; preds = %entry
  %5 = load ptr, ptr %argv.addr, align 8
  %arrayidx2 = getelementptr inbounds ptr, ptr %5, i64 1
  %6 = load ptr, ptr %arrayidx2, align 8
  %call3 = call i32 @atoi(ptr noundef %6) #4
  %conv = sext i32 %call3 to i64
  store i64 %conv, ptr %m, align 8
  %7 = load ptr, ptr %argv.addr, align 8
  %arrayidx4 = getelementptr inbounds ptr, ptr %7, i64 2
  %8 = load ptr, ptr %arrayidx4, align 8
  %call5 = call i32 @atoi(ptr noundef %8) #4
  %conv6 = sext i32 %call5 to i64
  store i64 %conv6, ptr %n, align 8
  %arraydecay = getelementptr inbounds [1 x %struct.__gmp_randstate_struct], ptr %rs, i64 0, i64 0
  call void @__gmp_randinit_default(ptr noundef %arraydecay)
  %arraydecay7 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %x, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay7)
  %arraydecay8 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %y, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay8)
  %arraydecay9 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %z, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay9)
  %arraydecay10 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %s, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay10)
  %arraydecay11 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %x, i64 0, i64 0
  %arraydecay12 = getelementptr inbounds [1 x %struct.__gmp_randstate_struct], ptr %rs, i64 0, i64 0
  %9 = load i64, ptr %m, align 8
  call void @__gmpz_urandomb(ptr noundef %arraydecay11, ptr noundef %arraydecay12, i64 noundef %9)
  %arraydecay13 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %y, i64 0, i64 0
  %arraydecay14 = getelementptr inbounds [1 x %struct.__gmp_randstate_struct], ptr %rs, i64 0, i64 0
  %10 = load i64, ptr %n, align 8
  call void @__gmpz_urandomb(ptr noundef %arraydecay13, ptr noundef %arraydecay14, i64 noundef %10)
  %call15 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  %11 = load ptr, ptr @stdout, align 8
  %call16 = call i32 @fflush(ptr noundef %11)
  br label %do.body

do.body:                                          ; preds = %if.end
  store i64 1, ptr %__times, align 8
  %arraydecay17 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %z, i64 0, i64 0
  %arraydecay18 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %s, i64 0, i64 0
  %arraydecay19 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %x, i64 0, i64 0
  %arraydecay20 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %y, i64 0, i64 0
  call void @__gmpz_gcdext(ptr noundef %arraydecay17, ptr noundef %arraydecay18, ptr noundef null, ptr noundef %arraydecay19, ptr noundef %arraydecay20)
  br label %do.body21

do.body21:                                        ; preds = %do.cond, %do.body
  %12 = load i64, ptr %__times, align 8
  %shl = shl i64 %12, 1
  store i64 %shl, ptr %__times, align 8
  %call22 = call i32 @cputime()
  %conv23 = sext i32 %call22 to i64
  store i64 %conv23, ptr %__t0, align 8
  store i64 0, ptr %__t, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %do.body21
  %13 = load i64, ptr %__t, align 8
  %14 = load i64, ptr %__times, align 8
  %cmp24 = icmp slt i64 %13, %14
  br i1 %cmp24, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %arraydecay26 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %z, i64 0, i64 0
  %arraydecay27 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %s, i64 0, i64 0
  %arraydecay28 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %x, i64 0, i64 0
  %arraydecay29 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %y, i64 0, i64 0
  call void @__gmpz_gcdext(ptr noundef %arraydecay26, ptr noundef %arraydecay27, ptr noundef null, ptr noundef %arraydecay28, ptr noundef %arraydecay29)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %15 = load i64, ptr %__t, align 8
  %inc = add nsw i64 %15, 1
  store i64 %inc, ptr %__t, align 8
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  %call30 = call i32 @cputime()
  %conv31 = sext i32 %call30 to i64
  %16 = load i64, ptr %__t0, align 8
  %sub = sub nsw i64 %conv31, %16
  store i64 %sub, ptr %__tmp, align 8
  br label %do.cond

do.cond:                                          ; preds = %for.end
  %17 = load i64, ptr %__tmp, align 8
  %cmp32 = icmp slt i64 %17, 250
  br i1 %cmp32, label %do.body21, label %do.end, !llvm.loop !8

do.end:                                           ; preds = %do.cond
  %18 = load i64, ptr %__tmp, align 8
  %conv34 = sitofp i64 %18 to double
  %19 = load i64, ptr %__times, align 8
  %conv35 = sitofp i64 %19 to double
  %div = fdiv double %conv34, %conv35
  store double %div, ptr %t, align 8
  br label %do.end37

do.end37:                                         ; preds = %do.end
  %call38 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %20 = load double, ptr %t, align 8
  %div39 = fdiv double 1.000000e+04, %20
  %conv40 = fptoui double %div39 to i64
  %add = add i64 1, %conv40
  store i64 %add, ptr %niter, align 8
  %21 = load i64, ptr %m, align 8
  %22 = load i64, ptr %n, align 8
  %23 = load i64, ptr %niter, align 8
  %call41 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i64 noundef %21, i64 noundef %22, i64 noundef %23)
  %24 = load ptr, ptr @stdout, align 8
  %call42 = call i32 @fflush(ptr noundef %24)
  %call43 = call i32 @cputime()
  %conv44 = sext i32 %call43 to i64
  store i64 %conv44, ptr %t0, align 8
  %25 = load i64, ptr %niter, align 8
  store i64 %25, ptr %i, align 8
  br label %for.cond45

for.cond45:                                       ; preds = %for.inc53, %do.end37
  %26 = load i64, ptr %i, align 8
  %cmp46 = icmp ugt i64 %26, 0
  br i1 %cmp46, label %for.body48, label %for.end54

for.body48:                                       ; preds = %for.cond45
  %arraydecay49 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %z, i64 0, i64 0
  %arraydecay50 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %s, i64 0, i64 0
  %arraydecay51 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %x, i64 0, i64 0
  %arraydecay52 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %y, i64 0, i64 0
  call void @__gmpz_gcdext(ptr noundef %arraydecay49, ptr noundef %arraydecay50, ptr noundef null, ptr noundef %arraydecay51, ptr noundef %arraydecay52)
  br label %for.inc53

for.inc53:                                        ; preds = %for.body48
  %27 = load i64, ptr %i, align 8
  %dec = add i64 %27, -1
  store i64 %dec, ptr %i, align 8
  br label %for.cond45, !llvm.loop !9

for.end54:                                        ; preds = %for.cond45
  %call55 = call i32 @cputime()
  %conv56 = sext i32 %call55 to i64
  %28 = load i64, ptr %t0, align 8
  %sub57 = sub i64 %conv56, %28
  store i64 %sub57, ptr %ti, align 8
  %call58 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  %29 = load i64, ptr %niter, align 8
  %conv59 = uitofp i64 %29 to double
  %mul = fmul double 1.000000e+03, %conv59
  %30 = load i64, ptr %ti, align 8
  %conv60 = uitofp i64 %30 to double
  %div61 = fdiv double %mul, %conv60
  store double %div61, ptr %ops_per_sec, align 8
  store double 1.000000e+02, ptr %f, align 8
  store i32 0, ptr %decimals, align 4
  br label %for.cond62

for.cond62:                                       ; preds = %for.inc68, %for.end54
  %31 = load double, ptr %ops_per_sec, align 8
  %32 = load double, ptr %f, align 8
  %cmp63 = fcmp ogt double %31, %32
  br i1 %cmp63, label %if.then65, label %if.end66

if.then65:                                        ; preds = %for.cond62
  br label %for.end70

if.end66:                                         ; preds = %for.cond62
  %33 = load double, ptr %f, align 8
  %mul67 = fmul double %33, 1.000000e-01
  store double %mul67, ptr %f, align 8
  br label %for.inc68

for.inc68:                                        ; preds = %if.end66
  %34 = load i32, ptr %decimals, align 4
  %inc69 = add nsw i32 %34, 1
  store i32 %inc69, ptr %decimals, align 4
  br label %for.cond62

for.end70:                                        ; preds = %if.then65
  %35 = load i32, ptr %decimals, align 4
  %36 = load double, ptr %ops_per_sec, align 8
  %call71 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %35, double noundef %36)
  store i32 0, ptr %retval, align 4
  br label %return

return:                                           ; preds = %for.end70, %if.then
  %37 = load i32, ptr %retval, align 4
  ret i32 %37
}

declare i32 @fprintf(ptr noundef, ptr noundef, ...) #1

; Function Attrs: nounwind willreturn memory(read)
declare i32 @atoi(ptr noundef) #2

declare void @__gmp_randinit_default(ptr noundef) #1

declare void @__gmpz_init(ptr noundef) #1

declare void @__gmpz_urandomb(ptr noundef, ptr noundef, i64 noundef) #1

declare i32 @printf(ptr noundef, ...) #1

declare i32 @fflush(ptr noundef) #1

declare void @__gmpz_gcdext(ptr noundef, ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @cputime() #0 {
entry:
  %rus = alloca %struct.rusage, align 8
  %call = call i32 @getrusage(i32 noundef 0, ptr noundef %rus) #5
  %ru_utime = getelementptr inbounds %struct.rusage, ptr %rus, i32 0, i32 0
  %tv_sec = getelementptr inbounds %struct.timeval, ptr %ru_utime, i32 0, i32 0
  %0 = load i64, ptr %tv_sec, align 8
  %mul = mul nsw i64 %0, 1000
  %ru_utime1 = getelementptr inbounds %struct.rusage, ptr %rus, i32 0, i32 0
  %tv_usec = getelementptr inbounds %struct.timeval, ptr %ru_utime1, i32 0, i32 1
  %1 = load i64, ptr %tv_usec, align 8
  %div = sdiv i64 %1, 1000
  %add = add nsw i64 %mul, %div
  %conv = trunc i64 %add to i32
  ret i32 %conv
}

; Function Attrs: nounwind
declare i32 @getrusage(i32 noundef, ptr noundef) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind willreturn memory(read) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind willreturn memory(read) }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.0 (https://github.com/khei4/llvm-project.git ea72b5137eb72391ad192dbb01084c21b9fe8b71)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
