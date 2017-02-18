(load "./ex-2.46")

(define (make-segment v1 v2)
  (list v1 v2))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cadr segment))
