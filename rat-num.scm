(load "gcd.scm")

;; constructor and selectors
(define (make-rat n d)
  (let ((abs-n  (abs   n))
        (abs-d  (abs   d))
        (g      (gcd n d)))
    (cons (/ abs-n (if (positive? (/ n d))
                     g
                     (- g)))
          (/ abs-d g))))
(define numer car)
(define denom cdr)

;; operations
(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x)))
(define
 (make-rat 2 3))
