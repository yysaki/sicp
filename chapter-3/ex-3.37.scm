(load "./3.3.5")

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z))

(define (c- x y)
  (let ((z (make-connector)))
    (adder z y x)
    z))

(define (c* x y)
  (let ((z (make-connector)))
    (multiplier x y z)
    z))

(define (c/ x y)
  (let ((z (make-connector)))
    (multiplier z y x)
    z))

(define (cv value)
  (let ((x (make-connector)))
    (constant value x)
    x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))

(define C (make-connector))
(define F (celsius-fahrenheit-converter C))

(probe "Celsius temp" C)
(probe "Fahrenheit temp" F)

(set-value! C 25 'user)
(forget-value! C 'user)
(set-value! F 212 'user)

; Probe: Celsius temp = 25
; Probe: Fahrenheit temp = 77
; Probe: Celsius temp = ?
; Probe: Fahrenheit temp = ?
; Probe: Fahrenheit temp = 212
; Probe: Celsius temp = 100
