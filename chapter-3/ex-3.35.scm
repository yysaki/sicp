(load "./3.3.5")

(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
      (if (< (get-value b) 0)
        (error "square less than 0 -- SQUARER" (get-value b))
        (set-value! a (sqrt (get-value b)) me))
      (if (has-value? a)
        (set-value! b (expt (get-value a) 2) me))))
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    (process-new-value))
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))))
  (connect a me)
  (connect b me)
  me)


(define A (make-connector))
(define B (make-connector))
(squarer A B)

(probe "A" A)
(probe "B" B)

(set-value! A 4 'user)
(forget-value! A 'user)
(set-value! B 4 'user)
(forget-value! B 'user)

; Probe: A = 4
; Probe: B = 16
; Probe: A = ?
; Probe: B = ?
; Probe: B = 4
; Probe: A = 2
; Probe: B = ?
; Probe: A = ?
