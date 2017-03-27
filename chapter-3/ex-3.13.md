```
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))
```

```
(define z (make-cycle (list 'a 'b 'c)))


      +---------------------------*
      |                           |
  z --+-> [*][*] -> [*][*] -> [*][*]
           |         |         |
           v         v         v
           a         b         c
```

* `(cdr x)` が常にnil でないため、無限にlast-pair呼び出しが行われる。
