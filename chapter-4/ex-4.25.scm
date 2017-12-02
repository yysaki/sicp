(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1))

(print (factorial 5))

; 作用的順序では (* n (factorial (- n 1))) が常に評価されるため無限ループする.
; 正規順序の言語ならば停止するはず.
