```
(define true #t)
(define false #f)

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

(print (list->tree '(1 3 5 7 9 11)))
```

前提として、

* 二進木の各節において、「左」リンクの先の節数が(n - 1) / 2時、釣合っている木だといえる。(全節数のうち、最上の節を除いて「右」リンクの先の節数と折半する)
* また、elements は順序づけられたリストなので、elementsのcdrのため手続き中引き回されるリストも順序が維持されている.

がある。

partial-tree の各ステップでは, 「左」リンク、「見出し」、「右」リンクを計算して最上の節を作成する。
この時、各節の「左」の節数が `(n - 1) / 2` とするため、「」左右の節数が釣り合った木が出来る。
また、 「左」リンク → 「見出し」 → 「右」リンクの順で elts から car するので、
`「左」リンクの節の「見出し」 < 「見出し」 < 「右」リンクの節の「見出し」` であり二進木の性質が守られる。
