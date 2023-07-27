; ModuleID = 'multiply.c'
source_filename = "multiply.c"
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
@.str.4 = private unnamed_addr constant [39 x i8] c"Squaring a %lu-bit number %lu times...\00", align 1
@.str.5 = private unnamed_addr constant [60 x i8] c"Multiplying %lu-bit number with %lu-bit number %lu times...\00", align 1
@.str.6 = private unnamed_addr constant [7 x i8] c"done!\0A\00", align 1
@.str.7 = private unnamed_addr constant [36 x i8] c"RESULT: %.*f operations per second\0A\00", align 1

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
  %xptr = alloca ptr, align 8
  %yptr = alloca ptr, align 8
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
  %arraydecay = getelementptr inbounds [1 x %struct.__gmp_randstate_struct], ptr %rs, i64 0, i64 0
  call void @__gmp_randinit_default(ptr noundef %arraydecay)
  %arraydecay1 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %x, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay1)
  %arraydecay2 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %y, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay2)
  %arraydecay3 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %z, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay3)
  %0 = load i32, ptr %argc.addr, align 4
  %cmp = icmp eq i32 %0, 2
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %argv.addr, align 8
  %arrayidx = getelementptr inbounds ptr, ptr %1, i64 1
  %2 = load ptr, ptr %arrayidx, align 8
  %call = call i32 @atoi(ptr noundef %2) #4
  %conv = sext i32 %call to i64
  store i64 %conv, ptr %m, align 8
  %arraydecay4 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %x, i64 0, i64 0
  %arraydecay5 = getelementptr inbounds [1 x %struct.__gmp_randstate_struct], ptr %rs, i64 0, i64 0
  %3 = load i64, ptr %m, align 8
  call void @__gmpz_urandomb(ptr noundef %arraydecay4, ptr noundef %arraydecay5, i64 noundef %3)
  %arraydecay6 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %x, i64 0, i64 0
  store ptr %arraydecay6, ptr %xptr, align 8
  %arraydecay7 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %x, i64 0, i64 0
  store ptr %arraydecay7, ptr %yptr, align 8
  br label %if.end27

if.else:                                          ; preds = %entry
  %4 = load i32, ptr %argc.addr, align 4
  %cmp8 = icmp eq i32 %4, 3
  br i1 %cmp8, label %if.then10, label %if.else23

if.then10:                                        ; preds = %if.else
  %5 = load ptr, ptr %argv.addr, align 8
  %arrayidx11 = getelementptr inbounds ptr, ptr %5, i64 1
  %6 = load ptr, ptr %arrayidx11, align 8
  %call12 = call i32 @atoi(ptr noundef %6) #4
  %conv13 = sext i32 %call12 to i64
  store i64 %conv13, ptr %m, align 8
  %7 = load ptr, ptr %argv.addr, align 8
  %arrayidx14 = getelementptr inbounds ptr, ptr %7, i64 2
  %8 = load ptr, ptr %arrayidx14, align 8
  %call15 = call i32 @atoi(ptr noundef %8) #4
  %conv16 = sext i32 %call15 to i64
  store i64 %conv16, ptr %n, align 8
  %arraydecay17 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %x, i64 0, i64 0
  %arraydecay18 = getelementptr inbounds [1 x %struct.__gmp_randstate_struct], ptr %rs, i64 0, i64 0
  %9 = load i64, ptr %m, align 8
  call void @__gmpz_urandomb(ptr noundef %arraydecay17, ptr noundef %arraydecay18, i64 noundef %9)
  %arraydecay19 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %y, i64 0, i64 0
  %arraydecay20 = getelementptr inbounds [1 x %struct.__gmp_randstate_struct], ptr %rs, i64 0, i64 0
  %10 = load i64, ptr %n, align 8
  call void @__gmpz_urandomb(ptr noundef %arraydecay19, ptr noundef %arraydecay20, i64 noundef %10)
  %arraydecay21 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %x, i64 0, i64 0
  store ptr %arraydecay21, ptr %xptr, align 8
  %arraydecay22 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %y, i64 0, i64 0
  store ptr %arraydecay22, ptr %yptr, align 8
  br label %if.end

if.else23:                                        ; preds = %if.else
  %11 = load ptr, ptr @stderr, align 8
  %12 = load ptr, ptr %argv.addr, align 8
  %arrayidx24 = getelementptr inbounds ptr, ptr %12, i64 0
  %13 = load ptr, ptr %arrayidx24, align 8
  %call25 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %11, ptr noundef @.str, ptr noundef %13)
  %14 = load ptr, ptr @stderr, align 8
  %call26 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %14, ptr noundef @.str.1)
  store i32 -1, ptr %retval, align 4
  br label %return

if.end:                                           ; preds = %if.then10
  br label %if.end27

if.end27:                                         ; preds = %if.end, %if.then
  %call28 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  %15 = load ptr, ptr @stdout, align 8
  %call29 = call i32 @fflush(ptr noundef %15)
  br label %do.body

do.body:                                          ; preds = %if.end27
  store i64 1, ptr %__times, align 8
  %arraydecay30 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %z, i64 0, i64 0
  %16 = load ptr, ptr %xptr, align 8
  %17 = load ptr, ptr %yptr, align 8
  call void @__gmpz_mul(ptr noundef %arraydecay30, ptr noundef %16, ptr noundef %17)
  br label %do.body31

do.body31:                                        ; preds = %do.cond, %do.body
  %18 = load i64, ptr %__times, align 8
  %shl = shl i64 %18, 1
  store i64 %shl, ptr %__times, align 8
  %call32 = call i32 @cputime()
  %conv33 = sext i32 %call32 to i64
  store i64 %conv33, ptr %__t0, align 8
  store i64 0, ptr %__t, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %do.body31
  %19 = load i64, ptr %__t, align 8
  %20 = load i64, ptr %__times, align 8
  %cmp34 = icmp slt i64 %19, %20
  br i1 %cmp34, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %arraydecay36 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %z, i64 0, i64 0
  %21 = load ptr, ptr %xptr, align 8
  %22 = load ptr, ptr %yptr, align 8
  call void @__gmpz_mul(ptr noundef %arraydecay36, ptr noundef %21, ptr noundef %22)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %23 = load i64, ptr %__t, align 8
  %inc = add nsw i64 %23, 1
  store i64 %inc, ptr %__t, align 8
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  %call37 = call i32 @cputime()
  %conv38 = sext i32 %call37 to i64
  %24 = load i64, ptr %__t0, align 8
  %sub = sub nsw i64 %conv38, %24
  store i64 %sub, ptr %__tmp, align 8
  br label %do.cond

do.cond:                                          ; preds = %for.end
  %25 = load i64, ptr %__tmp, align 8
  %cmp39 = icmp slt i64 %25, 250
  br i1 %cmp39, label %do.body31, label %do.end, !llvm.loop !8

do.end:                                           ; preds = %do.cond
  %26 = load i64, ptr %__tmp, align 8
  %conv41 = sitofp i64 %26 to double
  %27 = load i64, ptr %__times, align 8
  %conv42 = sitofp i64 %27 to double
  %div = fdiv double %conv41, %conv42
  store double %div, ptr %t, align 8
  br label %do.end44

do.end44:                                         ; preds = %do.end
  %call45 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %28 = load double, ptr %t, align 8
  %div46 = fdiv double 1.000000e+04, %28
  %conv47 = fptoui double %div46 to i64
  %add = add i64 1, %conv47
  store i64 %add, ptr %niter, align 8
  %29 = load i32, ptr %argc.addr, align 4
  %cmp48 = icmp eq i32 %29, 2
  br i1 %cmp48, label %if.then50, label %if.else52

if.then50:                                        ; preds = %do.end44
  %30 = load i64, ptr %m, align 8
  %31 = load i64, ptr %niter, align 8
  %call51 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i64 noundef %30, i64 noundef %31)
  br label %if.end54

if.else52:                                        ; preds = %do.end44
  %32 = load i64, ptr %m, align 8
  %33 = load i64, ptr %n, align 8
  %34 = load i64, ptr %niter, align 8
  %call53 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i64 noundef %32, i64 noundef %33, i64 noundef %34)
  br label %if.end54

if.end54:                                         ; preds = %if.else52, %if.then50
  %35 = load ptr, ptr @stdout, align 8
  %call55 = call i32 @fflush(ptr noundef %35)
  %call56 = call i32 @cputime()
  %conv57 = sext i32 %call56 to i64
  store i64 %conv57, ptr %t0, align 8
  %36 = load i64, ptr %niter, align 8
  store i64 %36, ptr %i, align 8
  br label %for.cond58

for.cond58:                                       ; preds = %for.inc63, %if.end54
  %37 = load i64, ptr %i, align 8
  %cmp59 = icmp ugt i64 %37, 0
  br i1 %cmp59, label %for.body61, label %for.end64

for.body61:                                       ; preds = %for.cond58
  %arraydecay62 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %z, i64 0, i64 0
  %38 = load ptr, ptr %xptr, align 8
  %39 = load ptr, ptr %yptr, align 8
  call void @__gmpz_mul(ptr noundef %arraydecay62, ptr noundef %38, ptr noundef %39)
  br label %for.inc63

for.inc63:                                        ; preds = %for.body61
  %40 = load i64, ptr %i, align 8
  %dec = add i64 %40, -1
  store i64 %dec, ptr %i, align 8
  br label %for.cond58, !llvm.loop !9

for.end64:                                        ; preds = %for.cond58
  %call65 = call i32 @cputime()
  %conv66 = sext i32 %call65 to i64
  %41 = load i64, ptr %t0, align 8
  %sub67 = sub i64 %conv66, %41
  store i64 %sub67, ptr %ti, align 8
  %call68 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  %42 = load i64, ptr %niter, align 8
  %conv69 = uitofp i64 %42 to double
  %mul = fmul double 1.000000e+03, %conv69
  %43 = load i64, ptr %ti, align 8
  %conv70 = uitofp i64 %43 to double
  %div71 = fdiv double %mul, %conv70
  store double %div71, ptr %ops_per_sec, align 8
  store double 1.000000e+02, ptr %f, align 8
  store i32 0, ptr %decimals, align 4
  br label %for.cond72

for.cond72:                                       ; preds = %for.inc78, %for.end64
  %44 = load double, ptr %ops_per_sec, align 8
  %45 = load double, ptr %f, align 8
  %cmp73 = fcmp ogt double %44, %45
  br i1 %cmp73, label %if.then75, label %if.end76

if.then75:                                        ; preds = %for.cond72
  br label %for.end80

if.end76:                                         ; preds = %for.cond72
  %46 = load double, ptr %f, align 8
  %mul77 = fmul double %46, 1.000000e-01
  store double %mul77, ptr %f, align 8
  br label %for.inc78

for.inc78:                                        ; preds = %if.end76
  %47 = load i32, ptr %decimals, align 4
  %inc79 = add nsw i32 %47, 1
  store i32 %inc79, ptr %decimals, align 4
  br label %for.cond72

for.end80:                                        ; preds = %if.then75
  %48 = load i32, ptr %decimals, align 4
  %49 = load double, ptr %ops_per_sec, align 8
  %call81 = call i32 (ptr, ...) @printf(ptr noundef @.str.7, i32 noundef %48, double noundef %49)
  store i32 0, ptr %retval, align 4
  br label %return

return:                                           ; preds = %for.end80, %if.else23
  %50 = load i32, ptr %retval, align 4
  ret i32 %50
}

declare void @__gmp_randinit_default(ptr noundef) #1

declare void @__gmpz_init(ptr noundef) #1

; Function Attrs: nounwind willreturn memory(read)
declare i32 @atoi(ptr noundef) #2

declare void @__gmpz_urandomb(ptr noundef, ptr noundef, i64 noundef) #1

declare i32 @fprintf(ptr noundef, ptr noundef, ...) #1

declare i32 @printf(ptr noundef, ...) #1

declare i32 @fflush(ptr noundef) #1

declare void @__gmpz_mul(ptr noundef, ptr noundef, ptr noundef) #1

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
