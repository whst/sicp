(define *coercion-table* (make-hash-table))
(define (put-coercion src dest proc)
  (hash-table/put! *coercion-table* (list src dest) proc))
(define (get-coercion src dest)
   (hash-table/get *coercion-table* (list src dest) #f))

(load "arithmetic.scm")

(install-polar-package)
(install-rectangular-package)
(install-complex-package)
(install-rational-package)
(install-scheme-number-package)

(define (scheme-number->complex n)
  (make-complex-from-real-imag (contents n) 0))

(put-coercion 'scheme-number 'complex scheme-number->complex)

(define (apply-generic op . args)
  (let* ((type-tags (map type-tag args))
         (proc (get op type-tags)))
    (if proc
      (apply proc (map contents args))
      (if (= (length args) 2)
        (let* ((type1 (car type-tags))
               (type2 (cadr type-tags))
               (a1 (car args))
               (a2 (cadr args))
               (t1->t2 (get-coercion type1 type2))
               (t2->t1 (get-coercion type2 type1)))
          (cond (t1->t2 (apply-generic op (t1->t2 a1) a2))
                (t2->t1 (apply-generic op a1 (t2->t1 a2)))
                (else (error "No method for these types" (list op type-tags)))))
        (error "No method for these types" (list op type-tags))))))
