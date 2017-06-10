; 次の
; (define x 10)
; 
; (parallel-execute (lambda () (set! x (* x x)))
;                   (lambda () (set! x (* x x x))))
; の実行の結果となり得るxの可能性をすべて述べよ.

* 100
* 1000
* 10000
* 100000
* 1000000

; 直列化した手続き:
; (define x 10)
; 
; (define s (make-serializer))
; 
; (parallel-execute (s (lambda () (set! x (* x x))))
;                   (s (lambda () (set! x (* x x x)))))
; を使うと, これらの可能性のうち, どれが残るか. 

* 1000000
