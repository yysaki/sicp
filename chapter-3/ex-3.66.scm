(load "./3.5")

(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

(display-stream (stream-take (pairs integers integers) 1000))

; 例えば対(1, 100), 対(99, 100), 対(100, 100)の前に近似的に何個の対が来るか. (数学的な厳密な表現が出来れば大いによい. しかし分らなくなったら, 定性的な答を出すのでもよい.) 
; (1, 100) (2, 50) (3, 25) (4, 12) (5, 6) (6, 3), (7, 2) (8, 1)

; 対(1, 100) = 195番目

; 対(i, i) = 2^i+1 番目
; 対(i, i+1) = 対(i, i+1) + 2^(i-1) 番目
; よって
; 対(99,100)
; = 対(99,99) + 2^(99-1)
; = 2^(99)+1 + 2^(98)
; = 950737950171172051122527404033
; 対(100,100)
; = 2^100+1
; = 1267650600228229401496703205377
