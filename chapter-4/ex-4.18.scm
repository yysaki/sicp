; この手続きはこの問題で示したように内部定義を掃き出しても動くだろうか.
(define (solve f y0 dt)
  (let ((y '*unassigned*)
        (dy '*unassigned*))
    (let ((a (integral (delay dy) y0 dt))
          (b (stream-map f y)))
      (set! y a)
      (set! dy b))
    y))

; 動かない. 二回目のletのa,b の設定時点で評価が行われ, y, dyが '*unassigned* を指すため.

; 本文に示したように掃き出したらどうか. 説明せよ.

(define (solve f y0 dt)
  (let ((y '*unassigned*)
        (dy '*unassigned*))
    (set! y (integral (delay dy) y0 dt))
    (set! dy (stream-map f y))
    y))

; こちらは動く.
