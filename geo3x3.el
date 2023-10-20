;;; geo3x3.el --- A simple geo-coding system for WGS84  -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Taisuke Fukuno

;; Author: Taisuke Fukuno
;; Keywords: lisp, convenience
;; License: CC0-1.0

;; CC0 1.0 Universal

;; By marking the work with a CC0 public domain dedication, the creator is giving
;; up their copyright and allowing reusers to distribute, remix, adapt, and build
;; upon the material in any medium or format, even for commercial purposes.

;;; Commentary:

;; Geo3x3 is a simple geo-coding system for WGS84.

;;; Code:


;; encoder
(defun geo3x3--encode-1 (code level i lat lng unit)
  "Internal function to encode CODE, LEVEL, I, LAT, LNG and UNIT."
  (if (>= i level)
      code
    (geo3x3--encode-1
     (concat code (int-to-string(+ 1 (floor (/ lng unit)) (* (floor (/ lat unit)) 3))))
     level
     (+ i 1)
     (- lat (* (floor (/ lat unit)) unit))
     (- lng (* (floor (/ lng unit)) unit))
     (/ unit 3.0))))

;;;###autoload
(defun geo3x3-encode (lat lng level)
  "Encode Geo3x3 by LAT, LNG and LEVEL."
  (if (< level 1)
      ""
    (geo3x3--encode-1
     (if (>= lng 0.0) "E" "W")
     level
     1
     (+ lat 90.0)
     (if (>= lng 0.0) lng (+ lng 180.0))
     (/ 180.0 3.0))))

;; decoder
(defsubst geo3x3--is-1to9 (string)
  "Return non-NIL when STRING matches 1 to 9."
  (string-match-p (eval-when-compile (rx bos (in "123456789") eos)) string))

(defun geo3x3--decode-1 (code lat lng level unit)
  "Internal function to decode CODE, LAT, LNG, LEVEL and UNIT."
  (if (or (= (length code) 0) (not (geo3x3--is-1to9 (car code))))
      (list (- (+ lat (/ (* unit 3.0) 2.0)) 90.0) (+ lng (/ (* unit 3.0) 2.0)) level (* unit 3.0))
    (let (n)
      (setq n (- (string-to-number (car code)) 1))
      (geo3x3--decode-1
       (cdr code)
       (+ lat (* (floor (/ n 3)) unit))
       (+ lng (* (floor (mod n 3)) unit))
       (+ level 1)
       (/ unit 3.0)))))

(defsubst geo3x3--decode-1e (code)
  "Internal function to decode CODE for eastern hemisphere."
  (geo3x3--decode-1 code 0.0 0.0 1 (/ 180.0 3.0)))

(defun geo3x3--decode-1w (code)
  "Internal function to decode CODE for western hemisphere."
  (let ((pos (geo3x3--decode-1e code)))
    (list (nth 0 pos)
          (- (nth 1 pos) 180.0)
          (nth 2 pos)
          (nth 3 pos))))

;;;###autoload
(defun geo3x3-decode (scode)
  "Decode Geo3x3 by SCODE string."
  (let ((code (reverse (cdr (reverse (cdr (split-string scode "")))))))
    (if (= (length code) 0)
        (list 0.0 0.0 0 180.0)          ; err
      (if (string= (car code) "W")
          (geo3x3--decode-1w (cdr code))
        (geo3x3--decode-1e (cdr code))))))

(provide 'geo3x3)
;;; geo3x3.el ends here
