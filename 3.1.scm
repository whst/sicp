(define (make-accumulator n)
  (let ((sum n))
   (lambda (x)
     (begin (set! sum (+ sum x))
            sum))))
