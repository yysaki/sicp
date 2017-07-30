(load "./3.5")

(use slib)
(require 'trace)

(define (myadd a b)
  (print a "+" b "=" (+ a b))
  (+ a b))

(define (add-streams s1 s2)
  (stream-map myadd s1 s2))

(define fibs
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs)
                                         fibs))))
; (print (stream-ref fibs 10))

; add-streams手続きに基づくfibsの定義を使い, n番目のFibonacci数を計算する時, 加算は何回実行されるか.
; n回実行される.

; 3.5.1節に述べたmemo-proc手続きが用意する最適化を使わずに(delay ⟨exp⟩) を単に(lambda () ⟨exp⟩)と実装したとすると, 加算の回数は指数的に大きくなることを示せ.

; 3.5.scmの以下を有効にする
; (define-syntax delay
;   (syntax-rules ()
;     ((_ exp) (lambda () exp))))

(stream-ref fibs 8)

