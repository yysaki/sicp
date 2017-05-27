(load "./3.3.5")

(define (avarager a b c)
  (let ((x (make-connector))
        (y (make-connector)))
    (adder a b x)
    (multiplier c y x)
    (constant 2 y)
    'ok))


(define A (make-connector))
(define B (make-connector))
(define C (make-connector))
(avarager A B C)

(probe "A" A)
(probe "B" B)
(probe "C" C)

(set-value! A 3 'user)
(set-value! B 5 'user)

; Probe: A = 3
; Probe: B = 5
; Probe: C = 4
