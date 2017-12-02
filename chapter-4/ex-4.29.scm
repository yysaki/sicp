(load "./4.2")

; メモ化しないと, メモ化するより遥かに遅く走ると思われるプログラムを示せ.
; (define (force-it obj)
;   (if (thunk? obj)
;       (actual-value (thunk-exp obj) (thunk-env obj))
;       obj))
;
; (define (fib n)
;   (define (fib-iter a b count)
;     (if (= count 0)
;       b
;       (fib-iter (+ a b) a (- count 1))))
;   (fib-iter 1 0 n))
; (fib 10)

; また次の対話を考えよ. id手続きは問題4.27で定義したので, countは0から始る:

(driver-loop)

(define count 0)
(define (id x)
  (set! count (+ count 1))
  x)
(define (square x)
  (* x x))

; ;;; L-Eval input:
; (square (id 10))
;
; ;;; L-Eval value:
; 100
;
; ;;; L-Eval input:
; count
;
; ;;; L-Eval value:
; 1
