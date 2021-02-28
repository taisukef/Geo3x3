(load "geo3x3.lisp")

(defun main ()
  (progn
    (print (geo3x3::encode 35.65858 139.745433 14))
    (print (geo3x3::decode "E9139659937288"))
  )
)
