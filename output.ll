ERROR: Timeout

; ModuleID = '<stdin>'
source_filename = "<stdin>"

define void @foo(i32 %0, i32 %1, i32 %2, i32 %3, ptr nocapture %4) {
  %6 = add nsw i32 %2, %0
  %7 = mul nsw i32 %6, %0
  store i32 %7, ptr %4, align 4
  %8 = add nsw i32 %3, %1
  %9 = mul nsw i32 %8, %1
  %10 = getelementptr inbounds i32, ptr %4, i64 1
  store i32 %9, ptr %10, align 4
  %11 = getelementptr inbounds i32, ptr %4, i64 2
  store i32 %7, ptr %11, align 4
  %12 = getelementptr inbounds i32, ptr %4, i64 3
  store i32 %9, ptr %12, align 4
  ret void
}
