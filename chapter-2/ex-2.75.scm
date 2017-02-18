(define (apply-generic op arg) (arg op))

(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'real-part)
           (* r (cos a)))
          ((eq? op 'imag-part)
           (* r (sin a)))
          ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          (else
           (error "Unknown op -- MAKE-FROM-MAG-ANG" op))))
  dispatch)

;(define z (make-from-mag-ang 5 (* 3.14 0.5)))
;(print (apply-generic 'real-part z))
;; 0.003981633553666317
;
;(print (apply-generic 'imag-part z))
;
;; 4.999998414659173
;
;(print (apply-generic 'magnitude z))
;; 5
;
;(print (apply-generic 'angle z))
;; 1.57

