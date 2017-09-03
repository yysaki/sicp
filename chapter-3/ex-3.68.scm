(load "./3.5")

(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                t)
    (pairs (stream-cdr s) (stream-cdr t))))

(display-stream (stream-take (pairs integers integers) 1000))

; これは動くか. Louisのpairsの定義を使って(pairs integers integers)を評価すると, 何が起きるか考えよ. 

; cons-streamがないためinterleaveの引数が評価された時に無限ループに陥る

