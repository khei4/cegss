; ModuleID = 'rsa.c'
source_filename = "rsa.c"
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
@.str = private unnamed_addr constant [13 x i8] c"usage: %s n\0A\00", align 1
@.str.1 = private unnamed_addr constant [47 x i8] c"  where n is number of bits in numbers tested\0A\00", align 1
@.str.2 = private unnamed_addr constant [22 x i8] c"Generating p, q, d...\00", align 1
@stdout = external global ptr, align 8
@.str.3 = private unnamed_addr constant [21 x i8] c"done; pq is %d bits\0A\00", align 1
@.str.4 = private unnamed_addr constant [28 x i8] c"Precomputing CRT constants\0A\00", align 1
@.str.5 = private unnamed_addr constant [28 x i8] c"Generating random messages\0A\00", align 1
@.str.6 = private unnamed_addr constant [25 x i8] c"Calibrating CPU speed...\00", align 1
@.str.7 = private unnamed_addr constant [6 x i8] c"done\0A\00", align 1
@.str.8 = private unnamed_addr constant [37 x i8] c"Signing random messages %lu times...\00", align 1
@.str.9 = private unnamed_addr constant [7 x i8] c"done!\0A\00", align 1
@.str.10 = private unnamed_addr constant [36 x i8] c"RESULT: %.*f operations per second\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %argc, ptr noundef %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca ptr, align 8
  %rs = alloca [1 x %struct.__gmp_randstate_struct], align 16
  %p = alloca [1 x %struct.__mpz_struct], align 16
  %q = alloca [1 x %struct.__mpz_struct], align 16
  %pq = alloca [1 x %struct.__mpz_struct], align 16
  %pm1 = alloca [1 x %struct.__mpz_struct], align 16
  %qm1 = alloca [1 x %struct.__mpz_struct], align 16
  %phi = alloca [1 x %struct.__mpz_struct], align 16
  %e = alloca [1 x %struct.__mpz_struct], align 16
  %d = alloca [1 x %struct.__mpz_struct], align 16
  %p_i_q = alloca [1 x %struct.__mpz_struct], align 16
  %dp = alloca [1 x %struct.__mpz_struct], align 16
  %dq = alloca [1 x %struct.__mpz_struct], align 16
  %msg = alloca [1024 x [1 x %struct.__mpz_struct]], align 16
  %smsg = alloca [1 x %struct.__mpz_struct], align 16
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
  %cmp = icmp ne i32 %0, 2
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
  %5 = load i32, ptr %argc.addr, align 4
  %cmp2 = icmp eq i32 %5, 2
  br i1 %cmp2, label %if.then3, label %if.end6

if.then3:                                         ; preds = %if.end
  %6 = load ptr, ptr %argv.addr, align 8
  %arrayidx4 = getelementptr inbounds ptr, ptr %6, i64 1
  %7 = load ptr, ptr %arrayidx4, align 8
  %call5 = call i32 @atoi(ptr noundef %7) #5
  %conv = sext i32 %call5 to i64
  store i64 %conv, ptr %n, align 8
  br label %if.end6

if.end6:                                          ; preds = %if.then3, %if.end
  %arraydecay = getelementptr inbounds [1 x %struct.__gmp_randstate_struct], ptr %rs, i64 0, i64 0
  call void @__gmp_randinit_default(ptr noundef %arraydecay)
  %arraydecay7 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay7)
  %arraydecay8 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %q, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay8)
  %arraydecay9 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pq, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay9)
  %call10 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  %8 = load ptr, ptr @stdout, align 8
  %call11 = call i32 @fflush(ptr noundef %8)
  br label %do.body

do.body:                                          ; preds = %do.cond, %if.end6
  %arraydecay12 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p, i64 0, i64 0
  %arraydecay13 = getelementptr inbounds [1 x %struct.__gmp_randstate_struct], ptr %rs, i64 0, i64 0
  %9 = load i64, ptr %n, align 8
  %div = udiv i64 %9, 2
  call void @__gmpz_urandomb(ptr noundef %arraydecay12, ptr noundef %arraydecay13, i64 noundef %div)
  %arraydecay14 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p, i64 0, i64 0
  %10 = load i64, ptr %n, align 8
  %div15 = udiv i64 %10, 2
  %sub = sub i64 %div15, 1
  call void @__gmpz_setbit(ptr noundef %arraydecay14, i64 noundef %sub)
  %arraydecay16 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p, i64 0, i64 0
  %11 = load i64, ptr %n, align 8
  %div17 = udiv i64 %11, 2
  %sub18 = sub i64 %div17, 2
  call void @__gmpz_setbit(ptr noundef %arraydecay16, i64 noundef %sub18)
  %arraydecay19 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p, i64 0, i64 0
  call void @__gmpz_setbit(ptr noundef %arraydecay19, i64 noundef 0)
  %arraydecay20 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %q, i64 0, i64 0
  %arraydecay21 = getelementptr inbounds [1 x %struct.__gmp_randstate_struct], ptr %rs, i64 0, i64 0
  %12 = load i64, ptr %n, align 8
  %div22 = udiv i64 %12, 2
  call void @__gmpz_urandomb(ptr noundef %arraydecay20, ptr noundef %arraydecay21, i64 noundef %div22)
  %arraydecay23 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %q, i64 0, i64 0
  %13 = load i64, ptr %n, align 8
  %div24 = udiv i64 %13, 2
  %sub25 = sub i64 %div24, 1
  call void @__gmpz_setbit(ptr noundef %arraydecay23, i64 noundef %sub25)
  %arraydecay26 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %q, i64 0, i64 0
  %14 = load i64, ptr %n, align 8
  %div27 = udiv i64 %14, 2
  %sub28 = sub i64 %div27, 2
  call void @__gmpz_setbit(ptr noundef %arraydecay26, i64 noundef %sub28)
  %arraydecay29 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %q, i64 0, i64 0
  call void @__gmpz_setbit(ptr noundef %arraydecay29, i64 noundef 0)
  %arraydecay30 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pq, i64 0, i64 0
  %arraydecay31 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p, i64 0, i64 0
  %arraydecay32 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %q, i64 0, i64 0
  call void @__gmpz_gcd(ptr noundef %arraydecay30, ptr noundef %arraydecay31, ptr noundef %arraydecay32)
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %arraydecay33 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pq, i64 0, i64 0
  %call34 = call i32 @__gmpz_cmp_ui(ptr noundef %arraydecay33, i64 noundef 1) #5
  %cmp35 = icmp ne i32 %call34, 0
  br i1 %cmp35, label %do.body, label %do.end, !llvm.loop !6

do.end:                                           ; preds = %do.cond
  %arraydecay37 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pq, i64 0, i64 0
  %arraydecay38 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p, i64 0, i64 0
  %arraydecay39 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %q, i64 0, i64 0
  call void @__gmpz_mul(ptr noundef %arraydecay37, ptr noundef %arraydecay38, ptr noundef %arraydecay39)
  %arraydecay40 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %e, i64 0, i64 0
  call void @__gmpz_init_set_ui(ptr noundef %arraydecay40, i64 noundef 65537)
  %arraydecay41 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %d, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay41)
  %arraydecay42 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pm1, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay42)
  %arraydecay43 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %qm1, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay43)
  %arraydecay44 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %phi, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay44)
  %arraydecay45 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pm1, i64 0, i64 0
  %arraydecay46 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p, i64 0, i64 0
  call void @__gmpz_sub_ui(ptr noundef %arraydecay45, ptr noundef %arraydecay46, i64 noundef 1)
  %arraydecay47 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %qm1, i64 0, i64 0
  %arraydecay48 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %q, i64 0, i64 0
  call void @__gmpz_sub_ui(ptr noundef %arraydecay47, ptr noundef %arraydecay48, i64 noundef 1)
  %arraydecay49 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %phi, i64 0, i64 0
  %arraydecay50 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pm1, i64 0, i64 0
  %arraydecay51 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %qm1, i64 0, i64 0
  call void @__gmpz_mul(ptr noundef %arraydecay49, ptr noundef %arraydecay50, ptr noundef %arraydecay51)
  %arraydecay52 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %d, i64 0, i64 0
  %arraydecay53 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %e, i64 0, i64 0
  %arraydecay54 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %phi, i64 0, i64 0
  %call55 = call i32 @__gmpz_invert(ptr noundef %arraydecay52, ptr noundef %arraydecay53, ptr noundef %arraydecay54)
  %cmp56 = icmp eq i32 %call55, 0
  br i1 %cmp56, label %if.then58, label %if.end59

if.then58:                                        ; preds = %do.end
  call void @abort() #6
  unreachable

if.end59:                                         ; preds = %do.end
  %arraydecay60 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pq, i64 0, i64 0
  %call61 = call i64 @__gmpz_sizeinbase(ptr noundef %arraydecay60, i32 noundef 2) #5
  %conv62 = trunc i64 %call61 to i32
  %call63 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %conv62)
  %call64 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  %arraydecay65 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p_i_q, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay65)
  %arraydecay66 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p_i_q, i64 0, i64 0
  %arraydecay67 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p, i64 0, i64 0
  %arraydecay68 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %q, i64 0, i64 0
  %call69 = call i32 @__gmpz_invert(ptr noundef %arraydecay66, ptr noundef %arraydecay67, ptr noundef %arraydecay68)
  %cmp70 = icmp eq i32 %call69, 0
  br i1 %cmp70, label %if.then72, label %if.end73

if.then72:                                        ; preds = %if.end59
  call void @abort() #6
  unreachable

if.end73:                                         ; preds = %if.end59
  %arraydecay74 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %dp, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay74)
  %arraydecay75 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %dq, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay75)
  %arraydecay76 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %dp, i64 0, i64 0
  %arraydecay77 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %d, i64 0, i64 0
  %arraydecay78 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pm1, i64 0, i64 0
  call void @__gmpz_mod(ptr noundef %arraydecay76, ptr noundef %arraydecay77, ptr noundef %arraydecay78)
  %arraydecay79 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %dq, i64 0, i64 0
  %arraydecay80 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %d, i64 0, i64 0
  %arraydecay81 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %qm1, i64 0, i64 0
  call void @__gmpz_mod(ptr noundef %arraydecay79, ptr noundef %arraydecay80, ptr noundef %arraydecay81)
  %call82 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  store i64 0, ptr %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end73
  %15 = load i64, ptr %i, align 8
  %cmp83 = icmp ult i64 %15, 1024
  br i1 %cmp83, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %16 = load i64, ptr %i, align 8
  %arrayidx85 = getelementptr inbounds [1024 x [1 x %struct.__mpz_struct]], ptr %msg, i64 0, i64 %16
  %arraydecay86 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx85, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay86)
  %17 = load i64, ptr %i, align 8
  %arrayidx87 = getelementptr inbounds [1024 x [1 x %struct.__mpz_struct]], ptr %msg, i64 0, i64 %17
  %arraydecay88 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx87, i64 0, i64 0
  %arraydecay89 = getelementptr inbounds [1 x %struct.__gmp_randstate_struct], ptr %rs, i64 0, i64 0
  %18 = load i64, ptr %n, align 8
  call void @__gmpz_urandomb(ptr noundef %arraydecay88, ptr noundef %arraydecay89, i64 noundef %18)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %19 = load i64, ptr %i, align 8
  %inc = add i64 %19, 1
  store i64 %inc, ptr %i, align 8
  br label %for.cond, !llvm.loop !8

for.end:                                          ; preds = %for.cond
  %arraydecay90 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %smsg, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay90)
  %call91 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  %20 = load ptr, ptr @stdout, align 8
  %call92 = call i32 @fflush(ptr noundef %20)
  br label %do.body93

do.body93:                                        ; preds = %for.end
  store i64 1, ptr %__times, align 8
  %arraydecay94 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %smsg, i64 0, i64 0
  %arrayidx95 = getelementptr inbounds [1024 x [1 x %struct.__mpz_struct]], ptr %msg, i64 0, i64 0
  %arraydecay96 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx95, i64 0, i64 0
  %arraydecay97 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p, i64 0, i64 0
  %arraydecay98 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %q, i64 0, i64 0
  %arraydecay99 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pq, i64 0, i64 0
  %arraydecay100 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p_i_q, i64 0, i64 0
  %arraydecay101 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %dp, i64 0, i64 0
  %arraydecay102 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %dq, i64 0, i64 0
  call void @rsa_sign(ptr noundef %arraydecay94, ptr noundef %arraydecay96, ptr noundef %arraydecay97, ptr noundef %arraydecay98, ptr noundef %arraydecay99, ptr noundef %arraydecay100, ptr noundef %arraydecay101, ptr noundef %arraydecay102)
  br label %do.body103

do.body103:                                       ; preds = %do.cond125, %do.body93
  %21 = load i64, ptr %__times, align 8
  %shl = shl i64 %21, 1
  store i64 %shl, ptr %__times, align 8
  %call104 = call i32 @cputime()
  %conv105 = sext i32 %call104 to i64
  store i64 %conv105, ptr %__t0, align 8
  store i64 0, ptr %__t, align 8
  br label %for.cond106

for.cond106:                                      ; preds = %for.inc119, %do.body103
  %22 = load i64, ptr %__t, align 8
  %23 = load i64, ptr %__times, align 8
  %cmp107 = icmp slt i64 %22, %23
  br i1 %cmp107, label %for.body109, label %for.end121

for.body109:                                      ; preds = %for.cond106
  %arraydecay110 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %smsg, i64 0, i64 0
  %arrayidx111 = getelementptr inbounds [1024 x [1 x %struct.__mpz_struct]], ptr %msg, i64 0, i64 0
  %arraydecay112 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx111, i64 0, i64 0
  %arraydecay113 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p, i64 0, i64 0
  %arraydecay114 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %q, i64 0, i64 0
  %arraydecay115 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pq, i64 0, i64 0
  %arraydecay116 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p_i_q, i64 0, i64 0
  %arraydecay117 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %dp, i64 0, i64 0
  %arraydecay118 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %dq, i64 0, i64 0
  call void @rsa_sign(ptr noundef %arraydecay110, ptr noundef %arraydecay112, ptr noundef %arraydecay113, ptr noundef %arraydecay114, ptr noundef %arraydecay115, ptr noundef %arraydecay116, ptr noundef %arraydecay117, ptr noundef %arraydecay118)
  br label %for.inc119

for.inc119:                                       ; preds = %for.body109
  %24 = load i64, ptr %__t, align 8
  %inc120 = add nsw i64 %24, 1
  store i64 %inc120, ptr %__t, align 8
  br label %for.cond106, !llvm.loop !9

for.end121:                                       ; preds = %for.cond106
  %call122 = call i32 @cputime()
  %conv123 = sext i32 %call122 to i64
  %25 = load i64, ptr %__t0, align 8
  %sub124 = sub nsw i64 %conv123, %25
  store i64 %sub124, ptr %__tmp, align 8
  br label %do.cond125

do.cond125:                                       ; preds = %for.end121
  %26 = load i64, ptr %__tmp, align 8
  %cmp126 = icmp slt i64 %26, 250
  br i1 %cmp126, label %do.body103, label %do.end128, !llvm.loop !10

do.end128:                                        ; preds = %do.cond125
  %27 = load i64, ptr %__tmp, align 8
  %conv129 = sitofp i64 %27 to double
  %28 = load i64, ptr %__times, align 8
  %conv130 = sitofp i64 %28 to double
  %div131 = fdiv double %conv129, %conv130
  store double %div131, ptr %t, align 8
  br label %do.end133

do.end133:                                        ; preds = %do.end128
  %call134 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  %29 = load double, ptr %t, align 8
  %div135 = fdiv double 1.000000e+04, %29
  %conv136 = fptoui double %div135 to i64
  store i64 %conv136, ptr %niter, align 8
  %30 = load i64, ptr %niter, align 8
  %cmp137 = icmp eq i64 %30, 0
  br i1 %cmp137, label %if.then139, label %if.end140

if.then139:                                       ; preds = %do.end133
  store i64 1, ptr %niter, align 8
  br label %if.end140

if.end140:                                        ; preds = %if.then139, %do.end133
  %31 = load i64, ptr %niter, align 8
  %call141 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, i64 noundef %31)
  %32 = load ptr, ptr @stdout, align 8
  %call142 = call i32 @fflush(ptr noundef %32)
  %call143 = call i32 @cputime()
  %conv144 = sext i32 %call143 to i64
  store i64 %conv144, ptr %t0, align 8
  %33 = load i64, ptr %niter, align 8
  store i64 %33, ptr %i, align 8
  br label %for.cond145

for.cond145:                                      ; preds = %for.inc158, %if.end140
  %34 = load i64, ptr %i, align 8
  %cmp146 = icmp ugt i64 %34, 0
  br i1 %cmp146, label %for.body148, label %for.end159

for.body148:                                      ; preds = %for.cond145
  %arraydecay149 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %smsg, i64 0, i64 0
  %35 = load i64, ptr %i, align 8
  %rem = urem i64 %35, 1024
  %arrayidx150 = getelementptr inbounds [1024 x [1 x %struct.__mpz_struct]], ptr %msg, i64 0, i64 %rem
  %arraydecay151 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %arrayidx150, i64 0, i64 0
  %arraydecay152 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p, i64 0, i64 0
  %arraydecay153 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %q, i64 0, i64 0
  %arraydecay154 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pq, i64 0, i64 0
  %arraydecay155 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %p_i_q, i64 0, i64 0
  %arraydecay156 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %dp, i64 0, i64 0
  %arraydecay157 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %dq, i64 0, i64 0
  call void @rsa_sign(ptr noundef %arraydecay149, ptr noundef %arraydecay151, ptr noundef %arraydecay152, ptr noundef %arraydecay153, ptr noundef %arraydecay154, ptr noundef %arraydecay155, ptr noundef %arraydecay156, ptr noundef %arraydecay157)
  br label %for.inc158

for.inc158:                                       ; preds = %for.body148
  %36 = load i64, ptr %i, align 8
  %dec = add i64 %36, -1
  store i64 %dec, ptr %i, align 8
  br label %for.cond145, !llvm.loop !11

for.end159:                                       ; preds = %for.cond145
  %call160 = call i32 @cputime()
  %conv161 = sext i32 %call160 to i64
  %37 = load i64, ptr %t0, align 8
  %sub162 = sub i64 %conv161, %37
  store i64 %sub162, ptr %ti, align 8
  %call163 = call i32 (ptr, ...) @printf(ptr noundef @.str.9)
  %38 = load i64, ptr %niter, align 8
  %conv164 = uitofp i64 %38 to double
  %mul = fmul double 1.000000e+03, %conv164
  %39 = load i64, ptr %ti, align 8
  %conv165 = uitofp i64 %39 to double
  %div166 = fdiv double %mul, %conv165
  store double %div166, ptr %ops_per_sec, align 8
  store double 1.000000e+02, ptr %f, align 8
  store i32 0, ptr %decimals, align 4
  br label %for.cond167

for.cond167:                                      ; preds = %for.inc173, %for.end159
  %40 = load double, ptr %ops_per_sec, align 8
  %41 = load double, ptr %f, align 8
  %cmp168 = fcmp ogt double %40, %41
  br i1 %cmp168, label %if.then170, label %if.end171

if.then170:                                       ; preds = %for.cond167
  br label %for.end175

if.end171:                                        ; preds = %for.cond167
  %42 = load double, ptr %f, align 8
  %mul172 = fmul double %42, 1.000000e-01
  store double %mul172, ptr %f, align 8
  br label %for.inc173

for.inc173:                                       ; preds = %if.end171
  %43 = load i32, ptr %decimals, align 4
  %inc174 = add nsw i32 %43, 1
  store i32 %inc174, ptr %decimals, align 4
  br label %for.cond167

for.end175:                                       ; preds = %if.then170
  %44 = load i32, ptr %decimals, align 4
  %45 = load double, ptr %ops_per_sec, align 8
  %call176 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, i32 noundef %44, double noundef %45)
  store i32 0, ptr %retval, align 4
  br label %return

return:                                           ; preds = %for.end175, %if.then
  %46 = load i32, ptr %retval, align 4
  ret i32 %46
}

declare i32 @fprintf(ptr noundef, ptr noundef, ...) #1

; Function Attrs: nounwind willreturn memory(read)
declare i32 @atoi(ptr noundef) #2

declare void @__gmp_randinit_default(ptr noundef) #1

declare void @__gmpz_init(ptr noundef) #1

declare i32 @printf(ptr noundef, ...) #1

declare i32 @fflush(ptr noundef) #1

declare void @__gmpz_urandomb(ptr noundef, ptr noundef, i64 noundef) #1

declare void @__gmpz_setbit(ptr noundef, i64 noundef) #1

declare void @__gmpz_gcd(ptr noundef, ptr noundef, ptr noundef) #1

; Function Attrs: nounwind willreturn memory(read)
declare i32 @__gmpz_cmp_ui(ptr noundef, i64 noundef) #2

declare void @__gmpz_mul(ptr noundef, ptr noundef, ptr noundef) #1

declare void @__gmpz_init_set_ui(ptr noundef, i64 noundef) #1

declare void @__gmpz_sub_ui(ptr noundef, ptr noundef, i64 noundef) #1

declare i32 @__gmpz_invert(ptr noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noreturn nounwind
declare void @abort() #3

; Function Attrs: nounwind willreturn memory(read)
declare i64 @__gmpz_sizeinbase(ptr noundef, i32 noundef) #2

declare void @__gmpz_mod(ptr noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @rsa_sign(ptr noundef %smsg, ptr noundef %msg, ptr noundef %p, ptr noundef %q, ptr noundef %pq, ptr noundef %p_i_q, ptr noundef %dp, ptr noundef %dq) #0 {
entry:
  %smsg.addr = alloca ptr, align 8
  %msg.addr = alloca ptr, align 8
  %p.addr = alloca ptr, align 8
  %q.addr = alloca ptr, align 8
  %pq.addr = alloca ptr, align 8
  %p_i_q.addr = alloca ptr, align 8
  %dp.addr = alloca ptr, align 8
  %dq.addr = alloca ptr, align 8
  %t = alloca [1 x %struct.__mpz_struct], align 16
  %o = alloca [1 x %struct.__mpz_struct], align 16
  %pr = alloca [1 x %struct.__mpz_struct], align 16
  %qr = alloca [1 x %struct.__mpz_struct], align 16
  %qr_m_pr = alloca [1 x %struct.__mpz_struct], align 16
  store ptr %smsg, ptr %smsg.addr, align 8
  store ptr %msg, ptr %msg.addr, align 8
  store ptr %p, ptr %p.addr, align 8
  store ptr %q, ptr %q.addr, align 8
  store ptr %pq, ptr %pq.addr, align 8
  store ptr %p_i_q, ptr %p_i_q.addr, align 8
  store ptr %dp, ptr %dp.addr, align 8
  store ptr %dq, ptr %dq.addr, align 8
  %arraydecay = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pr, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay)
  %arraydecay1 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %qr, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay1)
  %arraydecay2 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %qr_m_pr, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay2)
  %arraydecay3 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %t, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay3)
  %arraydecay4 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %o, i64 0, i64 0
  call void @__gmpz_init(ptr noundef %arraydecay4)
  %arraydecay5 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pr, i64 0, i64 0
  %0 = load ptr, ptr %msg.addr, align 8
  %1 = load ptr, ptr %dp.addr, align 8
  %2 = load ptr, ptr %p.addr, align 8
  call void @__gmpz_powm(ptr noundef %arraydecay5, ptr noundef %0, ptr noundef %1, ptr noundef %2)
  %arraydecay6 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %qr, i64 0, i64 0
  %3 = load ptr, ptr %msg.addr, align 8
  %4 = load ptr, ptr %dq.addr, align 8
  %5 = load ptr, ptr %q.addr, align 8
  call void @__gmpz_powm(ptr noundef %arraydecay6, ptr noundef %3, ptr noundef %4, ptr noundef %5)
  %arraydecay7 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %qr_m_pr, i64 0, i64 0
  %arraydecay8 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %qr, i64 0, i64 0
  %arraydecay9 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pr, i64 0, i64 0
  call void @__gmpz_sub(ptr noundef %arraydecay7, ptr noundef %arraydecay8, ptr noundef %arraydecay9)
  %arraydecay10 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %t, i64 0, i64 0
  %arraydecay11 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %qr_m_pr, i64 0, i64 0
  %6 = load ptr, ptr %p_i_q.addr, align 8
  call void @__gmpz_mul(ptr noundef %arraydecay10, ptr noundef %arraydecay11, ptr noundef %6)
  %arraydecay12 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %o, i64 0, i64 0
  %arraydecay13 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %t, i64 0, i64 0
  %7 = load ptr, ptr %q.addr, align 8
  call void @__gmpz_mod(ptr noundef %arraydecay12, ptr noundef %arraydecay13, ptr noundef %7)
  %arraydecay14 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %t, i64 0, i64 0
  %arraydecay15 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %o, i64 0, i64 0
  %8 = load ptr, ptr %p.addr, align 8
  call void @__gmpz_mul(ptr noundef %arraydecay14, ptr noundef %arraydecay15, ptr noundef %8)
  %9 = load ptr, ptr %smsg.addr, align 8
  %arraydecay16 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pr, i64 0, i64 0
  %arraydecay17 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %t, i64 0, i64 0
  call void @__gmpz_add(ptr noundef %9, ptr noundef %arraydecay16, ptr noundef %arraydecay17)
  %10 = load ptr, ptr %smsg.addr, align 8
  %11 = load ptr, ptr %smsg.addr, align 8
  %12 = load ptr, ptr %pq.addr, align 8
  call void @__gmpz_mod(ptr noundef %10, ptr noundef %11, ptr noundef %12)
  %arraydecay18 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %o, i64 0, i64 0
  call void @__gmpz_clear(ptr noundef %arraydecay18)
  %arraydecay19 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %t, i64 0, i64 0
  call void @__gmpz_clear(ptr noundef %arraydecay19)
  %arraydecay20 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %qr_m_pr, i64 0, i64 0
  call void @__gmpz_clear(ptr noundef %arraydecay20)
  %arraydecay21 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %qr, i64 0, i64 0
  call void @__gmpz_clear(ptr noundef %arraydecay21)
  %arraydecay22 = getelementptr inbounds [1 x %struct.__mpz_struct], ptr %pr, i64 0, i64 0
  call void @__gmpz_clear(ptr noundef %arraydecay22)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @cputime() #0 {
entry:
  %rus = alloca %struct.rusage, align 8
  %call = call i32 @getrusage(i32 noundef 0, ptr noundef %rus) #7
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

declare void @__gmpz_powm(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

declare void @__gmpz_sub(ptr noundef, ptr noundef, ptr noundef) #1

declare void @__gmpz_add(ptr noundef, ptr noundef, ptr noundef) #1

declare void @__gmpz_clear(ptr noundef) #1

; Function Attrs: nounwind
declare i32 @getrusage(i32 noundef, ptr noundef) #4

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind willreturn memory(read) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind willreturn memory(read) }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind }

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
