(load "./3.5")

(define sense-data
  (make-stream '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4)))

(define (sign-change-detector input-value last-value)
  (cond ((and (>= input-value 0) (< last-value 0)) 1)
        ((and (< input-value 0) (>= last-value 0)) -1)
        (else 0)))

; (define (make-zero-crossings input-stream last-value)
;   (cons-stream
;     (sign-change-detector (stream-car input-stream) last-value)
;     (make-zero-crossings (stream-cdr input-stream)
;                          (stream-car input-stream))))
;
; (define zero-crossings (make-zero-crossings sense-data 0))

(define zero-crossings
  (stream-map sign-change-detector sense-data (cons-stream 0 sense-data)))

(display-stream (stream-take zero-crossings 12))
