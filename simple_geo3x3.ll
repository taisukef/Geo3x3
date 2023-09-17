;; llc -filetype=obj geo3x3.ll
;; lli --extra-object=geo3x3.o simple_geo3x3.ll

declare dso_local i32 @printf(i8*, ...)
declare dso_local i64 @strlen(i8*)

declare dso_local i32 @encode(double %lat, double %lng, i8 %level,
                              i8* %buff, i64 %buff.len)
declare dso_local i32 @decode(i8* %code, i64 %code.len,
                              double* %plat, double* %plng, i8* %plevel, double* %punit)

@.format.encode = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@.format.decode = private unnamed_addr constant [16 x i8] c"%lf %lf %u %lf\0A\00"
@.str.code = private unnamed_addr constant [15 x i8] c"E9139659937288\00"

define dso_local i32 @main(i32 %argc, i8** %argv) {

  ;; call encode
  %buff = alloca [32 x i8]
  call i32 @encode(double 35.65858, double 139.745433, i8 14, i8* %buff, i64 32)
  call i32 (i8*, ...) @printf(i8* @.format.encode, i8* %buff)

  ;; call decode
  %pcode = alloca i8*
  store i8* @.str.code, i8** %pcode
  %code = load i8*, i8** %pcode
  %code.len = call i64 @strlen(i8* %code)
  %plat = alloca double
  %plng = alloca double
  %plevel = alloca i8
  %punit = alloca double
  call i32 @decode(i8* %code, i64 %code.len,
                   double* %plat, double* %plng, i32* %plevel, double* %punit)
  %lat = load double, double* %plat
  %lng = load double, double* %plng
  %level = load i8, i8* %plevel
  %unit = load double, double* %punit
  call i32 (i8*, ...) @printf(i8* @.format.decode,
                              double %lat, double %lng, i8 %level, double %unit)

  ret i32 0
}
