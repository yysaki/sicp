(load "./4.1")

(define (make-frame variables values)
  (map cons variables values))
(define (frame-variables frame) (print frame) (map car frame))
(define (frame-values frame) (map cdr frame))

(define (add-binding-to-frame! var val frame)
  (set-cdr! frame (cons (cons var val) (cdr frame))))

(define the-global-environment (setup-environment))

(driver-loop)
