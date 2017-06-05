; > Peter:	(set! balance (+ balance 10))
; > Paul:	(set! balance (- balance 20))
; > Mary:	(set! balance (- balance (/ balance 2)))
;
; > a. 銀行システムが三つのプロセスをある順序で逐次的に走らせるとした時, 三つの取引きの完了後, balanceの可能な値のすべてを書け. 
;
; Peter, Paul, Maryの操作をそれぞれ 1, 2, 3と置く。
;
; * 1 -> 2 -> 3: 100 -> 110 ->  90 ->  45
; * 1 -> 3 -> 2: 100 -> 110 ->  55 ->  35
; * 2 -> 1 -> 3: 100 ->  80 ->  90 ->  45
; * 2 -> 3 -> 1: 100 ->  80 ->  40 ->  50
; * 3 -> 1 -> 2: 100 ->  50 ->  60 ->  40
; * 3 -> 2 -> 1: 100 ->  50 ->  30 ->  40
;
; まとめると、 balanceの可能な値は 35, 40, 45, 50 となる。


; > b. システムがプロセスに混ざり合って進むことを許したら, 他にどういう値が生じ得るか. 図3.29のようなタイミング図を描き, それらの値がなぜ起き得るかを説明せよ. 
;
; 1-1. balanceの現在の値を取得する
; 1-2. 1-1の値に10足した値をbalanceに代入する
;
; 2-1. balanceの現在の値を取得する
; 2-2. 2-1の値に20引いた値をbalanceに代入する
;
; 3-1. balanceの現在の値を取得する
; 3-2. balanceの現在の値を取得する
; 3-3. 3-2の値から(3-1の値を2で割った)値を引いてbalanceに代入する
;
; 1~3をランダムに実行させてみるものが下記。
; 30, 35, 40, 45, 50, 55, 60, 80, 90, 110 といった値が計算されるのがわかる。

(use srfi-27)
(random-source-pseudo-randomize! default-random-source 314159 265358)

(define balance    0)
(define balance1   0)
(define balance2   0)
(define balance3-1 0)
(define balance3-2 0)

(define (act1-1) (set! balance1 balance))
(define (act1-2) (set! balance (+ balance1 10)))

(define (act2-1) (set! balance2 balance))
(define (act2-2) (set! balance (- balance2 20)))

(define (act3-1) (set! balance3-1 balance))
(define (act3-2) (set! balance3-2 balance))
(define (act3-3) (set! balance (- balance3-1 (/ balance3-1 2))))


(define (act-rand)
  (define (iter past-act act1 act2 act3)
    (if (and (null? act1) (null? act2) (null? act3))
      (print balance past-act)
      (let ((r (random-integer 3)))
        (cond ((= r 0)
               (if (null? act1)
                 (iter past-act act1 act2 act3)
                 (begin
                   ((car act1))
                   (iter (cons (car act1) past-act) (cdr act1) act2 act3))))
              ((= r 1)
               (if (null? act2)
                 (iter past-act act1 act2 act3)
                 (begin
                   ((car act2))
                   (iter (cons (car act2) past-act) act1 (cdr act2) act3))))
              (else
                (if (null? act3)
                  (iter past-act act1 act2 act3)
                  (begin
                    ((car act3))
                    (iter (cons (car act3) past-act) act1 act2 (cdr act3)))))))))
  (set! balance 100)
  (iter '()
        (list act1-1 act1-2)
        (list act2-1 act2-2)
        (list act3-1 act3-2 act3-3)))

(dotimes (1000) (act-rand))
