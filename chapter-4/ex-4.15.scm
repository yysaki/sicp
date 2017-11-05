(define (run-forever) (run-forever))

(define (try p)
  (if (halts? p p)
      (run-forever)
      'halted))

(try try)

; さて, 式(try try)の評価を考え, (停止するか永遠に走るか)可能な結果がhalts?の意図した行動と矛盾することを示せ.

; (try try) を実行した時halts?が真であると仮定した場合、run-foreverが走り、停止しない.
; 一方偽であると仮定した場合、'haltedが戻り停止する.
; halts? が「停止するか？」戻した結果と動作が矛盾するため、halts?は書くことができない.

