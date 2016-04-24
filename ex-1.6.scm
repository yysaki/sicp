; http://sicp.iijlab.net/fulltext/x117.html

; Alyssa P. Hackerはifが特殊形式である理由が分らない. 「cond を利用し, 普通の手続きとして定義してはいけないの?」と聞いた. Alyssaの友人のEva Lu Atorはそうすることはもちろん出来るといって, ifの新版を定義した:
;
; (define (new-if predicate then-clause else-clause)
;   (cond (predicate then-clause)
;         (else else-clause)))
;
; EvaはAlyssaにプログラムを見せた:
;
; (new-if (= 2 3) 0 5)
; 5
;
; (new-if (= 1 1) 0 5)
; 0
;
; Alyssaは喜び, 平方根のプログラムを書き直すのにnew-ifを使った:
;
; (define (sqrt-iter guess x)
;   (new-if (good-enough? guess x)
;           guess
;           (sqrt-iter (improve guess x)
;                       x)))
; Alyssaが平方根を計算するのにこれを使おうとすると, 何が起きるか, 説明せよ.

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (square x)
  (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

(define (sqrt x)
  (sqrt-iter 1.0 2))

; (print (sqrt 2))

; 無限ループに陥る.
; `new-if` を使用する場合、作用的順序により `good-enough?` の評価が #t であっても代替式部分が評価されるため, ループが停止しない.
; 一方 特殊形式の `if` であれば, `good-enough?` の評価が #t の時停止することができる.
