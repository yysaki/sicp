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

