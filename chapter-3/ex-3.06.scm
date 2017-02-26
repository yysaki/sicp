(define random-init 0)
(define (rand-update x) (+ x 1))

(define rand
  (let ((x random-init))
    (lambda (m)
      (cond ((eq? m 'generate) (set! x (rand-update x))
                               x)
            ((eq? m 'reset) (lambda (new-value) (set! x new-value)))
            (else (error "Unknown request -- RAND"
                         m))))
    ))

(print (rand 'generate))
(print (rand 'generate))
(print ((rand 'reset) 5))
(print (rand 'generate))
(print (rand 'generate))
