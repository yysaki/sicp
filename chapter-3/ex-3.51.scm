(define (show x)
  (display-line x)
  x)
; 次のそれぞれの式の評価に応じて, 解釈系は何を印字するか.
(define x (stream-map show (stream-enumerate-interval 0 10)))
; 0

(stream-ref x 5)
; 1
; 2
; 3
; 4
; 5

(stream-ref x 7)
; 6
; 7
