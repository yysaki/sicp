(load "./3.5")

(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

; (expand 1 7 10)が次々と生じる要素は何か.

; (display-stream (stream-take (expand 1 7 10) 100))
; 1
; 4
; 2
; 8
; 5
; 7
; 1
; ...

; (expand 3 8 10)は何を生じるか.
(display-stream (stream-take (expand 3 8 10) 100))
; 3
; 7
; 5
; 0
; 0
; ...
