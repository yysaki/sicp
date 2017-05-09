(load "./3.3.4")

(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value
            (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

(define (logical-or s1 s2)
  (cond ((and (= s1 0) (= s2 0)) 0)
        ((and (= s1 0) (= s2 1)) 1)
        ((and (= s1 1) (= s2 0)) 1)
        ((and (= s1 1) (= s2 1)) 1)
        (else (error "Invalid signal" s1 s2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define a1 (make-wire))
(define a2 (make-wire))
(define output (make-wire))

(or-gate a1 a2 output)

(probe 'a1 a1)
(probe 'a2 a2)
(probe 'output output)
(propagate)

(define (test v1 v2)
  (set-signal! a1 v1)
  (set-signal! a2 v2)
  (propagate)
  (newline))

(test 0 0)
(test 0 1)
(test 1 0)
(test 1 1)
