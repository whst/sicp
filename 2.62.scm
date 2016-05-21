(load "2.61.scm")

(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        (else (let ((h1 (car s1)) (t1 (cdr s1))
                    (h2 (car s2)) (t2 (cdr s2)))
                (cond ((< h1 h2) (cons h1 (union-set t1 s2)))
                      ((= h1 h2) (cons h1 (union-set t1 t2)))
                      ((> h1 h2) (cons h2 (union-set s1 t2))))))))