(load "./3.5")

(define (rand-update x) (+ x 1))

(define (rand input-stream random-init)
  (define random-stream
    (if (stream-null? input-stream)
      the-empty-stream
      (cons-stream
        (let ((m (stream-car input-stream)))
          (cond ((eq? m 'generate) (rand-update random-init))
                ((number? m) (rand-update m))
                (else (error "Unknown request -- RAND" m))))
        (rand (stream-cdr input-stream) (stream-car random-stream)))))
  random-stream)

(define stream (list->stream (list 'generate 'generate 5 'generate 'generate)))
(display-stream (rand stream 10))
