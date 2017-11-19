; このどの見方を(あるとすれば)支持するか.

; Eva > Alyssa > Ben の順に支持する.
; defineより下のフレームと内部定義のa がある場合, 同時有効範囲の観点から後者を採用すべき, そうでないと不明瞭な動作にバグの要因となりそう.
; できればEvaの実装がとれればよいが, それが難しければ最低限Alyssaのようにエラーとすべき.

; Evaが好むように振舞うよう, 内部定義を実装する方法が考えられるか.26

; http://practical-scheme.net/wiliki/wiliki.cgi?Scheme%3A内部defineの評価順 にある通り, 現行Gaucheでは20を戻す

(let ((a 1))
  (define (f x)
    (define b (+ a x))
    (define a 5)
    (+ a b))
  (f 10))
