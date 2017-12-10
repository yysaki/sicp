; 遅延評価は並びの中の式を強制しないので, 副作用のいくつかは生じないのではないか

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (actual-value (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

; a

(define (for-each proc items)
  (if (null? items)
      'done
      (begin (proc (car items))
             (for-each proc (cdr items)))))

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

; この時のprocは (lambda (x) (newline) (display x) は基本手続きのため、正しく順番通りに評価される.


; b

(define (p1 x)
  (set! x (cons x '(2)))
  x)

(define (p2 x)
  (define (p e)
    e
    x)
  (p (set! x (cons x '(2)))))

; (p1 1) set!は基本手続きのため呼び出される. 結果はどちらも2
; (p2 1) eは合成手続きのため遅延評価器では評価されない. 結果は1, Cy版では2


; c

; a ではprocに渡る式が基本手続きのため、遅延評価器でもCy版でも常に評価されるため.

; d. 遅延評価器で並びはどう扱うべきと考えるか. Cyの解決法は好きか. 本文の解決法, あるいは他の解決法はどうか.

; 遅延評価器では並びの中の式が必要なければ評価されない.
; それによりCyが指摘するよう副作用のある式が呼びだされないことがある.
; 遅延評価器ではそもそも服作用のある式を書かないスタイルで書くべきと考えるため、
; 服作用の順番を気にするCyの解決法は好みでない.
; もし解決したいのであれば、評価方法を従来のものか遅延評価か選べるオプションを渡せるようにすることが考えられる.

