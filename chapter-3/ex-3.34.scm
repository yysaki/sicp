(load "./3.3.5")

(define (squarer a b)
  (multiplier a a b))

(define A (make-connector))
(define B (make-connector))
(squarer A B)

(probe "A" A)
(probe "B" B)

(set-value! A 4 'user)
(forget-value! A 'user)
(set-value! B 4 'user)
(forget-value! B 'user)

; A に値が設定すればBは問題なくset-value!されるが
; B に値を設定してもAにset-value!されることがない.
; (and (has-value? product) (has-value? m1)), (and (has-value? product) (has-value? m2)) どちらも常に偽のため.
