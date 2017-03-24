(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr  '()))
    (define (dispatch m)
      (cond ((eq? m 'front-ptr) front-ptr)
            ((eq? m 'rear-ptr)  rear-ptr)
            ((eq? m 'set-front-ptr!) (lambda (v) (set! front-ptr v)))
            ((eq? m 'set-rear-ptr!)  (lambda (v) (set!  rear-ptr v)))
            ((eq? m 'empty-queue?) (null? front-ptr))
            ((eq? m 'front-queue) (if (null? front-ptr)
                                    (error "FRONT called with an empty queue")
                                    (car front-ptr)))
            ((eq? m 'insert-queue!) (lambda (item)
                                      (let ((new-pair (cons item '())))
                                       (cond ((null? front-ptr)
                                              (set! front-ptr new-pair)
                                              (set! rear-ptr new-pair)
                                              front-ptr)
                                             (else
                                               (set-cdr! rear-ptr new-pair)
                                               (set! rear-ptr new-pair)
                                               front-ptr)))))
            ((eq? m 'delete-queue!) (cond ((null? front-ptr)
                                           (error "DELETE! called with empty queue"))
                                          (else
                                            (set! front-ptr (cdr front-ptr))
                                            front-ptr)))))
    dispatch))

(define (front-ptr queue) (queue 'front-ptr))
(define (rear-ptr queue) (queue 'rear-ptr))
(define (set-front-ptr! queue v) ((queue 'set-front-ptr!) v))
(define (set-rear-ptr! queue v) ((queue 'set-rear-ptr!) v))
(define (empty-queue? queue) (queue 'empty-queue?))
(define (front-queue queue) (queue 'front-queue))
(define (insert-queue! queue item) ((queue 'insert-queue!) item))
(define (delete-queue! queue) (queue 'delete-queue!))