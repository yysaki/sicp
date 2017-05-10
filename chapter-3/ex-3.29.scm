(load "./3.3.4")

(define (or-gate s1 s2 output)
  (let ((i1 (make-wire))
        (i2 (make-wire))
        (a  (make-wire)))
    (inverter s1 i1)
    (inverter s2 i2)
    (and-gate i1 i2 a)
    (inverter a output))
  'ok)

; 遅延時間:
; (+ (* 3 inverter-delay)
;    (+ 1 * and-gate-delay))
;
; ただし、(inverter s1 i1) と (inverter s2 i2) が同時にadd-action!するならば1 inverter-delay分遅延が少なくなる.

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

(test 1 1)
