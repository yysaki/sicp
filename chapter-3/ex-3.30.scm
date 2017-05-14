(define (ripple-carry-adder as bs ss c)
  (define (iter as bs ss ck-1)
    (if (not (null? as))
      (let ((ak (car as))
            (bk (car bs))
            (sk (car ss))
            (ck (make-wire)))
        (full-adder ak bk ck sk ck-1)
        (iter (cdr as) (cdr bs) (cdr ss) ck))))
  (let ((c-in (make-wire)))
    (full-adder (car as) (car bs) c-in (car ss) c)
    (iter (cdr as) (cdr bs) (cdr ss) c-in)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; 遅延時間の計算:
; 教科書の定数通り 1インバータ遅延(Di) = 2, 1アンドゲート遅延(Da) = 3, 1オアゲート遅延(Di) = 5とする.
;
; まず、半加算器のSおよびCが出力されるまでの遅延Dhs,  Dhcはそれぞれ,
; Dhs = max(Do, Da + Di) + Da = 8
; Dhc = Da = 3
; である.
;
; 次に全加算器のSUMおよびCoutが出力されるまでの遅延Dfs, Dfcはそれぞれ,
; Dfs = max(0, Dhs) + Dhs = 16
; Dfc = max(Dhs + Dhc, Dhc) + Do = 16

; となる.

; これよりn桁の繰上り伝播加算器の場合, 最大に遅延する回線はCまたはS1であり、それぞれが出力されるまでの遅延Drs, Drcは
; Drs = (n-1) * Dfc + Dfs = 16n
; Drc = (n-1) * Dfc + Dfc = 16n

; よって、n桁の繰上り伝播加算器から完全な出力が得られるまでの遅延は, 16n である.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "./3.3.4")

(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define a1 (make-wire))
(define a2 (make-wire))
(define a3 (make-wire))

(define b1 (make-wire))
(define b2 (make-wire))
(define b3 (make-wire))

(define s1 (make-wire))
(define s2 (make-wire))
(define s3 (make-wire))

(define as (list a1 a2 a3))
(define bs (list b1 b2 b3))
(define ss (list s1 s2 s3))
(define c (make-wire))

(probe 's1 s1)
(probe 's2 s2)
(probe 's3 s3)
(probe 'c c)

(set-signal! a1 1)
(set-signal! a2 1)
(set-signal! a3 1)
(set-signal! b1 0)
(set-signal! b2 0)
(set-signal! b3 1)
(propagate)

(ripple-carry-adder as bs ss c)
(propagate)
