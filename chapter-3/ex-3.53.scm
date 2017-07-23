(load "./3.5")

; プログラムを走らせずに
; (define s (cons-stream 1 (add-streams s s)))
; で定義するストリームの要素を述べよ.

(define s (cons-stream 1 (add-streams s s)))

(display-stream (stream-take s 10))
; 1
; 2
; 4
; 8
; 16
; 32
; 64
; 128
; 256
; 512
