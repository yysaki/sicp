;add-streamsに似て, 二つのストリームの要素毎の積を生じる手続き mul-streamsを定義せよ.
; これとintegersストリームを使い, (0から数えて)n番目の要素がn + 1の階乗になる次のストリームの定義を完成せよ:


(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials (cons-stream 1 (mul-streams integers factorials)))
