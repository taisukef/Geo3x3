(module
  (import "console" "log" (func $log (param i32 i32)))
  (import "console" "log_f32" (func $log_f32 (param f32)))
  (import "console" "log_i32" (func $log_i32 (param i32)))
  (import "js" "mem" (memory 1))

  (func $encode (export "encode") (param $lat f32) (param $lng f32) (param $level i32)
    (local $unit f32)
    (local $i i32)
    (local $x i32)
    (local $y i32)
    (local $n i32)
    (i32.store8 (i32.const 0) (i32.const 69)) ;; 69='E'
    (if (f32.le (local.get $lng) (f32.const 0.0))
      (then
        (i32.store8 (i32.const 0) (i32.const 87)) ;; 87='W'
        (local.set $lng (f32.add (local.get $lng) (f32.const 180.0)))
      )
    )
    (local.set $lat (f32.add (local.get $lat) (f32.const 90.0)))
    (local.set $unit (f32.const 180.0))
    (local.set $i (i32.const 1))
    (block $block (loop $loop
      (br_if $block (i32.ge_u (local.get $i) (local.get $level)))
      (local.set $unit (f32.div (local.get $unit) (f32.const 3.0)))
      (local.set $x (i32.trunc_f32_u (f32.div (local.get $lng) (local.get $unit))))
      (local.set $y (i32.trunc_f32_u (f32.div (local.get $lat) (local.get $unit))))
      (local.set $n (i32.add (local.get $x) (i32.mul (local.get $y) (i32.const 3))))
      (local.set $n (i32.add (local.get $n) (i32.const 49))) ;; 49='1'
      (i32.store8 (local.get $i) (local.get $n))
      (local.set $lng (f32.sub (local.get $lng) (f32.mul (f32.convert_i32_u (local.get $x)) (local.get $unit))))
      (local.set $lat (f32.sub (local.get $lat) (f32.mul (f32.convert_i32_u (local.get $y)) (local.get $unit))))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br $loop)
    ))
  )

  (func $decode (export "decode")
    (local $flg i32)
    (local $begin i32)
    (local $c i32)
    (local $unit f32)
    (local $lat f32)
    (local $lng f32)
    (local $level i32)
    (local $i i32)
    (local $n i32)
    
    (local.set $flg (i32.const 0))
    (local.set $begin (i32.const 0))
    (local.set $c (i32.load8_u (i32.const 0)))
    (if (i32.eq (local.get $c) (i32.const 87)) ;; 87='W'
      (then
        (local.set $flg (i32.const 1))
        (local.set $begin (i32.const 1))
      )
      (else
        (local.set $begin (i32.const 1))
      )
    )
    (local.set $unit (f32.const 180.0))
    (local.set $lat (f32.const 0.0))
    (local.set $lng (f32.const 0.0))
    (local.set $level (i32.const 1))
    (local.set $i (local.get $begin))
    (block $block (loop $loop
      (local.set $n (i32.load8_u (local.get $i)))
      (br_if $block (i32.eq (local.get $n) (i32.const 0)))
      (local.set $n (i32.sub (local.get $n) (i32.const 49))) ;; 49='1'
      (local.set $unit (f32.div (local.get $unit) (f32.const 3.0)))
      (local.set $lng (f32.add (local.get $lng) (f32.mul (f32.convert_i32_u (i32.rem_u (local.get $n) (i32.const 3))) (local.get $unit))))
      (local.set $lat (f32.add (local.get $lat) (f32.mul (f32.convert_i32_u (i32.div_u (local.get $n) (i32.const 3))) (local.get $unit))))
      (local.set $level (i32.add (local.get $level) (i32.const 1)))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br $loop)
    ))
    (local.set $lat (f32.add (local.get $lat) (f32.div (local.get $unit) (f32.const 2.0))))
    (local.set $lng (f32.add (local.get $lng) (f32.div (local.get $unit) (f32.const 2.0))))
    (local.set $lat (f32.sub (local.get $lat) (f32.const 90.0)))
    (if (i32.eq (local.get $flg) (i32.const 1))
      (then
        (local.set $lng (f32.sub (local.get $lng) (f32.const 180.0)))
      )
    )
    (f32.store (i32.const 0) (local.get $lat))
    (f32.store (i32.const 4) (local.get $lng))
    (f32.store (i32.const 8) (f32.convert_i32_u (local.get $level)))
    (f32.store (i32.const 12) (local.get $unit))
  )
  (func (export "main")
    (f32.const 35.65858)
    (f32.const 139.745433)
    (i32.const 14)
    (call $encode)
    (call $log (i32.const 0) (i32.const 14))

    (call $decode)
    (call $log_f32 (f32.load (i32.const 0)))
    (call $log_f32 (f32.load (i32.const 4)))
    (call $log_f32 (f32.load (i32.const 8)))
    (call $log_f32 (f32.load (i32.const 12)))
  )
)
