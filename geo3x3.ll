

define dso_local i32 @encode(double %lat, double %lng, i8 %level, i8* %buff, i64 %buff.len) {
  %pret = alloca i32
  %pc.begin = getelementptr i8, i8* %buff, i8 0

  %level.64 = zext i8 %level to i64
  %cmp.levela = icmp ult i8 %level, 1 ;; when level too small
  %cmp.levelb = icmp uge i64 %level.64, %buff.len ;; when %buff.len not enough
  %cmp.levela.i8 = zext i1 %cmp.levela to i8
  %cmp.levelb.i8 = zext i1 %cmp.levelb to i8
  %cmp.level.i8 = add i8 %cmp.levela.i8, %cmp.levelb.i8 ;; or operation
  %cmp.level = icmp ne i8 %cmp.level.i8, 0
  br i1 %cmp.level, label %level.ng, label %level.ok



level.ng:
  store i8 0, i8* %pc.begin ;; terminate string
  store i32 1, i32* %pret ;; return 1
  br label %exit


level.ok:
  %plat = alloca double
  %plng = alloca double
  %punit = alloca double

  %lat0 = fadd double %lat, 90.0
  store double %lat0, double* %plat
  store double %lng, double* %plng
  store double 180.0, double* %punit

  %cmp.ew = fcmp oge double %lng, 0.0
  br i1 %cmp.ew, label %ew.east, label %ew.west



ew.east:
  store i8 69, i8* %pc.begin ;; 'E'
  br label %loop.init

ew.west:
  %lng0 = load double, double* %plng
  %lng1 = fadd double %lng0, 180.0
  store double %lng1, double* %plng
  store i8 87, i8* %pc.begin ;; 'W'
  br label %loop.init



loop.init:
  %pi = alloca i8
  store i8 1, i8* %pi
  br label %loop.main


loop.main:
  %i = load i8, i8* %pi
  %clat = load double, double* %plat
  %clng = load double, double* %plng
  %cunit = load double, double* %punit

  %nunit = fdiv double %cunit, 3.0
  %x0 = fdiv double %clng, %nunit
  %y0 = fdiv double %clat, %nunit
  %x = fptoui double %x0 to i8 ;; floor
  %y = fptoui double %y0 to i8 ;; floor
  %c0 = add i8 48, %x ;; '0'
  %ym = mul i8 %y, 3
  %c1 = add i8 %c0, %ym
  %c  = add i8 %c1, 1
  %pc = getelementptr i8, i8* %buff, i8 %i
  store i8 %c, i8* %pc

  %x1 = uitofp i8 %x to double
  %y1 = uitofp i8 %y to double
  %lng2 = fmul double %x1, %nunit
  %lat2 = fmul double %y1, %nunit
  %nlng = fsub double %clng, %lng2
  %nlat = fsub double %clat, %lat2

  store double %nunit, double* %punit
  store double %nlng, double* %plng
  store double %nlat, double* %plat

  %ni = add i8 %i, 1
  store i8 %ni, i8* %pi
  %cmp.i = icmp ult i8 %ni, %level
  br i1 %cmp.i, label %loop.main, label %loop.term


loop.term:
  %pc.end = getelementptr i8, i8* %buff, i8 %ni
  store i32 0, i8* %pc.end
  store i32 0, i32* %pret
  br label %exit



exit:
  %ret = load i32, i32* %pret
  ret i32 %ret
}


define dso_local i32 @decode(i8* %code, i64 %code.len,
                             double* %plat, double* %plng, i8* %plevel, double* %punit) {
  %pret = alloca i32
  %cmp.code = icmp eq i64 %code.len, 0
  br i1 %cmp.code, label %code.ng, label %code.ok


code.ng:
  store double 0.0, double* %plat
  store double 0.0, double* %plng
  store i8 0, i8* %plevel
  store double 0.0, double* %punit
  store i32 1, i32* %pret ;; return 1
  br label %exit

code.ok:
  %pbegin = alloca i64
  %pflg  = alloca i1
  store i64 0, i64* %pbegin
  store i1 0, i1* %pflg
  %pc.begin = getelementptr i8, i8* %code, i8 0
  %c.begin = load i8, i8* %pc.begin
  br label %check.west


check.west:
  %eq.minus    = icmp eq i8 %c.begin, 45 ;;'-'
  %eq.w        = icmp eq i8 %c.begin, 87 ;;'W'
  %eq.minus.i8 = zext i1 %eq.minus to i8
  %eq.w.i8     = zext i1 %eq.w to i8
  %cmp.west.i8 = add i8 %eq.minus.i8, %eq.w.i8 ;; or operation
  %cmp.west    = icmp ne i8 %cmp.west.i8, 0
  br i1 %cmp.west, label %ew.west, label %check.east

check.east:
  %eq.plus     = icmp eq i8 %c.begin, 43 ;;'+'
  %eq.e        = icmp eq i8 %c.begin, 69 ;;'E'
  %eq.plus.i8  = zext i1 %eq.plus to i8
  %eq.e.i8     = zext i1 %eq.e to i8
  %cmp.east.i8 = add i8 %eq.plus.i8, %eq.e.i8 ;; or operation
  %cmp.east    = icmp ne i8 %cmp.east.i8, 0
  br i1 %cmp.east, label %ew.east, label %loop.init


ew.west:
  store i64 1, i64* %pbegin
  store i1 1, i1* %pflg
  br label %loop.init

ew.east:
  store i64 1, i64* %pbegin
  br label %loop.init



loop.init:
  store double 180.0, double* %punit
  store double 0.0, double* %plat
  store double 0.0, double* %plng
  store i8 1, i8* %plevel

  %pi = alloca i64
  %begin = load i64, i64* %pbegin
  store i64 %begin, i64* %pi
  br label %loop.main


loop.main:
  %i = load i64, i64* %pi
  %pc = getelementptr i8, i8* %code, i64 %i
  %c = load i8, i8* %pc
  %n = sub i8 %c, 48 ;; '0'
  %n.lt.one     = icmp ult i8 %n, 1
  %n.gt.nine    = icmp ugt i8 %n, 9
  %n.lt.one.i8  = zext i1 %n.lt.one to i8
  %n.gt.nine.i8 = zext i1 %n.gt.nine to i8
  %cmp.n.i8     = add i8 %n.lt.one.i8, %n.gt.nine.i8 ;; or operation
  %cmp.n        = icmp ne i8 %cmp.n.i8, 0
  br i1 %cmp.n, label %loop.break, label %loop.continue


loop.break:
  store double 0.0, double* %plat
  store double 0.0, double* %plng
  store i8 0, i8* %plevel
  store double 0.0, double* %punit
  store i32 2, i32* %pret ;; return 2
  br label %exit


loop.continue:
  %cunit = load double, double* %punit
  %clat = load double, double* %plat
  %clng = load double, double* %plng
  %clevel = load i8, i8* %plevel

  %n1 = sub i8 %n, 1
  %nmod.i8 = urem i8 %n1, 3
  %ndiv.i8 = udiv i8 %n1, 3
  %nmod = uitofp i8 %nmod.i8 to double
  %ndiv = uitofp i8 %ndiv.i8 to double

  %nunit = fdiv double %cunit, 3.0
  store double %nunit, double* %punit

  %nmod1 = fmul double %nmod, %nunit
  %nlng = fadd double %clng, %nmod1
  store double %nlng, double* %plng

  %ndiv1 = fmul double %ndiv, %nunit
  %nlat = fadd double %clat, %ndiv1
  store double %nlat, double* %plat

  %nlevel = add i8 %clevel, 1
  store i8 %nlevel, i8* %plevel

  %ni = add i64 %i, 1
  store i64 %ni, i64* %pi
  %cmp.i = icmp ult i64 %ni, %code.len
  br i1 %cmp.i, label %loop.main, label %loop.term


loop.term:
  %unit0 = load double, double* %punit
  %lat0 = load double, double* %plat
  %lng0 = load double, double* %plng

  %unit1 = fdiv double %unit0, 2.0
  %lat1 = fadd double %lat0, %unit1
  %lng1 = fadd double %lng0, %unit1
  %lat2 = fsub double %lat1, 90.0

  store double %lat2, double* %plat
  store double %lng1, double* %plng

  %flg = load i1, i1* %pflg
  br i1 %flg, label %flg.true, label %flg.false



flg.true:
  %lng2 = fsub double %lng1, 180.0
  store double %lng2, double* %plng
  br label %flg.term

flg.false:
  br label %flg.term

flg.term:
  store i32 0, i32* %pret
  br label %exit



exit:
  %ret = load i32, i32* %pret
  ret i32 %ret
}
