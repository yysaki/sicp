(load "./4.1")

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list 'map map)))

; Eva Lu AtorとLouis Reasonerはそれぞれ超循環評価器の実験をしていた.
; Eva はmapの定義を入力し, それを使うテストプログラムをいくつか走らせた.
; それはうまく動いた.
; 反対にLouisはmapのシステム版を超循環評価器の基本手続きとして組み込んだ.
; 彼がやってみると, 非常におかしい.
; Evaのは動いたのに, Louisのmapは失敗した理由を説明せよ.

(define the-global-environment (setup-environment))
(driver-loop)
; (map car '((a b) (c d) (e f)))
; *** ERROR: invalid application: ((primitive #<subr (car obj)>) (a b))

; map の第一引数に基本手続きを渡すと、'primitive タグが剥がれないまま apply-in-underlying-scheme 中 に適用されるため.
