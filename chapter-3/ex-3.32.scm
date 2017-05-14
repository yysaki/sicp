(load "./3.3.4")

(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)

(define a1 (make-wire))
(define a2 (make-wire))
(define output (make-wire))

(and-gate a1 a2 output)

(probe 'a1 a1)
(probe 'a2 a2)
(probe 'output output)

(set-signal! a1 0)
(set-signal! a2 1)

(propagate)

(set-signal! a1 1)
(set-signal! a2 0)

(propagate)


; outputに関して同じ区分内に下記の順にactionがadd-to-agenda!される.
; (a1, a2) = (1, 1) => (set-signal! output 1)
; (a1, a2) = (1, 0) => (set-signal! output 0)
;
; もし最後に入ったものが最初に出るデータ構造に保存されていた場合(LIFO)、
; outputを0に設定 => outputを1に設定の順となり誤った結果となってしまう.
; そのため、各区分の手続きは次第書きに追加された順に実行されなければならない。
