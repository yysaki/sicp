(define (make-accumulator sum)
  (lambda (x)
    (set! sum (+ sum x))
    sum))

(define A (make-accumulator 5))
(print (A 10))
(print (A 15))

