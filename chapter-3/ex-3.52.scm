(load "./3.5")

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
(define y (stream-filter even? seq))
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
; seq: 1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190 210


(display-stream z)

; 上の各式が評価し終った時, sumの値は何か.
; 210

; stream-refとdisplay-stream式の評価に応じて印字される応答は何か.
(stream-ref y 7)
; 136


(display-stream z)
; 10
; 15
; 45
; 55
; 105
; 120
; 190
; 210

; ;この応答は(delay ⟨exp⟩)を単に(lambda () ⟨exp⟩)で実装し, memo-procの用意する最適化を使わなかった時とどう違うか. 説明せよ.

; メモ化しない場合、stream-cdr の呼び出しごとに再度同じ計算を行うので、sumの値が変わってくる。
