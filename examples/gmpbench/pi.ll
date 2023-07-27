; ModuleID = 'pi.c'
source_filename = "pi.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__mpf_struct = type { i32, i32, i64, ptr }
%struct.anon = type { i64, i64, ptr, ptr }
%struct.__mpz_struct = type { i32, i32, ptr }
%struct.sieve_t = type { i64, i64, i64 }
%struct.rusage = type { %struct.timeval, %struct.timeval, %union.anon, %union.anon.0, %union.anon.1, %union.anon.2, %union.anon.3, %union.anon.4, %union.anon.5, %union.anon.6, %union.anon.7, %union.anon.8, %union.anon.9, %union.anon.10, %union.anon.11, %union.anon.12 }
%struct.timeval = type { i64, i64 }
%union.anon = type { i64 }
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

@t1 = dso_local global [1 x %struct.__mpf_struct] zeroinitializer, align 16
@t2 = dso_local global [1 x %struct.__mpf_struct] zeroinitializer, align 16
@.str = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"%ld^%ld \00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@fmul = dso_local global [1 x %struct.anon] zeroinitializer, align 16
@.str.3 = private unnamed_addr constant [20 x i8] c"k <= fmul->max_facs\00", align 1
@.str.4 = private unnamed_addr constant [5 x i8] c"pi.c\00", align 1
@__PRETTY_FUNCTION__.fac_remove_gcd = private unnamed_addr constant [134 x i8] c"void fac_remove_gcd(__mpz_struct *, struct (unnamed struct at pi.c:169:9) *, __mpz_struct *, struct (unnamed struct at pi.c:169:9) *)\00", align 1
@gcd = dso_local global [1 x %struct.__mpz_struct] zeroinitializer, align 16
@top = dso_local global i64 0, align 8
@pstack = dso_local global ptr null, align 8
@gstack = dso_local global ptr null, align 8
@qstack = dso_local global ptr null, align 8
@fpstack = dso_local global ptr null, align 8
@fgstack = dso_local global ptr null, align 8
@sieve_size = dso_local global i64 0, align 8
@sieve = dso_local global ptr null, align 8
@ftmp = dso_local global [1 x %struct.anon] zeroinitializer, align 16
@.str.5 = private unnamed_addr constant [12 x i8] c"pi(0,%ld)=\0A\00", align 1
@stdout = external global ptr, align 8
@stderr = external global ptr, align 8
@.str.6 = private unnamed_addr constant [13 x i8] c"usage: %s n\0A\00", align 1
@.str.7 = private unnamed_addr constant [38 x i8] c"  where n is the number of pi digits\0A\00", align 1
@.str.8 = private unnamed_addr constant [25 x i8] c"Calibrating CPU speed...\00", align 1
@.str.9 = private unnamed_addr constant [6 x i8] c"done\0A\00", align 1
@.str.10 = private unnamed_addr constant [37 x i8] c"Computing %lu pi digits %lu times...\00", align 1
@.str.11 = private unnamed_addr constant [7 x i8] c"done!\0A\00", align 1
@.str.12 = private unnamed_addr constant [36 x i8] c"RESULT: %.*f operations per second\0A\00", align 1
@mgcd = dso_local global [1 x %struct.__mpz_struct] zeroinitializer, align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @my_sqrt_ui(ptr noundef %r, i64 noundef %x) #0 {
entry:
  %r.addr = alloca ptr, align 8
  %x.addr = alloca i64, align 8
  %prec = alloca i64, align 8
  %bits = alloca i64, align 8
  %prec0 = alloca i64, align 8
  %bit = alloca i32, align 4
  store ptr %r, ptr %r.addr, align 8
  store i64 %x, ptr %x.addr, align 8
  %0 = load ptr, ptr %r.addr, align 8
  %call = call i64 @__gmpf_get_prec(ptr noundef %0) #8
  store i64 %call, ptr %prec0, align 8
  %1 = load i64, ptr %prec0, align 8
  %cmp = icmp ule i64 %1, 53
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load ptr, ptr %r.addr, align 8
  %3 = load i64, ptr %x.addr, align 8
  %conv = uitofp i64 %3 to double
  %call1 = call double @sqrt(double noundef %conv) #9
  call void @__gmpf_set_d(ptr noundef %2, double noundef %call1)
  br label %return

if.end:                                           ; preds = %entry
  store i64 0, ptr %bits, align 8
  %4 = load i64, ptr %prec0, align 8
  store i64 %4, ptr %prec, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.body, %if.end
  %5 = load i64, ptr %prec, align 8
  %cmp2 = icmp ugt i64 %5, 53
  br i1 %cmp2, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = load i64, ptr %prec, align 8
  %and = and i64 %6, 1
  %conv4 = trunc i64 %and to i32
  store i32 %conv4, ptr %bit, align 4
  %7 = load i64, ptr %prec, align 8
  %8 = load i32, ptr %bit, align 4
  %conv5 = sext i32 %8 to i64
  %add = add i64 %7, %conv5
  %div = udiv i64 %add, 2
  store i64 %div, ptr %prec, align 8
  %9 = load i64, ptr %bits, align 8
  %mul = mul i64 %9, 2
  %10 = load i32, ptr %bit, align 4
  %conv6 = sext i32 %10 to i64
  %add7 = add i64 %mul, %conv6
  store i64 %add7, ptr %bits, align 8
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  call void @__gmpf_set_prec_raw(ptr noundef @t1, i64 noundef 53)
  %11 = load i64, ptr %x.addr, align 8
  %conv8 = uitofp i64 %11 to double
  %call9 = call double @sqrt(double noundef %conv8) #9
  %div10 = fdiv double 1.000000e+00, %call9
  call void @__gmpf_set_d(ptr noundef @t1, double noundef %div10)
  br label %while.cond

while.cond:                                       ; preds = %if.end18, %for.end
  %12 = load i64, ptr %prec, align 8
  %13 = load i64, ptr %prec0, align 8
  %cmp11 = icmp ult i64 %12, %13
  br i1 %cmp11, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %14 = load i64, ptr %prec, align 8
  %mul13 = mul i64 %14, 2
  store i64 %mul13, ptr %prec, align 8
  %15 = load i64, ptr %prec, align 8
  %16 = load i64, ptr %prec0, align 8
  %cmp14 = icmp ult i64 %15, %16
  br i1 %cmp14, label %if.then16, label %if.else

if.then16:                                        ; preds = %while.body
  %17 = load i64, ptr %prec, align 8
  call void @__gmpf_set_prec_raw(ptr noundef @t2, i64 noundef %17)
  call void @__gmpf_mul(ptr noundef @t2, ptr noundef @t1, ptr noundef @t1)
  %18 = load i64, ptr %x.addr, align 8
  call void @__gmpf_mul_ui(ptr noundef @t2, ptr noundef @t2, i64 noundef %18)
  call void @__gmpf_ui_sub(ptr noundef @t2, i64 noundef 1, ptr noundef @t2)
  %19 = load i64, ptr %prec, align 8
  %div17 = udiv i64 %19, 2
  call void @__gmpf_set_prec_raw(ptr noundef @t2, i64 noundef %div17)
  call void @__gmpf_div_2exp(ptr noundef @t2, ptr noundef @t2, i64 noundef 1)
  call void @__gmpf_mul(ptr noundef @t2, ptr noundef @t2, ptr noundef @t1)
  %20 = load i64, ptr %prec, align 8
  call void @__gmpf_set_prec_raw(ptr noundef @t1, i64 noundef %20)
  call void @__gmpf_add(ptr noundef @t1, ptr noundef @t1, ptr noundef @t2)
  br label %if.end18

if.else:                                          ; preds = %while.body
  br label %while.end

if.end18:                                         ; preds = %if.then16
  %21 = load i64, ptr %bits, align 8
  %and19 = and i64 %21, 1
  %22 = load i64, ptr %prec, align 8
  %sub = sub i64 %22, %and19
  store i64 %sub, ptr %prec, align 8
  %23 = load i64, ptr %bits, align 8
  %div20 = udiv i64 %23, 2
  store i64 %div20, ptr %bits, align 8
  br label %while.cond, !llvm.loop !8

while.end:                                        ; preds = %if.else, %while.cond
  %24 = load i64, ptr %prec0, align 8
  %div21 = udiv i64 %24, 2
  call void @__gmpf_set_prec_raw(ptr noundef @t2, i64 noundef %div21)
  %25 = load i64, ptr %x.addr, align 8
  call void @__gmpf_mul_ui(ptr noundef @t2, ptr noundef @t1, i64 noundef %25)
  %26 = load ptr, ptr %r.addr, align 8
  call void @__gmpf_mul(ptr noundef %26, ptr noundef @t2, ptr noundef @t2)
  %27 = load ptr, ptr %r.addr, align 8
  %28 = load i64, ptr %x.addr, align 8
  %29 = load ptr, ptr %r.addr, align 8
  call void @__gmpf_ui_sub(ptr noundef %27, i64 noundef %28, ptr noundef %29)
  %30 = load ptr, ptr %r.addr, align 8
  call void @__gmpf_mul(ptr noundef @t1, ptr noundef @t1, ptr noundef %30)
  call void @__gmpf_div_2exp(ptr noundef @t1, ptr noundef @t1, i64 noundef 1)
  %31 = load ptr, ptr %r.addr, align 8
  call void @__gmpf_add(ptr noundef %31, ptr noundef @t1, ptr noundef @t2)
  br label %return

return:                                           ; preds = %while.end, %if.then
  ret void
}

; Function Attrs: nounwind willreturn memory(read)
declare i64 @__gmpf_get_prec(ptr noundef) #1

declare void @__gmpf_set_d(ptr noundef, double noundef) #2

; Function Attrs: nounwind
declare double @sqrt(double noundef) #3

declare void @__gmpf_set_prec_raw(ptr noundef, i64 noundef) #2

declare void @__gmpf_mul(ptr noundef, ptr noundef, ptr noundef) #2

declare void @__gmpf_mul_ui(ptr noundef, ptr noundef, i64 noundef) #2

declare void @__gmpf_ui_sub(ptr noundef, i64 noundef, ptr noundef) #2

declare void @__gmpf_div_2exp(ptr noundef, ptr noundef, i64 noundef) #2

declare void @__gmpf_add(ptr noundef, ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @my_div(ptr noundef %r, ptr noundef %y, ptr noundef %x) #0 {
entry:
  %r.addr = alloca ptr, align 8
  %y.addr = alloca ptr, align 8
  %x.addr = alloca ptr, align 8
  %prec = alloca i64, align 8
  %bits = alloca i64, align 8
  %prec0 = alloca i64, align 8
  %bit = alloca i32, align 4
  store ptr %r, ptr %r.addr, align 8
  store ptr %y, ptr %y.addr, align 8
  store ptr %x, ptr %x.addr, align 8
  %0 = load ptr, ptr %r.addr, align 8
  %call = call i64 @__gmpf_get_prec(ptr noundef %0) #8
  store i64 %call, ptr %prec0, align 8
  %1 = load i64, ptr %prec0, align 8
  %cmp = icmp ule i64 %1, 53
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load ptr, ptr %r.addr, align 8
  %3 = load ptr, ptr %y.addr, align 8
  %call1 = call double @__gmpf_get_d(ptr noundef %3) #8
  %4 = load ptr, ptr %x.addr, align 8
  %call2 = call double @__gmpf_get_d(ptr noundef %4) #8
  %div = fdiv double %call1, %call2
  call void @__gmpf_set_d(ptr noundef %2, double noundef %div)
  br label %while.end

if.end:                                           ; preds = %entry
  store i64 0, ptr %bits, align 8
  %5 = load i64, ptr %prec0, align 8
  store i64 %5, ptr %prec, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.body, %if.end
  %6 = load i64, ptr %prec, align 8
  %cmp3 = icmp ugt i64 %6, 53
  br i1 %cmp3, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %7 = load i64, ptr %prec, align 8
  %and = and i64 %7, 1
  %conv = trunc i64 %and to i32
  store i32 %conv, ptr %bit, align 4
  %8 = load i64, ptr %prec, align 8
  %9 = load i32, ptr %bit, align 4
  %conv4 = sext i32 %9 to i64
  %add = add i64 %8, %conv4
  %div5 = udiv i64 %add, 2
  store i64 %div5, ptr %prec, align 8
  %10 = load i64, ptr %bits, align 8
  %mul = mul i64 %10, 2
  %11 = load i32, ptr %bit, align 4
  %conv6 = sext i32 %11 to i64
  %add7 = add i64 %mul, %conv6
  store i64 %add7, ptr %bits, align 8
  br label %for.cond, !llvm.loop !9

for.end:                                          ; preds = %for.cond
  call void @__gmpf_set_prec_raw(ptr noundef @t1, i64 noundef 53)
  %12 = load ptr, ptr %x.addr, align 8
  call void @__gmpf_ui_div(ptr noundef @t1, i64 noundef 1, ptr noundef %12)
  br label %while.cond

while.cond:                                       ; preds = %if.end16, %for.end
  %13 = load i64, ptr %prec, align 8
  %14 = load i64, ptr %prec0, align 8
  %cmp8 = icmp ult i64 %13, %14
  br i1 %cmp8, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %15 = load i64, ptr %prec, align 8
  %mul10 = mul i64 %15, 2
  store i64 %mul10, ptr %prec, align 8
  %16 = load i64, ptr %prec, align 8
  %17 = load i64, ptr %prec0, align 8
  %cmp11 = icmp ult i64 %16, %17
  br i1 %cmp11, label %if.then13, label %if.else

if.then13:                                        ; preds = %while.body
  %18 = load i64, ptr %prec, align 8
  call void @__gmpf_set_prec_raw(ptr noundef @t2, i64 noundef %18)
  %19 = load ptr, ptr %x.addr, align 8
  call void @__gmpf_mul(ptr noundef @t2, ptr noundef %19, ptr noundef @t1)
  call void @__gmpf_ui_sub(ptr noundef @t2, i64 noundef 1, ptr noundef @t2)
  %20 = load i64, ptr %prec, align 8
  %div14 = udiv i64 %20, 2
  call void @__gmpf_set_prec_raw(ptr noundef @t2, i64 noundef %div14)
  call void @__gmpf_mul(ptr noundef @t2, ptr noundef @t2, ptr noundef @t1)
  %21 = load i64, ptr %prec, align 8
  call void @__gmpf_set_prec_raw(ptr noundef @t1, i64 noundef %21)
  call void @__gmpf_add(ptr noundef @t1, ptr noundef @t1, ptr noundef @t2)
  br label %if.end16

if.else:                                          ; preds = %while.body
  %22 = load i64, ptr %prec0, align 8
  store i64 %22, ptr %prec, align 8
  %23 = load i64, ptr %prec, align 8
  %div15 = udiv i64 %23, 2
  call void @__gmpf_set_prec_raw(ptr noundef @t2, i64 noundef %div15)
  %24 = load ptr, ptr %y.addr, align 8
  call void @__gmpf_mul(ptr noundef @t2, ptr noundef @t1, ptr noundef %24)
  %25 = load ptr, ptr %r.addr, align 8
  %26 = load ptr, ptr %x.addr, align 8
  call void @__gmpf_mul(ptr noundef %25, ptr noundef %26, ptr noundef @t2)
  %27 = load ptr, ptr %r.addr, align 8
  %28 = load ptr, ptr %y.addr, align 8
  %29 = load ptr, ptr %r.addr, align 8
  call void @__gmpf_sub(ptr noundef %27, ptr noundef %28, ptr noundef %29)
  %30 = load ptr, ptr %r.addr, align 8
  call void @__gmpf_mul(ptr noundef @t1, ptr noundef @t1, ptr noundef %30)
  %31 = load ptr, ptr %r.addr, align 8
  call void @__gmpf_add(ptr noundef %31, ptr noundef @t1, ptr noundef @t2)
  br label %while.end

if.end16:                                         ; preds = %if.then13
  %32 = load i64, ptr %bits, align 8
  %and17 = and i64 %32, 1
  %33 = load i64, ptr %prec, align 8
  %sub = sub i64 %33, %and17
  store i64 %sub, ptr %prec, align 8
  %34 = load i64, ptr %bits, align 8
  %div18 = udiv i64 %34, 2
  store i64 %div18, ptr %bits, align 8
  br label %while.cond, !llvm.loop !10

while.end:                                        ; preds = %if.then, %if.else, %while.cond
  ret void
}

; Function Attrs: nounwind willreturn memory(read)
declare double @__gmpf_get_d(ptr noundef) #1

declare void @__gmpf_ui_div(ptr noundef, i64 noundef, ptr noundef) #2

declare void @__gmpf_sub(ptr noundef, ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @fac_show(ptr noundef %f) #0 {
entry:
  %f.addr = alloca ptr, align 8
  %i = alloca i64, align 8
  store ptr %f, ptr %f.addr, align 8
  store i64 0, ptr %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i64, ptr %i, align 8
  %1 = load ptr, ptr %f.addr, align 8
  %arrayidx = getelementptr inbounds %struct.anon, ptr %1, i64 0
  %num_facs = getelementptr inbounds %struct.anon, ptr %arrayidx, i32 0, i32 1
  %2 = load i64, ptr %num_facs, align 8
  %cmp = icmp ult i64 %0, %2
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %3 = load ptr, ptr %f.addr, align 8
  %arrayidx1 = getelementptr inbounds %struct.anon, ptr %3, i64 0
  %pow = getelementptr inbounds %struct.anon, ptr %arrayidx1, i32 0, i32 3
  %4 = load ptr, ptr %pow, align 8
  %5 = load i64, ptr %i, align 8
  %arrayidx2 = getelementptr inbounds i64, ptr %4, i64 %5
  %6 = load i64, ptr %arrayidx2, align 8
  %cmp3 = icmp eq i64 %6, 1
  br i1 %cmp3, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %7 = load ptr, ptr %f.addr, align 8
  %arrayidx4 = getelementptr inbounds %struct.anon, ptr %7, i64 0
  %fac = getelementptr inbounds %struct.anon, ptr %arrayidx4, i32 0, i32 2
  %8 = load ptr, ptr %fac, align 8
  %9 = load i64, ptr %i, align 8
  %arrayidx5 = getelementptr inbounds i64, ptr %8, i64 %9
  %10 = load i64, ptr %arrayidx5, align 8
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %10)
  br label %if.end

if.else:                                          ; preds = %for.body
  %11 = load ptr, ptr %f.addr, align 8
  %arrayidx6 = getelementptr inbounds %struct.anon, ptr %11, i64 0
  %fac7 = getelementptr inbounds %struct.anon, ptr %arrayidx6, i32 0, i32 2
  %12 = load ptr, ptr %fac7, align 8
  %13 = load i64, ptr %i, align 8
  %arrayidx8 = getelementptr inbounds i64, ptr %12, i64 %13
  %14 = load i64, ptr %arrayidx8, align 8
  %15 = load ptr, ptr %f.addr, align 8
  %arrayidx9 = getelementptr inbounds %struct.anon, ptr %15, i64 0
  %pow10 = getelementptr inbounds %struct.anon, ptr %arrayidx9, i32 0, i32 3
  %16 = load ptr, ptr %pow10, align 8
  %17 = load i64, ptr %i, align 8
  %arrayidx11 = getelementptr inbounds i64, ptr %16, i64 %17
  %18 = load i64, ptr %arrayidx11, align 8
  %call12 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i64 noundef %14, i64 noundef %18)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %19 = load i64, ptr %i, align 8
  %inc = add nsw i64 %19, 1
  store i64 %inc, ptr %i, align 8
  br label %for.cond, !llvm.loop !11

for.end:                                          ; preds = %for.cond
  %call13 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  ret void
}

declare i32 @printf(ptr noundef, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @bs_mul(ptr noundef %r, i64 noundef %a, i64 noundef %b) #0 {
entry:
  %r.addr = alloca ptr, align 8
  %a.addr = alloca i64, align 8
  %b.addr = alloca i64, align 8
  %i = alloca i64, align 8
  %j = alloca i64, align 8
  %r2 = alloca [1 x %struct.__mpz_struct], align 16
  store ptr %r, ptr %r.addr, align 8
  store i64 %a, ptr %a.addr, align 8
  store i64 %b, ptr %b.addr, align 8
  %0 = load i64, ptr %b.addr, align 8
  %1 = load i64, ptr %a.addr, align 8
  %sub = sub nsw i64 %0, %1
  %cmp = icmp sle i64 %sub, 32
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %2 = load ptr, ptr %r.addr, align 8
  call void @__gmpz_set_ui(ptr noundef %2, i64 noundef 1)
  %3 = load i64, ptr %a.addr, align 8
  store i64 %3, ptr %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc6, %if.then
  %4 = load i64, ptr %i, align 8
  %5 = load i64, ptr %b.addr, align 8
  %cmp1 = icmp slt i64 %4, %5
  br i1 %cmp1, label %for.body, label %for.end8

for.body:                                         ; preds = %for.cond
  store i64 0, ptr %j, align 8
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc, %for.body
  %6 = load i64, ptr %j, align 8
  %7 = load ptr, ptr getelementptr inbounds (%struct.anon, ptr @fmul, i32 0, i32 3), align 8
  %8 = load i64, ptr %i, align 8
  %arrayidx = getelementptr inbounds i64, ptr %7, i64 %8
  %9 = load i64, ptr %arrayidx, align 8
  %cmp3 = icmp ult i64 %6, %9
  br i1 %cmp3, label %for.body4, label %for.end

for.body4:                                        ; preds = %for.cond2
  %10 = load ptr, ptr %r.addr, align 8
  %11 = load ptr, ptr %r.addr, align 8
  %12 = load ptr, ptr getelementptr inbounds (%struct.anon, ptr @fmul, i32 0, i32 2), align 16
  %13 = load i64, ptr %i, align 8
  %arrayidx5 = getelementptr inbounds i64, ptr %12, i64 %13
  %14 = load i64, ptr %arrayidx5, align 8
  call void @__gmpz_mul_ui(ptr noundef %10, ptr noundef %11, i64 noundef %14)
  br label %for.inc

for.inc:                                          ; preds = %for.body4
  %15 = load i64, ptr %j, align 8
  %inc = add nsw i64 %15, 1
  store i64 %inc, ptr %j, align 8
  br label %for.cond2, !llvm.loop !12

for.end:                                          ; preds = %for.cond2
  br label %for.inc6

for.inc6:                                         ; preds = %for.end
  %16 = load i64, ptr %i, align 8
  %inc7 = add nsw i64 %16, 1
  store i64 %inc7, ptr %i, align 8
  br label %for.cond, !llvm.loop !13

for.end8:                                         ; preds = %for.cond
  br label %if.end

if.else:                                          ; preds = %entry
  %arraydecay = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %r2, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay)
  %arraydecay9 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %r2, i64 0, i64 0
  %17 = load i64, ptr %a.addr, align 8
  %18 = load i64, ptr %a.addr, align 8
  %19 = load i64, ptr %b.addr, align 8
  %add = add nsw i64 %18, %19
  %div = sdiv i64 %add, 2
  call void @bs_mul(ptr noundef %arraydecay9, i64 noundef %17, i64 noundef %div)
  %20 = load ptr, ptr %r.addr, align 8
  %21 = load i64, ptr %a.addr, align 8
  %22 = load i64, ptr %b.addr, align 8
  %add10 = add nsw i64 %21, %22
  %div11 = sdiv i64 %add10, 2
  %23 = load i64, ptr %b.addr, align 8
  call void @bs_mul(ptr noundef %20, i64 noundef %div11, i64 noundef %23)
  %24 = load ptr, ptr %r.addr, align 8
  %25 = load ptr, ptr %r.addr, align 8
  %arraydecay12 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %r2, i64 0, i64 0
  call void @__gmpz_mul(ptr noundef %24, ptr noundef %25, ptr noundef %arraydecay12)
  %arraydecay13 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %r2, i64 0, i64 0
  call void @__gmpz_clear(ptr noundef %arraydecay13)
  br label %if.end

if.end:                                           ; preds = %if.else, %for.end8
  ret void
}

declare void @__gmpz_set_ui(ptr noundef, i64 noundef) #2

declare void @__gmpz_mul_ui(ptr noundef, ptr noundef, i64 noundef) #2

declare void @__gmpz_init(ptr noundef) #2

declare void @__gmpz_mul(ptr noundef, ptr noundef, ptr noundef) #2

declare void @__gmpz_clear(ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @fac_remove_gcd(ptr noundef %p, ptr noundef %fp, ptr noundef %g, ptr noundef %fg) #0 {
entry:
  %p.addr = alloca ptr, align 8
  %fp.addr = alloca ptr, align 8
  %g.addr = alloca ptr, align 8
  %fg.addr = alloca ptr, align 8
  %i = alloca i64, align 8
  %j = alloca i64, align 8
  %k = alloca i64, align 8
  %c = alloca i64, align 8
  store ptr %p, ptr %p.addr, align 8
  store ptr %fp, ptr %fp.addr, align 8
  store ptr %g, ptr %g.addr, align 8
  store ptr %fg, ptr %fg.addr, align 8
  %0 = load ptr, ptr %fp.addr, align 8
  %num_facs = getelementptr inbounds %struct.anon, ptr %0, i32 0, i32 1
  %1 = load i64, ptr %num_facs, align 8
  %2 = load ptr, ptr %fg.addr, align 8
  %num_facs1 = getelementptr inbounds %struct.anon, ptr %2, i32 0, i32 1
  %3 = load i64, ptr %num_facs1, align 8
  %cmp = icmp ult i64 %1, %3
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %4 = load ptr, ptr %fp.addr, align 8
  %num_facs2 = getelementptr inbounds %struct.anon, ptr %4, i32 0, i32 1
  %5 = load i64, ptr %num_facs2, align 8
  br label %cond.end

cond.false:                                       ; preds = %entry
  %6 = load ptr, ptr %fg.addr, align 8
  %num_facs3 = getelementptr inbounds %struct.anon, ptr %6, i32 0, i32 1
  %7 = load i64, ptr %num_facs3, align 8
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i64 [ %5, %cond.true ], [ %7, %cond.false ]
  call void @fac_resize(ptr noundef @fmul, i64 noundef %cond)
  store i64 0, ptr %k, align 8
  store i64 0, ptr %j, align 8
  store i64 0, ptr %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %if.end43, %cond.end
  %8 = load i64, ptr %i, align 8
  %9 = load ptr, ptr %fp.addr, align 8
  %num_facs4 = getelementptr inbounds %struct.anon, ptr %9, i32 0, i32 1
  %10 = load i64, ptr %num_facs4, align 8
  %cmp5 = icmp ult i64 %8, %10
  br i1 %cmp5, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %for.cond
  %11 = load i64, ptr %j, align 8
  %12 = load ptr, ptr %fg.addr, align 8
  %num_facs6 = getelementptr inbounds %struct.anon, ptr %12, i32 0, i32 1
  %13 = load i64, ptr %num_facs6, align 8
  %cmp7 = icmp ult i64 %11, %13
  br label %land.end

land.end:                                         ; preds = %land.rhs, %for.cond
  %14 = phi i1 [ false, %for.cond ], [ %cmp7, %land.rhs ]
  br i1 %14, label %for.body, label %for.end

for.body:                                         ; preds = %land.end
  %15 = load ptr, ptr %fp.addr, align 8
  %fac = getelementptr inbounds %struct.anon, ptr %15, i32 0, i32 2
  %16 = load ptr, ptr %fac, align 8
  %17 = load i64, ptr %i, align 8
  %arrayidx = getelementptr inbounds i64, ptr %16, i64 %17
  %18 = load i64, ptr %arrayidx, align 8
  %19 = load ptr, ptr %fg.addr, align 8
  %fac8 = getelementptr inbounds %struct.anon, ptr %19, i32 0, i32 2
  %20 = load ptr, ptr %fac8, align 8
  %21 = load i64, ptr %j, align 8
  %arrayidx9 = getelementptr inbounds i64, ptr %20, i64 %21
  %22 = load i64, ptr %arrayidx9, align 8
  %cmp10 = icmp eq i64 %18, %22
  br i1 %cmp10, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %23 = load ptr, ptr %fp.addr, align 8
  %pow = getelementptr inbounds %struct.anon, ptr %23, i32 0, i32 3
  %24 = load ptr, ptr %pow, align 8
  %25 = load i64, ptr %i, align 8
  %arrayidx11 = getelementptr inbounds i64, ptr %24, i64 %25
  %26 = load i64, ptr %arrayidx11, align 8
  %27 = load ptr, ptr %fg.addr, align 8
  %pow12 = getelementptr inbounds %struct.anon, ptr %27, i32 0, i32 3
  %28 = load ptr, ptr %pow12, align 8
  %29 = load i64, ptr %j, align 8
  %arrayidx13 = getelementptr inbounds i64, ptr %28, i64 %29
  %30 = load i64, ptr %arrayidx13, align 8
  %cmp14 = icmp ult i64 %26, %30
  br i1 %cmp14, label %cond.true15, label %cond.false18

cond.true15:                                      ; preds = %if.then
  %31 = load ptr, ptr %fp.addr, align 8
  %pow16 = getelementptr inbounds %struct.anon, ptr %31, i32 0, i32 3
  %32 = load ptr, ptr %pow16, align 8
  %33 = load i64, ptr %i, align 8
  %arrayidx17 = getelementptr inbounds i64, ptr %32, i64 %33
  %34 = load i64, ptr %arrayidx17, align 8
  br label %cond.end21

cond.false18:                                     ; preds = %if.then
  %35 = load ptr, ptr %fg.addr, align 8
  %pow19 = getelementptr inbounds %struct.anon, ptr %35, i32 0, i32 3
  %36 = load ptr, ptr %pow19, align 8
  %37 = load i64, ptr %j, align 8
  %arrayidx20 = getelementptr inbounds i64, ptr %36, i64 %37
  %38 = load i64, ptr %arrayidx20, align 8
  br label %cond.end21

cond.end21:                                       ; preds = %cond.false18, %cond.true15
  %cond22 = phi i64 [ %34, %cond.true15 ], [ %38, %cond.false18 ]
  store i64 %cond22, ptr %c, align 8
  %39 = load i64, ptr %c, align 8
  %40 = load ptr, ptr %fp.addr, align 8
  %pow23 = getelementptr inbounds %struct.anon, ptr %40, i32 0, i32 3
  %41 = load ptr, ptr %pow23, align 8
  %42 = load i64, ptr %i, align 8
  %arrayidx24 = getelementptr inbounds i64, ptr %41, i64 %42
  %43 = load i64, ptr %arrayidx24, align 8
  %sub = sub i64 %43, %39
  store i64 %sub, ptr %arrayidx24, align 8
  %44 = load i64, ptr %c, align 8
  %45 = load ptr, ptr %fg.addr, align 8
  %pow25 = getelementptr inbounds %struct.anon, ptr %45, i32 0, i32 3
  %46 = load ptr, ptr %pow25, align 8
  %47 = load i64, ptr %j, align 8
  %arrayidx26 = getelementptr inbounds i64, ptr %46, i64 %47
  %48 = load i64, ptr %arrayidx26, align 8
  %sub27 = sub i64 %48, %44
  store i64 %sub27, ptr %arrayidx26, align 8
  %49 = load ptr, ptr %fp.addr, align 8
  %fac28 = getelementptr inbounds %struct.anon, ptr %49, i32 0, i32 2
  %50 = load ptr, ptr %fac28, align 8
  %51 = load i64, ptr %i, align 8
  %arrayidx29 = getelementptr inbounds i64, ptr %50, i64 %51
  %52 = load i64, ptr %arrayidx29, align 8
  %53 = load ptr, ptr getelementptr inbounds (%struct.anon, ptr @fmul, i32 0, i32 2), align 16
  %54 = load i64, ptr %k, align 8
  %arrayidx30 = getelementptr inbounds i64, ptr %53, i64 %54
  store i64 %52, ptr %arrayidx30, align 8
  %55 = load i64, ptr %c, align 8
  %56 = load ptr, ptr getelementptr inbounds (%struct.anon, ptr @fmul, i32 0, i32 3), align 8
  %57 = load i64, ptr %k, align 8
  %arrayidx31 = getelementptr inbounds i64, ptr %56, i64 %57
  store i64 %55, ptr %arrayidx31, align 8
  %58 = load i64, ptr %i, align 8
  %inc = add nsw i64 %58, 1
  store i64 %inc, ptr %i, align 8
  %59 = load i64, ptr %j, align 8
  %inc32 = add nsw i64 %59, 1
  store i64 %inc32, ptr %j, align 8
  %60 = load i64, ptr %k, align 8
  %inc33 = add nsw i64 %60, 1
  store i64 %inc33, ptr %k, align 8
  br label %if.end43

if.else:                                          ; preds = %for.body
  %61 = load ptr, ptr %fp.addr, align 8
  %fac34 = getelementptr inbounds %struct.anon, ptr %61, i32 0, i32 2
  %62 = load ptr, ptr %fac34, align 8
  %63 = load i64, ptr %i, align 8
  %arrayidx35 = getelementptr inbounds i64, ptr %62, i64 %63
  %64 = load i64, ptr %arrayidx35, align 8
  %65 = load ptr, ptr %fg.addr, align 8
  %fac36 = getelementptr inbounds %struct.anon, ptr %65, i32 0, i32 2
  %66 = load ptr, ptr %fac36, align 8
  %67 = load i64, ptr %j, align 8
  %arrayidx37 = getelementptr inbounds i64, ptr %66, i64 %67
  %68 = load i64, ptr %arrayidx37, align 8
  %cmp38 = icmp ult i64 %64, %68
  br i1 %cmp38, label %if.then39, label %if.else41

if.then39:                                        ; preds = %if.else
  %69 = load i64, ptr %i, align 8
  %inc40 = add nsw i64 %69, 1
  store i64 %inc40, ptr %i, align 8
  br label %if.end

if.else41:                                        ; preds = %if.else
  %70 = load i64, ptr %j, align 8
  %inc42 = add nsw i64 %70, 1
  store i64 %inc42, ptr %j, align 8
  br label %if.end

if.end:                                           ; preds = %if.else41, %if.then39
  br label %if.end43

if.end43:                                         ; preds = %if.end, %cond.end21
  br label %for.cond, !llvm.loop !14

for.end:                                          ; preds = %land.end
  %71 = load i64, ptr %k, align 8
  store i64 %71, ptr getelementptr inbounds (%struct.anon, ptr @fmul, i32 0, i32 1), align 8
  %72 = load i64, ptr %k, align 8
  %73 = load i64, ptr @fmul, align 16
  %cmp44 = icmp ule i64 %72, %73
  br i1 %cmp44, label %if.then45, label %if.else46

if.then45:                                        ; preds = %for.end
  br label %if.end47

if.else46:                                        ; preds = %for.end
  call void @__assert_fail(ptr noundef @.str.3, ptr noundef @.str.4, i32 noundef 367, ptr noundef @__PRETTY_FUNCTION__.fac_remove_gcd) #10
  unreachable

if.end47:                                         ; preds = %if.then45
  %74 = load i64, ptr getelementptr inbounds (%struct.anon, ptr @fmul, i32 0, i32 1), align 8
  %tobool = icmp ne i64 %74, 0
  br i1 %tobool, label %if.then48, label %if.end49

if.then48:                                        ; preds = %if.end47
  %75 = load i64, ptr getelementptr inbounds (%struct.anon, ptr @fmul, i32 0, i32 1), align 8
  call void @bs_mul(ptr noundef @gcd, i64 noundef 0, i64 noundef %75)
  %76 = load ptr, ptr %p.addr, align 8
  %77 = load ptr, ptr %p.addr, align 8
  call void @__gmpz_tdiv_q(ptr noundef %76, ptr noundef %77, ptr noundef @gcd)
  %78 = load ptr, ptr %g.addr, align 8
  %79 = load ptr, ptr %g.addr, align 8
  call void @__gmpz_tdiv_q(ptr noundef %78, ptr noundef %79, ptr noundef @gcd)
  %80 = load ptr, ptr %fp.addr, align 8
  call void @fac_compact(ptr noundef %80)
  %81 = load ptr, ptr %fg.addr, align 8
  call void @fac_compact(ptr noundef %81)
  br label %if.end49

if.end49:                                         ; preds = %if.then48, %if.end47
  ret void
}

declare void @fac_resize(ptr noundef, i64 noundef) #2

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #4

declare void @__gmpz_tdiv_q(ptr noundef, ptr noundef, ptr noundef) #2

declare void @fac_compact(ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @bs(i64 noundef %a, i64 noundef %b, i32 noundef %gflag, i64 noundef %level) #0 {
entry:
  %a.addr = alloca i64, align 8
  %b.addr = alloca i64, align 8
  %gflag.addr = alloca i32, align 4
  %level.addr = alloca i64, align 8
  %i = alloca i64, align 8
  %mid = alloca i64, align 8
  store i64 %a, ptr %a.addr, align 8
  store i64 %b, ptr %b.addr, align 8
  store i32 %gflag, ptr %gflag.addr, align 4
  store i64 %level, ptr %level.addr, align 8
  %0 = load i64, ptr %b.addr, align 8
  %1 = load i64, ptr %a.addr, align 8
  %sub = sub i64 %0, %1
  %cmp = icmp eq i64 %sub, 1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %2 = load ptr, ptr @pstack, align 8
  %3 = load i64, ptr @top, align 8
  %arrayidx = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %2, i64 %3
  %arraydecay = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx, i64 0, i64 0
  %4 = load i64, ptr %b.addr, align 8
  call void @__gmpz_set_ui(ptr noundef %arraydecay, i64 noundef %4)
  %5 = load ptr, ptr @pstack, align 8
  %6 = load i64, ptr @top, align 8
  %arrayidx1 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %5, i64 %6
  %arraydecay2 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx1, i64 0, i64 0
  %7 = load ptr, ptr @pstack, align 8
  %8 = load i64, ptr @top, align 8
  %arrayidx3 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %7, i64 %8
  %arraydecay4 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx3, i64 0, i64 0
  %9 = load i64, ptr %b.addr, align 8
  call void @__gmpz_mul_ui(ptr noundef %arraydecay2, ptr noundef %arraydecay4, i64 noundef %9)
  %10 = load ptr, ptr @pstack, align 8
  %11 = load i64, ptr @top, align 8
  %arrayidx5 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %10, i64 %11
  %arraydecay6 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx5, i64 0, i64 0
  %12 = load ptr, ptr @pstack, align 8
  %13 = load i64, ptr @top, align 8
  %arrayidx7 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %12, i64 %13
  %arraydecay8 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx7, i64 0, i64 0
  %14 = load i64, ptr %b.addr, align 8
  call void @__gmpz_mul_ui(ptr noundef %arraydecay6, ptr noundef %arraydecay8, i64 noundef %14)
  %15 = load ptr, ptr @pstack, align 8
  %16 = load i64, ptr @top, align 8
  %arrayidx9 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %15, i64 %16
  %arraydecay10 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx9, i64 0, i64 0
  %17 = load ptr, ptr @pstack, align 8
  %18 = load i64, ptr @top, align 8
  %arrayidx11 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %17, i64 %18
  %arraydecay12 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx11, i64 0, i64 0
  call void @__gmpz_mul_ui(ptr noundef %arraydecay10, ptr noundef %arraydecay12, i64 noundef 711822400)
  %19 = load ptr, ptr @pstack, align 8
  %20 = load i64, ptr @top, align 8
  %arrayidx13 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %19, i64 %20
  %arraydecay14 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx13, i64 0, i64 0
  %21 = load ptr, ptr @pstack, align 8
  %22 = load i64, ptr @top, align 8
  %arrayidx15 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %21, i64 %22
  %arraydecay16 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx15, i64 0, i64 0
  call void @__gmpz_mul_ui(ptr noundef %arraydecay14, ptr noundef %arraydecay16, i64 noundef 15367680)
  %23 = load ptr, ptr @gstack, align 8
  %24 = load i64, ptr @top, align 8
  %arrayidx17 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %23, i64 %24
  %arraydecay18 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx17, i64 0, i64 0
  %25 = load i64, ptr %b.addr, align 8
  %mul = mul i64 2, %25
  %sub19 = sub i64 %mul, 1
  call void @__gmpz_set_ui(ptr noundef %arraydecay18, i64 noundef %sub19)
  %26 = load ptr, ptr @gstack, align 8
  %27 = load i64, ptr @top, align 8
  %arrayidx20 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %26, i64 %27
  %arraydecay21 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx20, i64 0, i64 0
  %28 = load ptr, ptr @gstack, align 8
  %29 = load i64, ptr @top, align 8
  %arrayidx22 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %28, i64 %29
  %arraydecay23 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx22, i64 0, i64 0
  %30 = load i64, ptr %b.addr, align 8
  %mul24 = mul i64 6, %30
  %sub25 = sub i64 %mul24, 1
  call void @__gmpz_mul_ui(ptr noundef %arraydecay21, ptr noundef %arraydecay23, i64 noundef %sub25)
  %31 = load ptr, ptr @gstack, align 8
  %32 = load i64, ptr @top, align 8
  %arrayidx26 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %31, i64 %32
  %arraydecay27 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx26, i64 0, i64 0
  %33 = load ptr, ptr @gstack, align 8
  %34 = load i64, ptr @top, align 8
  %arrayidx28 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %33, i64 %34
  %arraydecay29 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx28, i64 0, i64 0
  %35 = load i64, ptr %b.addr, align 8
  %mul30 = mul i64 6, %35
  %sub31 = sub i64 %mul30, 5
  call void @__gmpz_mul_ui(ptr noundef %arraydecay27, ptr noundef %arraydecay29, i64 noundef %sub31)
  %36 = load ptr, ptr @qstack, align 8
  %37 = load i64, ptr @top, align 8
  %arrayidx32 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %36, i64 %37
  %arraydecay33 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx32, i64 0, i64 0
  %38 = load i64, ptr %b.addr, align 8
  call void @__gmpz_set_ui(ptr noundef %arraydecay33, i64 noundef %38)
  %39 = load ptr, ptr @qstack, align 8
  %40 = load i64, ptr @top, align 8
  %arrayidx34 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %39, i64 %40
  %arraydecay35 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx34, i64 0, i64 0
  %41 = load ptr, ptr @qstack, align 8
  %42 = load i64, ptr @top, align 8
  %arrayidx36 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %41, i64 %42
  %arraydecay37 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx36, i64 0, i64 0
  call void @__gmpz_mul_ui(ptr noundef %arraydecay35, ptr noundef %arraydecay37, i64 noundef 545140134)
  %43 = load ptr, ptr @qstack, align 8
  %44 = load i64, ptr @top, align 8
  %arrayidx38 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %43, i64 %44
  %arraydecay39 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx38, i64 0, i64 0
  %45 = load ptr, ptr @qstack, align 8
  %46 = load i64, ptr @top, align 8
  %arrayidx40 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %45, i64 %46
  %arraydecay41 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx40, i64 0, i64 0
  call void @__gmpz_add_ui(ptr noundef %arraydecay39, ptr noundef %arraydecay41, i64 noundef 13591409)
  %47 = load ptr, ptr @qstack, align 8
  %48 = load i64, ptr @top, align 8
  %arrayidx42 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %47, i64 %48
  %arraydecay43 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx42, i64 0, i64 0
  %49 = load ptr, ptr @qstack, align 8
  %50 = load i64, ptr @top, align 8
  %arrayidx44 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %49, i64 %50
  %arraydecay45 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx44, i64 0, i64 0
  %51 = load ptr, ptr @gstack, align 8
  %52 = load i64, ptr @top, align 8
  %arrayidx46 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %51, i64 %52
  %arraydecay47 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx46, i64 0, i64 0
  call void @__gmpz_mul(ptr noundef %arraydecay43, ptr noundef %arraydecay45, ptr noundef %arraydecay47)
  %53 = load i64, ptr %b.addr, align 8
  %rem = urem i64 %53, 2
  %tobool = icmp ne i64 %rem, 0
  br i1 %tobool, label %if.then48, label %if.end

if.then48:                                        ; preds = %if.then
  %54 = load ptr, ptr @qstack, align 8
  %55 = load i64, ptr @top, align 8
  %arrayidx49 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %54, i64 %55
  %arraydecay50 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx49, i64 0, i64 0
  %56 = load ptr, ptr @qstack, align 8
  %57 = load i64, ptr @top, align 8
  %arrayidx51 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %56, i64 %57
  %arraydecay52 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx51, i64 0, i64 0
  call void @__gmpz_neg(ptr noundef %arraydecay50, ptr noundef %arraydecay52)
  br label %if.end

if.end:                                           ; preds = %if.then48, %if.then
  %58 = load i64, ptr %b.addr, align 8
  store i64 %58, ptr %i, align 8
  br label %while.cond

while.cond:                                       ; preds = %while.body, %if.end
  %59 = load i64, ptr %i, align 8
  %and = and i64 %59, 1
  %cmp53 = icmp eq i64 %and, 0
  br i1 %cmp53, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %60 = load i64, ptr %i, align 8
  %shr = lshr i64 %60, 1
  store i64 %shr, ptr %i, align 8
  br label %while.cond, !llvm.loop !15

while.end:                                        ; preds = %while.cond
  %61 = load ptr, ptr @fpstack, align 8
  %62 = load i64, ptr @top, align 8
  %arrayidx54 = getelementptr inbounds [1 x %struct.anon], ptr %61, i64 %62
  %arraydecay55 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx54, i64 0, i64 0
  %63 = load i64, ptr %i, align 8
  call void @fac_set_bp(ptr noundef %arraydecay55, i64 noundef %63, i64 noundef 3)
  %64 = load ptr, ptr @fpstack, align 8
  %65 = load i64, ptr @top, align 8
  %arrayidx56 = getelementptr inbounds [1 x %struct.anon], ptr %64, i64 %65
  %arraydecay57 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx56, i64 0, i64 0
  call void @fac_mul_bp(ptr noundef %arraydecay57, i64 noundef 10005, i64 noundef 3)
  %66 = load ptr, ptr @fpstack, align 8
  %67 = load i64, ptr @top, align 8
  %arrayidx58 = getelementptr inbounds [1 x %struct.anon], ptr %66, i64 %67
  %arrayidx59 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx58, i64 0, i64 0
  %pow = getelementptr inbounds %struct.anon, ptr %arrayidx59, i32 0, i32 3
  %68 = load ptr, ptr %pow, align 8
  %arrayidx60 = getelementptr inbounds i64, ptr %68, i64 0
  %69 = load i64, ptr %arrayidx60, align 8
  %dec = add i64 %69, -1
  store i64 %dec, ptr %arrayidx60, align 8
  %70 = load ptr, ptr @fgstack, align 8
  %71 = load i64, ptr @top, align 8
  %arrayidx61 = getelementptr inbounds [1 x %struct.anon], ptr %70, i64 %71
  %arraydecay62 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx61, i64 0, i64 0
  %72 = load i64, ptr %b.addr, align 8
  %mul63 = mul i64 2, %72
  %sub64 = sub i64 %mul63, 1
  call void @fac_set_bp(ptr noundef %arraydecay62, i64 noundef %sub64, i64 noundef 1)
  %73 = load ptr, ptr @fgstack, align 8
  %74 = load i64, ptr @top, align 8
  %arrayidx65 = getelementptr inbounds [1 x %struct.anon], ptr %73, i64 %74
  %arraydecay66 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx65, i64 0, i64 0
  %75 = load i64, ptr %b.addr, align 8
  %mul67 = mul i64 6, %75
  %sub68 = sub i64 %mul67, 1
  call void @fac_mul_bp(ptr noundef %arraydecay66, i64 noundef %sub68, i64 noundef 1)
  %76 = load ptr, ptr @fgstack, align 8
  %77 = load i64, ptr @top, align 8
  %arrayidx69 = getelementptr inbounds [1 x %struct.anon], ptr %76, i64 %77
  %arraydecay70 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx69, i64 0, i64 0
  %78 = load i64, ptr %b.addr, align 8
  %mul71 = mul i64 6, %78
  %sub72 = sub i64 %mul71, 5
  call void @fac_mul_bp(ptr noundef %arraydecay70, i64 noundef %sub72, i64 noundef 1)
  br label %if.end142

if.else:                                          ; preds = %entry
  %79 = load i64, ptr %a.addr, align 8
  %conv = uitofp i64 %79 to double
  %80 = load i64, ptr %b.addr, align 8
  %81 = load i64, ptr %a.addr, align 8
  %sub73 = sub i64 %80, %81
  %conv74 = uitofp i64 %sub73 to double
  %82 = call double @llvm.fmuladd.f64(double %conv74, double 5.224000e-01, double %conv)
  %conv76 = fptoui double %82 to i64
  store i64 %conv76, ptr %mid, align 8
  %83 = load i64, ptr %a.addr, align 8
  %84 = load i64, ptr %mid, align 8
  %85 = load i64, ptr %level.addr, align 8
  %add = add nsw i64 %85, 1
  call void @bs(i64 noundef %83, i64 noundef %84, i32 noundef 1, i64 noundef %add)
  %86 = load i64, ptr @top, align 8
  %inc = add nsw i64 %86, 1
  store i64 %inc, ptr @top, align 8
  %87 = load i64, ptr %mid, align 8
  %88 = load i64, ptr %b.addr, align 8
  %89 = load i32, ptr %gflag.addr, align 4
  %90 = load i64, ptr %level.addr, align 8
  %add77 = add nsw i64 %90, 1
  call void @bs(i64 noundef %87, i64 noundef %88, i32 noundef %89, i64 noundef %add77)
  %91 = load i64, ptr @top, align 8
  %dec78 = add nsw i64 %91, -1
  store i64 %dec78, ptr @top, align 8
  %92 = load i64, ptr %level.addr, align 8
  %cmp79 = icmp sge i64 %92, 4
  br i1 %cmp79, label %if.then81, label %if.end92

if.then81:                                        ; preds = %if.else
  %93 = load ptr, ptr @pstack, align 8
  %94 = load i64, ptr @top, align 8
  %add82 = add nsw i64 %94, 1
  %arrayidx83 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %93, i64 %add82
  %arraydecay84 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx83, i64 0, i64 0
  %95 = load ptr, ptr @fpstack, align 8
  %96 = load i64, ptr @top, align 8
  %add85 = add nsw i64 %96, 1
  %arrayidx86 = getelementptr inbounds [1 x %struct.anon], ptr %95, i64 %add85
  %arraydecay87 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx86, i64 0, i64 0
  %97 = load ptr, ptr @gstack, align 8
  %98 = load i64, ptr @top, align 8
  %arrayidx88 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %97, i64 %98
  %arraydecay89 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx88, i64 0, i64 0
  %99 = load ptr, ptr @fgstack, align 8
  %100 = load i64, ptr @top, align 8
  %arrayidx90 = getelementptr inbounds [1 x %struct.anon], ptr %99, i64 %100
  %arraydecay91 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx90, i64 0, i64 0
  call void @fac_remove_gcd(ptr noundef %arraydecay84, ptr noundef %arraydecay87, ptr noundef %arraydecay89, ptr noundef %arraydecay91)
  br label %if.end92

if.end92:                                         ; preds = %if.then81, %if.else
  %101 = load ptr, ptr @pstack, align 8
  %102 = load i64, ptr @top, align 8
  %arrayidx93 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %101, i64 %102
  %arraydecay94 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx93, i64 0, i64 0
  %103 = load ptr, ptr @pstack, align 8
  %104 = load i64, ptr @top, align 8
  %arrayidx95 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %103, i64 %104
  %arraydecay96 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx95, i64 0, i64 0
  %105 = load ptr, ptr @pstack, align 8
  %106 = load i64, ptr @top, align 8
  %add97 = add nsw i64 %106, 1
  %arrayidx98 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %105, i64 %add97
  %arraydecay99 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx98, i64 0, i64 0
  call void @__gmpz_mul(ptr noundef %arraydecay94, ptr noundef %arraydecay96, ptr noundef %arraydecay99)
  %107 = load ptr, ptr @qstack, align 8
  %108 = load i64, ptr @top, align 8
  %arrayidx100 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %107, i64 %108
  %arraydecay101 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx100, i64 0, i64 0
  %109 = load ptr, ptr @qstack, align 8
  %110 = load i64, ptr @top, align 8
  %arrayidx102 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %109, i64 %110
  %arraydecay103 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx102, i64 0, i64 0
  %111 = load ptr, ptr @pstack, align 8
  %112 = load i64, ptr @top, align 8
  %add104 = add nsw i64 %112, 1
  %arrayidx105 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %111, i64 %add104
  %arraydecay106 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx105, i64 0, i64 0
  call void @__gmpz_mul(ptr noundef %arraydecay101, ptr noundef %arraydecay103, ptr noundef %arraydecay106)
  %113 = load ptr, ptr @qstack, align 8
  %114 = load i64, ptr @top, align 8
  %add107 = add nsw i64 %114, 1
  %arrayidx108 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %113, i64 %add107
  %arraydecay109 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx108, i64 0, i64 0
  %115 = load ptr, ptr @qstack, align 8
  %116 = load i64, ptr @top, align 8
  %add110 = add nsw i64 %116, 1
  %arrayidx111 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %115, i64 %add110
  %arraydecay112 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx111, i64 0, i64 0
  %117 = load ptr, ptr @gstack, align 8
  %118 = load i64, ptr @top, align 8
  %arrayidx113 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %117, i64 %118
  %arraydecay114 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx113, i64 0, i64 0
  call void @__gmpz_mul(ptr noundef %arraydecay109, ptr noundef %arraydecay112, ptr noundef %arraydecay114)
  %119 = load ptr, ptr @qstack, align 8
  %120 = load i64, ptr @top, align 8
  %arrayidx115 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %119, i64 %120
  %arraydecay116 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx115, i64 0, i64 0
  %121 = load ptr, ptr @qstack, align 8
  %122 = load i64, ptr @top, align 8
  %arrayidx117 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %121, i64 %122
  %arraydecay118 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx117, i64 0, i64 0
  %123 = load ptr, ptr @qstack, align 8
  %124 = load i64, ptr @top, align 8
  %add119 = add nsw i64 %124, 1
  %arrayidx120 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %123, i64 %add119
  %arraydecay121 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx120, i64 0, i64 0
  call void @__gmpz_add(ptr noundef %arraydecay116, ptr noundef %arraydecay118, ptr noundef %arraydecay121)
  %125 = load ptr, ptr @fpstack, align 8
  %126 = load i64, ptr @top, align 8
  %arrayidx122 = getelementptr inbounds [1 x %struct.anon], ptr %125, i64 %126
  %arraydecay123 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx122, i64 0, i64 0
  %127 = load ptr, ptr @fpstack, align 8
  %128 = load i64, ptr @top, align 8
  %add124 = add nsw i64 %128, 1
  %arrayidx125 = getelementptr inbounds [1 x %struct.anon], ptr %127, i64 %add124
  %arraydecay126 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx125, i64 0, i64 0
  call void @fac_mul(ptr noundef %arraydecay123, ptr noundef %arraydecay126)
  %129 = load i32, ptr %gflag.addr, align 4
  %tobool127 = icmp ne i32 %129, 0
  br i1 %tobool127, label %if.then128, label %if.end141

if.then128:                                       ; preds = %if.end92
  %130 = load ptr, ptr @gstack, align 8
  %131 = load i64, ptr @top, align 8
  %arrayidx129 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %130, i64 %131
  %arraydecay130 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx129, i64 0, i64 0
  %132 = load ptr, ptr @gstack, align 8
  %133 = load i64, ptr @top, align 8
  %arrayidx131 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %132, i64 %133
  %arraydecay132 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx131, i64 0, i64 0
  %134 = load ptr, ptr @gstack, align 8
  %135 = load i64, ptr @top, align 8
  %add133 = add nsw i64 %135, 1
  %arrayidx134 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %134, i64 %add133
  %arraydecay135 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx134, i64 0, i64 0
  call void @__gmpz_mul(ptr noundef %arraydecay130, ptr noundef %arraydecay132, ptr noundef %arraydecay135)
  %136 = load ptr, ptr @fgstack, align 8
  %137 = load i64, ptr @top, align 8
  %arrayidx136 = getelementptr inbounds [1 x %struct.anon], ptr %136, i64 %137
  %arraydecay137 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx136, i64 0, i64 0
  %138 = load ptr, ptr @fgstack, align 8
  %139 = load i64, ptr @top, align 8
  %add138 = add nsw i64 %139, 1
  %arrayidx139 = getelementptr inbounds [1 x %struct.anon], ptr %138, i64 %add138
  %arraydecay140 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx139, i64 0, i64 0
  call void @fac_mul(ptr noundef %arraydecay137, ptr noundef %arraydecay140)
  br label %if.end141

if.end141:                                        ; preds = %if.then128, %if.end92
  br label %if.end142

if.end142:                                        ; preds = %if.end141, %while.end
  ret void
}

declare void @__gmpz_add_ui(ptr noundef, ptr noundef, i64 noundef) #2

declare void @__gmpz_neg(ptr noundef, ptr noundef) #2

declare void @fac_set_bp(ptr noundef, i64 noundef, i64 noundef) #2

declare void @fac_mul_bp(ptr noundef, i64 noundef, i64 noundef) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #5

declare void @__gmpz_add(ptr noundef, ptr noundef, ptr noundef) #2

declare void @fac_mul(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @build_sieve(i64 noundef %n, ptr noundef %s) #0 {
entry:
  %n.addr = alloca i64, align 8
  %s.addr = alloca ptr, align 8
  %m = alloca i64, align 8
  %i = alloca i64, align 8
  %j = alloca i64, align 8
  %k = alloca i64, align 8
  store i64 %n, ptr %n.addr, align 8
  store ptr %s, ptr %s.addr, align 8
  %0 = load i64, ptr %n.addr, align 8
  store i64 %0, ptr @sieve_size, align 8
  %1 = load i64, ptr %n.addr, align 8
  %conv = sitofp i64 %1 to double
  %call = call double @sqrt(double noundef %conv) #9
  %conv1 = fptosi double %call to i64
  store i64 %conv1, ptr %m, align 8
  %2 = load ptr, ptr %s.addr, align 8
  %3 = load i64, ptr %n.addr, align 8
  %mul = mul i64 24, %3
  %div = udiv i64 %mul, 2
  call void @llvm.memset.p0.i64(ptr align 8 %2, i8 0, i64 %div, i1 false)
  %4 = load ptr, ptr %s.addr, align 8
  %arrayidx = getelementptr inbounds %struct.sieve_t, ptr %4, i64 0
  %fac = getelementptr inbounds %struct.sieve_t, ptr %arrayidx, i32 0, i32 0
  store i64 1, ptr %fac, align 8
  %5 = load ptr, ptr %s.addr, align 8
  %arrayidx2 = getelementptr inbounds %struct.sieve_t, ptr %5, i64 0
  %pow = getelementptr inbounds %struct.sieve_t, ptr %arrayidx2, i32 0, i32 1
  store i64 1, ptr %pow, align 8
  store i64 3, ptr %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc58, %entry
  %6 = load i64, ptr %i, align 8
  %7 = load i64, ptr %n.addr, align 8
  %cmp = icmp sle i64 %6, %7
  br i1 %cmp, label %for.body, label %for.end60

for.body:                                         ; preds = %for.cond
  %8 = load ptr, ptr %s.addr, align 8
  %9 = load i64, ptr %i, align 8
  %div4 = sdiv i64 %9, 2
  %arrayidx5 = getelementptr inbounds %struct.sieve_t, ptr %8, i64 %div4
  %fac6 = getelementptr inbounds %struct.sieve_t, ptr %arrayidx5, i32 0, i32 0
  %10 = load i64, ptr %fac6, align 8
  %cmp7 = icmp eq i64 %10, 0
  br i1 %cmp7, label %if.then, label %if.end57

if.then:                                          ; preds = %for.body
  %11 = load i64, ptr %i, align 8
  %12 = load ptr, ptr %s.addr, align 8
  %13 = load i64, ptr %i, align 8
  %div9 = sdiv i64 %13, 2
  %arrayidx10 = getelementptr inbounds %struct.sieve_t, ptr %12, i64 %div9
  %fac11 = getelementptr inbounds %struct.sieve_t, ptr %arrayidx10, i32 0, i32 0
  store i64 %11, ptr %fac11, align 8
  %14 = load ptr, ptr %s.addr, align 8
  %15 = load i64, ptr %i, align 8
  %div12 = sdiv i64 %15, 2
  %arrayidx13 = getelementptr inbounds %struct.sieve_t, ptr %14, i64 %div12
  %pow14 = getelementptr inbounds %struct.sieve_t, ptr %arrayidx13, i32 0, i32 1
  store i64 1, ptr %pow14, align 8
  %16 = load i64, ptr %i, align 8
  %17 = load i64, ptr %m, align 8
  %cmp15 = icmp sle i64 %16, %17
  br i1 %cmp15, label %if.then17, label %if.end56

if.then17:                                        ; preds = %if.then
  %18 = load i64, ptr %i, align 8
  %19 = load i64, ptr %i, align 8
  %mul18 = mul nsw i64 %18, %19
  store i64 %mul18, ptr %j, align 8
  %20 = load i64, ptr %i, align 8
  %div19 = sdiv i64 %20, 2
  store i64 %div19, ptr %k, align 8
  br label %for.cond20

for.cond20:                                       ; preds = %for.inc, %if.then17
  %21 = load i64, ptr %j, align 8
  %22 = load i64, ptr %n.addr, align 8
  %cmp21 = icmp sle i64 %21, %22
  br i1 %cmp21, label %for.body23, label %for.end

for.body23:                                       ; preds = %for.cond20
  %23 = load ptr, ptr %s.addr, align 8
  %24 = load i64, ptr %j, align 8
  %div24 = sdiv i64 %24, 2
  %arrayidx25 = getelementptr inbounds %struct.sieve_t, ptr %23, i64 %div24
  %fac26 = getelementptr inbounds %struct.sieve_t, ptr %arrayidx25, i32 0, i32 0
  %25 = load i64, ptr %fac26, align 8
  %cmp27 = icmp eq i64 %25, 0
  br i1 %cmp27, label %if.then29, label %if.end53

if.then29:                                        ; preds = %for.body23
  %26 = load i64, ptr %i, align 8
  %27 = load ptr, ptr %s.addr, align 8
  %28 = load i64, ptr %j, align 8
  %div30 = sdiv i64 %28, 2
  %arrayidx31 = getelementptr inbounds %struct.sieve_t, ptr %27, i64 %div30
  %fac32 = getelementptr inbounds %struct.sieve_t, ptr %arrayidx31, i32 0, i32 0
  store i64 %26, ptr %fac32, align 8
  %29 = load ptr, ptr %s.addr, align 8
  %30 = load i64, ptr %k, align 8
  %arrayidx33 = getelementptr inbounds %struct.sieve_t, ptr %29, i64 %30
  %fac34 = getelementptr inbounds %struct.sieve_t, ptr %arrayidx33, i32 0, i32 0
  %31 = load i64, ptr %fac34, align 8
  %32 = load i64, ptr %i, align 8
  %cmp35 = icmp eq i64 %31, %32
  br i1 %cmp35, label %if.then37, label %if.else

if.then37:                                        ; preds = %if.then29
  %33 = load ptr, ptr %s.addr, align 8
  %34 = load i64, ptr %k, align 8
  %arrayidx38 = getelementptr inbounds %struct.sieve_t, ptr %33, i64 %34
  %pow39 = getelementptr inbounds %struct.sieve_t, ptr %arrayidx38, i32 0, i32 1
  %35 = load i64, ptr %pow39, align 8
  %add = add nsw i64 %35, 1
  %36 = load ptr, ptr %s.addr, align 8
  %37 = load i64, ptr %j, align 8
  %div40 = sdiv i64 %37, 2
  %arrayidx41 = getelementptr inbounds %struct.sieve_t, ptr %36, i64 %div40
  %pow42 = getelementptr inbounds %struct.sieve_t, ptr %arrayidx41, i32 0, i32 1
  store i64 %add, ptr %pow42, align 8
  %38 = load ptr, ptr %s.addr, align 8
  %39 = load i64, ptr %k, align 8
  %arrayidx43 = getelementptr inbounds %struct.sieve_t, ptr %38, i64 %39
  %nxt = getelementptr inbounds %struct.sieve_t, ptr %arrayidx43, i32 0, i32 2
  %40 = load i64, ptr %nxt, align 8
  %41 = load ptr, ptr %s.addr, align 8
  %42 = load i64, ptr %j, align 8
  %div44 = sdiv i64 %42, 2
  %arrayidx45 = getelementptr inbounds %struct.sieve_t, ptr %41, i64 %div44
  %nxt46 = getelementptr inbounds %struct.sieve_t, ptr %arrayidx45, i32 0, i32 2
  store i64 %40, ptr %nxt46, align 8
  br label %if.end

if.else:                                          ; preds = %if.then29
  %43 = load ptr, ptr %s.addr, align 8
  %44 = load i64, ptr %j, align 8
  %div47 = sdiv i64 %44, 2
  %arrayidx48 = getelementptr inbounds %struct.sieve_t, ptr %43, i64 %div47
  %pow49 = getelementptr inbounds %struct.sieve_t, ptr %arrayidx48, i32 0, i32 1
  store i64 1, ptr %pow49, align 8
  %45 = load i64, ptr %k, align 8
  %46 = load ptr, ptr %s.addr, align 8
  %47 = load i64, ptr %j, align 8
  %div50 = sdiv i64 %47, 2
  %arrayidx51 = getelementptr inbounds %struct.sieve_t, ptr %46, i64 %div50
  %nxt52 = getelementptr inbounds %struct.sieve_t, ptr %arrayidx51, i32 0, i32 2
  store i64 %45, ptr %nxt52, align 8
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then37
  br label %if.end53

if.end53:                                         ; preds = %if.end, %for.body23
  br label %for.inc

for.inc:                                          ; preds = %if.end53
  %48 = load i64, ptr %i, align 8
  %49 = load i64, ptr %i, align 8
  %add54 = add nsw i64 %48, %49
  %50 = load i64, ptr %j, align 8
  %add55 = add nsw i64 %50, %add54
  store i64 %add55, ptr %j, align 8
  %51 = load i64, ptr %k, align 8
  %inc = add nsw i64 %51, 1
  store i64 %inc, ptr %k, align 8
  br label %for.cond20, !llvm.loop !16

for.end:                                          ; preds = %for.cond20
  br label %if.end56

if.end56:                                         ; preds = %for.end, %if.then
  br label %if.end57

if.end57:                                         ; preds = %if.end56, %for.body
  br label %for.inc58

for.inc58:                                        ; preds = %if.end57
  %52 = load i64, ptr %i, align 8
  %add59 = add nsw i64 %52, 2
  store i64 %add59, ptr %i, align 8
  br label %for.cond, !llvm.loop !17

for.end60:                                        ; preds = %for.cond
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #6

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @picomp(i64 noundef %d, i32 noundef %out) #0 {
entry:
  %d.addr = alloca i64, align 8
  %out.addr = alloca i32, align 4
  %pi = alloca [1 x %struct.__mpf_struct], align 16
  %qi = alloca [1 x %struct.__mpf_struct], align 16
  %i = alloca i64, align 8
  %depth = alloca i64, align 8
  %terms = alloca i64, align 8
  %psize = alloca i64, align 8
  %qsize = alloca i64, align 8
  store i64 %d, ptr %d.addr, align 8
  store i32 %out, ptr %out.addr, align 4
  store i64 1, ptr %depth, align 8
  %0 = load i64, ptr %d.addr, align 8
  %conv = sitofp i64 %0 to double
  %div = fdiv double %conv, 0x402C5D00E56F9D57
  %conv1 = fptosi double %div to i64
  store i64 %conv1, ptr %terms, align 8
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %1 = load i64, ptr %depth, align 8
  %shl = shl i64 1, %1
  %2 = load i64, ptr %terms, align 8
  %cmp = icmp slt i64 %shl, %2
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %3 = load i64, ptr %depth, align 8
  %inc = add nsw i64 %3, 1
  store i64 %inc, ptr %depth, align 8
  br label %while.cond, !llvm.loop !18

while.end:                                        ; preds = %while.cond
  %4 = load i64, ptr %depth, align 8
  %inc3 = add nsw i64 %4, 1
  store i64 %inc3, ptr %depth, align 8
  %5 = load i64, ptr %terms, align 8
  %mul = mul nsw i64 %5, 6
  %cmp4 = icmp sgt i64 10006, %mul
  br i1 %cmp4, label %cond.true, label %cond.false

cond.true:                                        ; preds = %while.end
  br label %cond.end

cond.false:                                       ; preds = %while.end
  %6 = load i64, ptr %terms, align 8
  %mul6 = mul nsw i64 %6, 6
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i64 [ 10006, %cond.true ], [ %mul6, %cond.false ]
  store i64 %cond, ptr @sieve_size, align 8
  %7 = load i64, ptr @sieve_size, align 8
  %mul7 = mul i64 24, %7
  %div8 = udiv i64 %mul7, 2
  %call = call noalias ptr @malloc(i64 noundef %div8) #11
  store ptr %call, ptr @sieve, align 8
  %8 = load i64, ptr @sieve_size, align 8
  %9 = load ptr, ptr @sieve, align 8
  call void @build_sieve(i64 noundef %8, ptr noundef %9)
  %10 = load i64, ptr %depth, align 8
  %mul9 = mul i64 16, %10
  %call10 = call noalias ptr @malloc(i64 noundef %mul9) #11
  store ptr %call10, ptr @pstack, align 8
  %11 = load i64, ptr %depth, align 8
  %mul11 = mul i64 16, %11
  %call12 = call noalias ptr @malloc(i64 noundef %mul11) #11
  store ptr %call12, ptr @qstack, align 8
  %12 = load i64, ptr %depth, align 8
  %mul13 = mul i64 16, %12
  %call14 = call noalias ptr @malloc(i64 noundef %mul13) #11
  store ptr %call14, ptr @gstack, align 8
  %13 = load i64, ptr %depth, align 8
  %mul15 = mul i64 32, %13
  %call16 = call noalias ptr @malloc(i64 noundef %mul15) #11
  store ptr %call16, ptr @fpstack, align 8
  %14 = load i64, ptr %depth, align 8
  %mul17 = mul i64 32, %14
  %call18 = call noalias ptr @malloc(i64 noundef %mul17) #11
  store ptr %call18, ptr @fgstack, align 8
  store i64 0, ptr %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %cond.end
  %15 = load i64, ptr %i, align 8
  %16 = load i64, ptr %depth, align 8
  %cmp19 = icmp slt i64 %15, %16
  br i1 %cmp19, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %17 = load ptr, ptr @pstack, align 8
  %18 = load i64, ptr %i, align 8
  %arrayidx = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %17, i64 %18
  %arraydecay = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay)
  %19 = load ptr, ptr @qstack, align 8
  %20 = load i64, ptr %i, align 8
  %arrayidx21 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %19, i64 %20
  %arraydecay22 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx21, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay22)
  %21 = load ptr, ptr @gstack, align 8
  %22 = load i64, ptr %i, align 8
  %arrayidx23 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %21, i64 %22
  %arraydecay24 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx23, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay24)
  %23 = load ptr, ptr @fpstack, align 8
  %24 = load i64, ptr %i, align 8
  %arrayidx25 = getelementptr inbounds [1 x %struct.anon], ptr %23, i64 %24
  %arraydecay26 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx25, i64 0, i64 0
  call void @fac_init(ptr noundef %arraydecay26)
  %25 = load ptr, ptr @fgstack, align 8
  %26 = load i64, ptr %i, align 8
  %arrayidx27 = getelementptr inbounds [1 x %struct.anon], ptr %25, i64 %26
  %arraydecay28 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx27, i64 0, i64 0
  call void @fac_init(ptr noundef %arraydecay28)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %27 = load i64, ptr %i, align 8
  %inc29 = add nsw i64 %27, 1
  store i64 %inc29, ptr %i, align 8
  br label %for.cond, !llvm.loop !19

for.end:                                          ; preds = %for.cond
  call void @__gmpz_init(ptr noundef @gcd)
  call void @fac_init(ptr noundef @ftmp)
  call void @fac_init(ptr noundef @fmul)
  %28 = load i64, ptr %terms, align 8
  %cmp30 = icmp sle i64 %28, 0
  br i1 %cmp30, label %if.then, label %if.else

if.then:                                          ; preds = %for.end
  %29 = load ptr, ptr @pstack, align 8
  %30 = load i64, ptr @top, align 8
  %add = add nsw i64 %30, 1
  %arrayidx32 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %29, i64 %add
  %arraydecay33 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx32, i64 0, i64 0
  call void @__gmpz_set_ui(ptr noundef %arraydecay33, i64 noundef 1)
  %31 = load ptr, ptr @qstack, align 8
  %32 = load i64, ptr @top, align 8
  %add34 = add nsw i64 %32, 1
  %arrayidx35 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %31, i64 %add34
  %arraydecay36 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx35, i64 0, i64 0
  call void @__gmpz_set_ui(ptr noundef %arraydecay36, i64 noundef 0)
  %33 = load ptr, ptr @gstack, align 8
  %34 = load i64, ptr @top, align 8
  %add37 = add nsw i64 %34, 1
  %arrayidx38 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %33, i64 %add37
  %arraydecay39 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx38, i64 0, i64 0
  call void @__gmpz_set_ui(ptr noundef %arraydecay39, i64 noundef 1)
  br label %if.end

if.else:                                          ; preds = %for.end
  %35 = load i64, ptr %terms, align 8
  call void @bs(i64 noundef 0, i64 noundef %35, i32 noundef 0, i64 noundef 0)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %36 = load ptr, ptr @sieve, align 8
  call void @free(ptr noundef %36) #9
  call void @__gmpz_clear(ptr noundef @gcd)
  call void @fac_clear(ptr noundef @ftmp)
  call void @fac_clear(ptr noundef @fmul)
  store i64 1, ptr %i, align 8
  br label %for.cond40

for.cond40:                                       ; preds = %for.inc54, %if.end
  %37 = load i64, ptr %i, align 8
  %38 = load i64, ptr %depth, align 8
  %cmp41 = icmp slt i64 %37, %38
  br i1 %cmp41, label %for.body43, label %for.end56

for.body43:                                       ; preds = %for.cond40
  %39 = load ptr, ptr @pstack, align 8
  %40 = load i64, ptr %i, align 8
  %arrayidx44 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %39, i64 %40
  %arraydecay45 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx44, i64 0, i64 0
  call void @__gmpz_clear(ptr noundef %arraydecay45)
  %41 = load ptr, ptr @qstack, align 8
  %42 = load i64, ptr %i, align 8
  %arrayidx46 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %41, i64 %42
  %arraydecay47 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx46, i64 0, i64 0
  call void @__gmpz_clear(ptr noundef %arraydecay47)
  %43 = load ptr, ptr @gstack, align 8
  %44 = load i64, ptr %i, align 8
  %arrayidx48 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %43, i64 %44
  %arraydecay49 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx48, i64 0, i64 0
  call void @__gmpz_clear(ptr noundef %arraydecay49)
  %45 = load ptr, ptr @fpstack, align 8
  %46 = load i64, ptr %i, align 8
  %arrayidx50 = getelementptr inbounds [1 x %struct.anon], ptr %45, i64 %46
  %arraydecay51 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx50, i64 0, i64 0
  call void @fac_clear(ptr noundef %arraydecay51)
  %47 = load ptr, ptr @fgstack, align 8
  %48 = load i64, ptr %i, align 8
  %arrayidx52 = getelementptr inbounds [1 x %struct.anon], ptr %47, i64 %48
  %arraydecay53 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx52, i64 0, i64 0
  call void @fac_clear(ptr noundef %arraydecay53)
  br label %for.inc54

for.inc54:                                        ; preds = %for.body43
  %49 = load i64, ptr %i, align 8
  %inc55 = add nsw i64 %49, 1
  store i64 %inc55, ptr %i, align 8
  br label %for.cond40, !llvm.loop !20

for.end56:                                        ; preds = %for.cond40
  %50 = load ptr, ptr @gstack, align 8
  %arrayidx57 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %50, i64 0
  %arraydecay58 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx57, i64 0, i64 0
  call void @__gmpz_clear(ptr noundef %arraydecay58)
  %51 = load ptr, ptr @fpstack, align 8
  %arrayidx59 = getelementptr inbounds [1 x %struct.anon], ptr %51, i64 0
  %arraydecay60 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx59, i64 0, i64 0
  call void @fac_clear(ptr noundef %arraydecay60)
  %52 = load ptr, ptr @fgstack, align 8
  %arrayidx61 = getelementptr inbounds [1 x %struct.anon], ptr %52, i64 0
  %arraydecay62 = getelementptr inbounds [1 x %struct.anon], ptr %arrayidx61, i64 0, i64 0
  call void @fac_clear(ptr noundef %arraydecay62)
  %53 = load ptr, ptr @gstack, align 8
  call void @free(ptr noundef %53) #9
  %54 = load ptr, ptr @fpstack, align 8
  call void @free(ptr noundef %54) #9
  %55 = load ptr, ptr @fgstack, align 8
  call void @free(ptr noundef %55) #9
  %56 = load i64, ptr %d.addr, align 8
  %conv63 = sitofp i64 %56 to double
  %57 = call double @llvm.fmuladd.f64(double %conv63, double 0x400A934F0979A371, double 1.600000e+01)
  %conv65 = fptosi double %57 to i64
  call void @__gmpf_set_default_prec(i64 noundef %conv65)
  %58 = load ptr, ptr @pstack, align 8
  %59 = load i64, ptr @top, align 8
  %arrayidx66 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %58, i64 %59
  %arraydecay67 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx66, i64 0, i64 0
  %call68 = call i64 @__gmpz_sizeinbase(ptr noundef %arraydecay67, i32 noundef 10) #8
  store i64 %call68, ptr %psize, align 8
  %60 = load ptr, ptr @qstack, align 8
  %61 = load i64, ptr @top, align 8
  %arrayidx69 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %60, i64 %61
  %arraydecay70 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx69, i64 0, i64 0
  %call71 = call i64 @__gmpz_sizeinbase(ptr noundef %arraydecay70, i32 noundef 10) #8
  store i64 %call71, ptr %qsize, align 8
  %62 = load ptr, ptr @qstack, align 8
  %63 = load i64, ptr @top, align 8
  %arrayidx72 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %62, i64 %63
  %arraydecay73 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx72, i64 0, i64 0
  %64 = load ptr, ptr @pstack, align 8
  %65 = load i64, ptr @top, align 8
  %arrayidx74 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %64, i64 %65
  %arraydecay75 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx74, i64 0, i64 0
  call void @__gmpz_addmul_ui(ptr noundef %arraydecay73, ptr noundef %arraydecay75, i64 noundef 13591409)
  %66 = load ptr, ptr @pstack, align 8
  %67 = load i64, ptr @top, align 8
  %arrayidx76 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %66, i64 %67
  %arraydecay77 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx76, i64 0, i64 0
  %68 = load ptr, ptr @pstack, align 8
  %69 = load i64, ptr @top, align 8
  %arrayidx78 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %68, i64 %69
  %arraydecay79 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx78, i64 0, i64 0
  call void @__gmpz_mul_ui(ptr noundef %arraydecay77, ptr noundef %arraydecay79, i64 noundef 53360)
  %arraydecay80 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %pi, i64 0, i64 0
  call void @__gmpf_init(ptr noundef %arraydecay80)
  %arraydecay81 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %pi, i64 0, i64 0
  %70 = load ptr, ptr @pstack, align 8
  %71 = load i64, ptr @top, align 8
  %arrayidx82 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %70, i64 %71
  %arraydecay83 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx82, i64 0, i64 0
  call void @__gmpf_set_z(ptr noundef %arraydecay81, ptr noundef %arraydecay83)
  %72 = load ptr, ptr @pstack, align 8
  %73 = load i64, ptr @top, align 8
  %arrayidx84 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %72, i64 %73
  %arraydecay85 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx84, i64 0, i64 0
  call void @__gmpz_clear(ptr noundef %arraydecay85)
  %arraydecay86 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %qi, i64 0, i64 0
  call void @__gmpf_init(ptr noundef %arraydecay86)
  %arraydecay87 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %qi, i64 0, i64 0
  %74 = load ptr, ptr @qstack, align 8
  %75 = load i64, ptr @top, align 8
  %arrayidx88 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %74, i64 %75
  %arraydecay89 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx88, i64 0, i64 0
  call void @__gmpf_set_z(ptr noundef %arraydecay87, ptr noundef %arraydecay89)
  %76 = load ptr, ptr @qstack, align 8
  %77 = load i64, ptr @top, align 8
  %arrayidx90 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %76, i64 %77
  %arraydecay91 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx90, i64 0, i64 0
  call void @__gmpz_clear(ptr noundef %arraydecay91)
  %78 = load ptr, ptr @pstack, align 8
  call void @free(ptr noundef %78) #9
  %79 = load ptr, ptr @qstack, align 8
  call void @free(ptr noundef %79) #9
  call void @__gmpf_init(ptr noundef @t1)
  call void @__gmpf_init(ptr noundef @t2)
  %arraydecay92 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %qi, i64 0, i64 0
  %arraydecay93 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %pi, i64 0, i64 0
  %arraydecay94 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %qi, i64 0, i64 0
  call void @my_div(ptr noundef %arraydecay92, ptr noundef %arraydecay93, ptr noundef %arraydecay94)
  %arraydecay95 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %pi, i64 0, i64 0
  call void @my_sqrt_ui(ptr noundef %arraydecay95, i64 noundef 640320)
  %arraydecay96 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %qi, i64 0, i64 0
  %arraydecay97 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %qi, i64 0, i64 0
  %arraydecay98 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %pi, i64 0, i64 0
  call void @__gmpf_mul(ptr noundef %arraydecay96, ptr noundef %arraydecay97, ptr noundef %arraydecay98)
  %80 = load i32, ptr %out.addr, align 4
  %and = and i32 %80, 1
  %tobool = icmp ne i32 %and, 0
  br i1 %tobool, label %if.then99, label %if.end105

if.then99:                                        ; preds = %for.end56
  %81 = load i64, ptr %terms, align 8
  %call100 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i64 noundef %81)
  %82 = load ptr, ptr @stdout, align 8
  %83 = load i64, ptr %d.addr, align 8
  %add101 = add nsw i64 %83, 2
  %arraydecay102 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %qi, i64 0, i64 0
  %call103 = call i64 @__gmpf_out_str(ptr noundef %82, i32 noundef 10, i64 noundef %add101, ptr noundef %arraydecay102)
  %call104 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  br label %if.end105

if.end105:                                        ; preds = %if.then99, %for.end56
  %arraydecay106 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %pi, i64 0, i64 0
  call void @__gmpf_clear(ptr noundef %arraydecay106)
  %arraydecay107 = getelementptr inbounds [1 x %struct.__mpf_struct], ptr %qi, i64 0, i64 0
  call void @__gmpf_clear(ptr noundef %arraydecay107)
  call void @__gmpf_clear(ptr noundef @t1)
  call void @__gmpf_clear(ptr noundef @t2)
  ret void
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #7

declare void @fac_init(ptr noundef) #2

; Function Attrs: nounwind
declare void @free(ptr noundef) #3

declare void @fac_clear(ptr noundef) #2

declare void @__gmpf_set_default_prec(i64 noundef) #2

; Function Attrs: nounwind willreturn memory(read)
declare i64 @__gmpz_sizeinbase(ptr noundef, i32 noundef) #1

declare void @__gmpz_addmul_ui(ptr noundef, ptr noundef, i64 noundef) #2

declare void @__gmpf_init(ptr noundef) #2

declare void @__gmpf_set_z(ptr noundef, ptr noundef) #2

declare i64 @__gmpf_out_str(ptr noundef, i32 noundef, i64 noundef, ptr noundef) #2

declare void @__gmpf_clear(ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %argc, ptr noundef %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca ptr, align 8
  %out = alloca i32, align 4
  %d = alloca i64, align 8
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
  store i32 0, ptr %out, align 4
  store i64 100, ptr %d, align 8
  %0 = load i32, ptr %argc.addr, align 4
  %cmp = icmp sge i32 %0, 2
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %argv.addr, align 8
  %arrayidx = getelementptr inbounds ptr, ptr %1, i64 1
  %2 = load ptr, ptr %arrayidx, align 8
  %call = call i64 @strtoul(ptr noundef %2, ptr noundef null, i32 noundef 0) #9
  store i64 %call, ptr %d, align 8
  %3 = load i32, ptr %argc.addr, align 4
  %cmp1 = icmp sgt i32 %3, 2
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.then
  %4 = load ptr, ptr %argv.addr, align 8
  %arrayidx3 = getelementptr inbounds ptr, ptr %4, i64 2
  %5 = load ptr, ptr %arrayidx3, align 8
  %call4 = call i32 @atoi(ptr noundef %5) #8
  store i32 %call4, ptr %out, align 4
  br label %if.end

if.end:                                           ; preds = %if.then2, %if.then
  br label %if.end8

if.else:                                          ; preds = %entry
  %6 = load ptr, ptr @stderr, align 8
  %7 = load ptr, ptr %argv.addr, align 8
  %arrayidx5 = getelementptr inbounds ptr, ptr %7, i64 0
  %8 = load ptr, ptr %arrayidx5, align 8
  %call6 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %6, ptr noundef @.str.6, ptr noundef %8)
  %9 = load ptr, ptr @stderr, align 8
  %call7 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %9, ptr noundef @.str.7)
  store i32 -1, ptr %retval, align 4
  br label %return

if.end8:                                          ; preds = %if.end
  %call9 = call i32 (ptr, ...) @printf(ptr noundef @.str.8)
  %10 = load ptr, ptr @stdout, align 8
  %call10 = call i32 @fflush(ptr noundef %10)
  br label %do.body

do.body:                                          ; preds = %if.end8
  store i64 1, ptr %__times, align 8
  %11 = load i64, ptr %d, align 8
  %12 = load i32, ptr %out, align 4
  call void @picomp(i64 noundef %11, i32 noundef %12)
  br label %do.body11

do.body11:                                        ; preds = %do.cond, %do.body
  %13 = load i64, ptr %__times, align 8
  %shl = shl i64 %13, 1
  store i64 %shl, ptr %__times, align 8
  %call12 = call i32 @cputime()
  %conv = sext i32 %call12 to i64
  store i64 %conv, ptr %__t0, align 8
  store i64 0, ptr %__t, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %do.body11
  %14 = load i64, ptr %__t, align 8
  %15 = load i64, ptr %__times, align 8
  %cmp13 = icmp slt i64 %14, %15
  br i1 %cmp13, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %16 = load i64, ptr %d, align 8
  %17 = load i32, ptr %out, align 4
  call void @picomp(i64 noundef %16, i32 noundef %17)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %18 = load i64, ptr %__t, align 8
  %inc = add nsw i64 %18, 1
  store i64 %inc, ptr %__t, align 8
  br label %for.cond, !llvm.loop !21

for.end:                                          ; preds = %for.cond
  %call15 = call i32 @cputime()
  %conv16 = sext i32 %call15 to i64
  %19 = load i64, ptr %__t0, align 8
  %sub = sub nsw i64 %conv16, %19
  store i64 %sub, ptr %__tmp, align 8
  br label %do.cond

do.cond:                                          ; preds = %for.end
  %20 = load i64, ptr %__tmp, align 8
  %cmp17 = icmp slt i64 %20, 250
  br i1 %cmp17, label %do.body11, label %do.end, !llvm.loop !22

do.end:                                           ; preds = %do.cond
  %21 = load i64, ptr %__tmp, align 8
  %conv19 = sitofp i64 %21 to double
  %22 = load i64, ptr %__times, align 8
  %conv20 = sitofp i64 %22 to double
  %div = fdiv double %conv19, %conv20
  store double %div, ptr %t, align 8
  br label %do.end22

do.end22:                                         ; preds = %do.end
  %call23 = call i32 (ptr, ...) @printf(ptr noundef @.str.9)
  %23 = load double, ptr %t, align 8
  %div24 = fdiv double 1.000000e+04, %23
  %conv25 = fptoui double %div24 to i64
  %add = add i64 1, %conv25
  store i64 %add, ptr %niter, align 8
  %24 = load i64, ptr %d, align 8
  %25 = load i64, ptr %niter, align 8
  %call26 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, i64 noundef %24, i64 noundef %25)
  %26 = load ptr, ptr @stdout, align 8
  %call27 = call i32 @fflush(ptr noundef %26)
  %call28 = call i32 @cputime()
  %conv29 = sext i32 %call28 to i64
  store i64 %conv29, ptr %t0, align 8
  %27 = load i64, ptr %niter, align 8
  store i64 %27, ptr %i, align 8
  br label %for.cond30

for.cond30:                                       ; preds = %for.inc34, %do.end22
  %28 = load i64, ptr %i, align 8
  %cmp31 = icmp ugt i64 %28, 0
  br i1 %cmp31, label %for.body33, label %for.end35

for.body33:                                       ; preds = %for.cond30
  %29 = load i64, ptr %d, align 8
  %30 = load i32, ptr %out, align 4
  call void @picomp(i64 noundef %29, i32 noundef %30)
  br label %for.inc34

for.inc34:                                        ; preds = %for.body33
  %31 = load i64, ptr %i, align 8
  %dec = add i64 %31, -1
  store i64 %dec, ptr %i, align 8
  br label %for.cond30, !llvm.loop !23

for.end35:                                        ; preds = %for.cond30
  %call36 = call i32 @cputime()
  %conv37 = sext i32 %call36 to i64
  %32 = load i64, ptr %t0, align 8
  %sub38 = sub i64 %conv37, %32
  store i64 %sub38, ptr %ti, align 8
  %call39 = call i32 (ptr, ...) @printf(ptr noundef @.str.11)
  %33 = load i64, ptr %niter, align 8
  %conv40 = uitofp i64 %33 to double
  %mul = fmul double 1.000000e+03, %conv40
  %34 = load i64, ptr %ti, align 8
  %conv41 = uitofp i64 %34 to double
  %div42 = fdiv double %mul, %conv41
  store double %div42, ptr %ops_per_sec, align 8
  store double 1.000000e+02, ptr %f, align 8
  store i32 0, ptr %decimals, align 4
  br label %for.cond43

for.cond43:                                       ; preds = %for.inc49, %for.end35
  %35 = load double, ptr %ops_per_sec, align 8
  %36 = load double, ptr %f, align 8
  %cmp44 = fcmp ogt double %35, %36
  br i1 %cmp44, label %if.then46, label %if.end47

if.then46:                                        ; preds = %for.cond43
  br label %for.end51

if.end47:                                         ; preds = %for.cond43
  %37 = load double, ptr %f, align 8
  %mul48 = fmul double %37, 1.000000e-01
  store double %mul48, ptr %f, align 8
  br label %for.inc49

for.inc49:                                        ; preds = %if.end47
  %38 = load i32, ptr %decimals, align 4
  %inc50 = add nsw i32 %38, 1
  store i32 %inc50, ptr %decimals, align 4
  br label %for.cond43

for.end51:                                        ; preds = %if.then46
  %39 = load i32, ptr %decimals, align 4
  %40 = load double, ptr %ops_per_sec, align 8
  %call52 = call i32 (ptr, ...) @printf(ptr noundef @.str.12, i32 noundef %39, double noundef %40)
  store i32 0, ptr %retval, align 4
  br label %return

return:                                           ; preds = %for.end51, %if.else
  %41 = load i32, ptr %retval, align 4
  ret i32 %41
}

; Function Attrs: nounwind
declare i64 @strtoul(ptr noundef, ptr noundef, i32 noundef) #3

; Function Attrs: nounwind willreturn memory(read)
declare i32 @atoi(ptr noundef) #1

declare i32 @fprintf(ptr noundef, ptr noundef, ...) #2

declare i32 @fflush(ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @cputime() #0 {
entry:
  %rus = alloca %struct.rusage, align 8
  %call = call i32 @getrusage(i32 noundef 0, ptr noundef %rus) #9
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
attributes #1 = { nounwind willreturn memory(read) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #7 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { nounwind willreturn memory(read) }
attributes #9 = { nounwind }
attributes #10 = { noreturn nounwind }
attributes #11 = { nounwind allocsize(0) }

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
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
!23 = distinct !{!23, !7}
