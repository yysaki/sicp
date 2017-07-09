(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (stream-cdr) (partial-sums s))))
